import java.awt.Color;
public class Gates

{
    public static void main (String args[]) {
        StdDraw.setCanvasSize(600, 600);
        int size=5000;
        double w=6;
        double s=5;
        double r=10;
        double d=-2; //positive will have error, negative with no error: distrance between both moons
        double learn=0.3;
        int it =0;
        double error;
        Perceptron gate = new Perceptron(2);
        double[][] ds = new double[size][3];
        double[][] test = new double[size][3];
        double scale = 1.0/40.0;
        //StdDraw.setPenColor (Color.BLACK);
        StdDraw.line (0.5, 0, 0.5, 1);
        StdDraw.line (0, 0.5, 1, 0.5);
        

        for (int i = 0; i<size; i++) {
            if(Math.random()>0.5) {
                double angle = Math.random()*Math.PI;
                double rad = w*Math.random()+s;
                ds[i]=(new double[] {rad*Math.cos(angle), rad*Math.sin(angle), 1});
           } else {
                double angle = Math.random()*Math.PI;
                double rad = w*Math.random()+s;
                ds[i]=(new double[] {rad*Math.cos(angle)+7.5, -rad*Math.sin(angle)+d,0});
           }
        }
        gate.train(ds, 0.2);
        for(double[] a : ds) {
            gate.setInputs(new double[] {-1,a[0],a[1]});
            //System.out.println("Input: "+a[0]+" "+a[1]+" "+gate.activate());
        }

        for (int i = 0; i<size; i++) {
            if(Math.random()>0.5) {
                double angle = Math.random()*Math.PI;
                double rad = w*Math.random()+s;
                test[i]=(new double[] {rad*Math.cos(angle), rad*Math.sin(angle),0});
           } else {
                double angle = Math.random()*Math.PI;
                double rad = w*Math.random()+s;
                test[i]=(new double[] {(rad*Math.cos(angle))+7.5, -rad*Math.sin(angle)+d,0});
           }
        }
        for(double[] a : test) {
            gate.setInputs(new double[] {-1,a[0],a[1]});
            if (gate.activate() == 0.0){
               StdDraw.setPenColor (Color.BLUE);
            }
            else {
               StdDraw.setPenColor (Color.BLACK);
            }
           StdDraw.point(scale*gate.x[1]+0.5, scale*gate.x[2]+0.5);
        }
    }
}
