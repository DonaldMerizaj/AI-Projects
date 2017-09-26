public class Perceptron
{
    double[] w;
    double[] x;
    double target;
    double o = 0.0;
    Perceptron (int size) {
        x=new double[size+1];
        w=new double[size+1];
        for(int i=0; i<size+1;i++) {
            w[i]=0.2;
        }
        w[0]=0;
    }
    void setWeights(double[] rhs) { 
        this.w=rhs;
    }
    void setInputs (double[] rhs) {   
        this.x=rhs;
    }
    void setTarget (double rhs){
        this.target = rhs;
    }
    void train (double[][] set, double rate) {
        int epoch =0;
        double error =999;
        //System.out.println("w before training: "+w[0]+" "+w[1]+" "+w[2]);
        while(epoch<100 && error > 0.0001) {
            epoch++;
            error=0;
            for(double[] d : set) {
                double t=d[d.length-1];
                double[] inputs = new double[36];
                for(int n=1;n<36;n++) {
                    inputs[n]=d[n];
                }
                inputs[0]=-1;
                setInputs(inputs);
                o=activate();
                //System.out.println("output: "+o);
                error+=Math.abs(t-o);
                int i=0;
                while(i<w.length) {
                    w[i]=w[i]+ (rate*(t-o)*x[i]);
                    i++;
                }
            }
            //System.out.println("epoch: "+epoch);
            //System.out.println("error: "+error);
            //System.out.println("w: "+w[0]+" "+w[1]+" "+w[2]);
        }
    }
    double activate () {
        // complete implementation
       double sum = 0.0;
       // activate function. That is sum 
       // inputs x weights
       for(int n=0;n<w.length;n++) {
           sum+=w[n]*x[n];
        }
       o=0.0;
        //threshold=w[0];
       // if the output  >  than threshold output 1
       if(sum>0)
            o=1.0;
        else
            o=0.0;
       
       // otherwise the output is 0
       return o;
    }
}
