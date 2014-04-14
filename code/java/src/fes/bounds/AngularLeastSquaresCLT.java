package fes.bounds;

import pubsim.distributions.circular.CircularRandomVariable;

/**
 * Asymptotic variance of the least squares phase unwrapping
 * algorithm.
 * @author Robby McKilliam
 */
public class AngularLeastSquaresCLT {

    private final double unwrpvar;
    private final double h;

    /** Constructor.  The amplitude defaults to 1. */
    public AngularLeastSquaresCLT(CircularRandomVariable circdist){
        h = circdist.pdf(0.5);
        unwrpvar = circdist.intrinsicVariance();
    }

    public double getBound(int N) {
        return 12.0*unwrpvar/((1-h)*(1-h))/Math.pow(N,3.0);
    }

}
