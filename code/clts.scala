import fes.bounds.GaussianCRB
import fes.bounds.AngularLeastSquaresCLT
import pubsim.distributions.circular.ProjectedNormalDistribution

val Ns = List(16,64,256,512,1024)  //number of observations
val snrs = -20.0 to 21.0 by 0.4 //range of signal to noise ratios

for(N <- Ns){  
  
  val aslfile = new java.io.FileWriter("data/asymp" + N + ".txt")
  val crbfile = new java.io.FileWriter("data/crb" + N + ".txt")
  
  print("unwrapping CLT N = " + N + " ")
  for(snr <- snrs){
    val v = 0.5/scala.math.pow(10, snr/10.0)
    val mse = new AngularLeastSquaresCLT(new ProjectedNormalDistribution(0,v)).getBound(N)
    aslfile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    print(".")
  }
  aslfile.close
  println(" finished.")

  print("Gaussian CRB N = " + N + " ")
  for(snr <- snrs){
    val v = 0.5/scala.math.pow(10, snr/10.0)
    val mse = GaussianCRB.getBound(v, N)
    crbfile.write(snr + "\t" + mse.toString.replace('E', 'e') + "\n")
    print(".")
  }
  crbfile.close
  println(" finished.")

}
