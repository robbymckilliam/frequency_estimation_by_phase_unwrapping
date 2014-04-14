import pubsim.fes.bounds.GaussianCRB
import pubsim.fes.bounds.AngularLeastSquaresCLT
import pubsim.distributions.circular.ProjectedNormalDistribution

val Ns = List(16,64,256,512,1024)  //number of observations
val snrs = Range(-20, 21, 2) //range of signal to noise ratios

for(N <- Ns){  
  
  val aslfile = new java.io.FileWriter("asymp" + N + ".txt")
  val crbfile = new java.io.FileWriter("crb" + N + ".txt")
  
  println("snr \t unwrapping CLT with N = " + N)
  for(snr <- snrs){
    val v = 0.5/scala.math.pow(10, snr/10.0)
    val mse = new AngularLeastSquaresCLT(new ProjectedNormalDistribution(0,v)).getBound(N)
    aslfile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    println(snr  + "\t" + mse.toString.replace('E', 'e'))
  }
  aslfile.close
 
  println
  println("snr \t Gaussian CRB with N = " + N)
  for(snr <- snrs){
    val v = 0.5/scala.math.pow(10, snr/10.0)
    val mse = GaussianCRB.getBound(v, N)
    crbfile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    println(snr  + "\t" + mse.toString.replace('E', 'e'))
  }
  crbfile.close
  println

}
