/**
* Script for running frequency estimation simulations.
*/
import pubsim.distributions.circular.CircularRandomVariable
import pubsim.distributions.circular.WrappedUniform
import pubsim.distributions.circular.WrappedGaussian
import pubsim.distributions.GaussianNoise
import pubsim.fes.NoisyComplexSinusoid
import pubsim.fes.SamplingLatticeEstimator
import pubsim.fes.ZnLLS
import pubsim.fes.PeriodogramFFTEstimator
import pubsim.fes.PSCFDEstimator
import pubsim.fes.KaysEstimator
import pubsim.fes.QuinnFernades
import pubsim.Util._

//function returns a tuple with random frequency in the interval [-0.5,0.5]^2 
def randparams = {
  val rand = new scala.util.Random
  (rand.nextDouble - 0.5, rand.nextDouble - 0.5)
}

val Ns = List(16,256,512,1024) //number of observations
val iters = 10 //number of iterations to run for each variance

//range of signal to noise ratios
val snrs = Range(-20, 21, 2)

for(N <- Ns ){

  val siggen =  new NoisyComplexSinusoid(N) //noisy single frequency signal generated with complex noise

  //list of estimators we will simulate
  val ests = List(
    //ZnLLS is the O(N^3log(N)) algorithm that exactly computes the least squares phase unwrapping
    //it's too slow for these simulations so we use the approximate SamplingLatticeEstimator instead
    //in practice the performance between these is indistinguishable.  This SamplingLatticeEstimator
    //is still VERY slow compared to the other estimators!
    //new ZnLLS(N) 
    new SamplingLatticeEstimator(N, 12*N),
    new PeriodogramFFTEstimator(N),
    new PSCFDEstimator(N),
    new KaysEstimator(N),
    new QuinnFernades(N)
  )

  for(est <- ests){
    val efname = est.getClass.getSimpleName + "" + N
    val efile = new java.io.FileWriter(Tfname)

    println("var \t mse")
    val starttime = (new java.util.Date).getTime
    for(snr <- snrs){      
      siggen.setNoiseGenerator( new GaussianNoise(0, 0.5/scala.math.pow(10, snr/10.0)) )
      
      //compute the mses
      val msetotal = (1 to iters).map{ i => 
	val (f, p) = randparams
	siggen.setFrequency(f)
	siggen.setPhase(p)
	siggen.generateReceivedSignal
	val fhat:Double = est.estimateFreq(siggen.getReal, siggen.getImag)
	fracpart(fhat - f)*fracpart(fhat - f)
      }.foldLeft(0.0)( _ + _)
      
      val mse = msetotal/iters
      println(snr  + "\t" + mse.toString.replace('E', 'e'))
      Tfile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    }
    val runtime = (new java.util.Date).getTime - starttime
    println(est.getClass.getSimpleName + " with N = " + N + " finished in " + (runtime/1000.0) + " seconds.\n") 
    Tfile.close

  }

}
