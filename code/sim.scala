/**
* Script for running frequency estimation simulations.
*/
import pubsim.distributions.circular.CircularRandomVariable
import pubsim.distributions.circular.WrappedUniform
import pubsim.distributions.circular.WrappedGaussian
import pubsim.distributions.GaussianNoise
import fes.NoisyComplexSinusoid
import fes.SamplingLatticeEstimator
import fes.ZnLLS
import fes.PeriodogramFFTEstimator
import fes.PSCFDEstimator
import fes.KaysEstimator
import fes.QuinnFernades
import pubsim.Util._

//function returns a tuple with random frequency in the interval [-0.5,0.5]^2 
def randparams = {
  val rand = new scala.util.Random
  (rand.nextDouble - 0.5, rand.nextDouble - 0.5)
}

val Ns = List(16,64,256,512,1024) //number of observations
val iters = 1000 //number of iterations to run for each variance

//range of signal to noise ratios
val snrs = -20.0 to 21.0 by 2.0

for(N <- Ns ){

  //list of estimators we will simulate
  val ests = List(
    //ZnLLS is the O(N^3log(N)) algorithm that exactly computes the least squares phase unwrapping
    //it's too slow for these simulations so we use the approximate SamplingLatticeEstimator instead
    //in practice the performance between these is indistinguishable.  This SamplingLatticeEstimator
    //is still VERY slow compared to the other estimators!
    //() => new ZnLLS(N) 
    () => new SamplingLatticeEstimator(N, 12*N),
    () => new PeriodogramFFTEstimator(N),
    () => new PSCFDEstimator(N),
    () => new KaysEstimator(N),
    () => new QuinnFernades(N)
  )

  for(estf <- ests){
    val ename = estf().getClass.getSimpleName
    print(ename + " N = " + N + " ")
    val starttime = (new java.util.Date).getTime

    //run for each snr in parallel threads
    val mselist = snrs.par.map{ snr =>       
      val siggen =  new NoisyComplexSinusoid(N) //noisy single frequency signal generated with complex noise
      siggen.setNoiseGenerator( new GaussianNoise(0, 0.5/scala.math.pow(10, snr/10.0)) )
      val est = estf() //construct an estimator
      //compute the mse
      val msetotal = (1 to iters).map{ i => 
	val (f, p) = randparams
	siggen.setFrequency(f)
	siggen.setPhase(p)
	siggen.generateReceivedSignal
	val fhat:Double = est.estimateFreq(siggen.getReal, siggen.getImag)
	fracpart(fhat - f)*fracpart(fhat - f)
      }.foldLeft(0.0)(_+ _)
      print(".")   
      msetotal/iters //return mean square error
    }.toList

    val efile = new java.io.FileWriter("data/" + ename + "" + N)
    (mselist, snrs).zipped.map{ (mse, snr) => 
      efile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    }
    efile.close

    val runtime = (new java.util.Date).getTime - starttime
    println(" finished in " + (runtime/1000.0) + " seconds.") 
  }

}
