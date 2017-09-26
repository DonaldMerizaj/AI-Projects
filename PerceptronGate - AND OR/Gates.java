public class Gates

{
    public static void main (String args[]) {
        Perceptron gate = new Perceptron(2);
        System.out.println("===AND GATE===");
        double[][] ds = {{0,0,0},{0,1,0},{1,0,0},{1,1,1}};
        gate.train(ds, 0.2);
        for(double[] a : ds) {
            gate.setInputs(new double[] {-1,a[0],a[1]});
            System.out.println("Input: "+a[0]+" "+a[1]+" "+gate.activate());
        }
        System.out.println("AND GATE TRAINED!");
        System.out.println("===OR GATE===");
        double[][] ds2 = {{0,0,0},{0,1,1},{1,0,1},{1,1,1}};
        gate.train(ds2, 0.2);
        for(double[] a : ds2) {
            gate.setInputs(new double[] {-1,a[0],a[1]});
            System.out.println("Input: "+a[0]+" "+a[1]+" "+gate.activate());
        }
        System.out.println("OR GATE TRAINED!");
        
    }
}
