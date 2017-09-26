import java.awt.Color;
import java.util.Arrays;
import org.neuroph.core.NeuralNetwork;
import org.neuroph.nnet.MultiLayerPerceptron;
import org.neuroph.core.data.DataSet;
import org.neuroph.core.data.DataSetRow;
import org.neuroph.util.TransferFunctionType;
import org.neuroph.nnet.learning.BackPropagation;

public class Football

{
    public static void main (String args[]) {
        BackPropagation rule = new BackPropagation ();
        rule.setMaxError (0.0000001);  // Change this value to show my Students iteration and Max error 
        rule.setMaxIterations(10000);
        rule.setLearningRate(0.7);
        int inputsCount = 8;
        int outputsCount = 3;
        DataSet trainingSet = new DataSet(8, 3);
        DataSet testSet = new DataSet(8, 3);
        trainingSet.addRow(new DataSetRow(new double[]{0.5,0.1875,0.0556,0.7797,0.0,0.0,0.3241,0.3729}, new double[]{0.0,1.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.75,0.5,0.4722,0.435,0.8125,0.4688,0.088,0.8475}, new double[]{0.0,1.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5625,0.4219,0.4537,0.3785,0.375,0.3594,0.4306,0.4237}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.875,0.9844,0.6019,0.5424,0.625,0.0625,0.0,0.8023}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5625,0.4063,0.4491,0.4463,0.375,0.4844,0.4815,0.4068}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.625,0.7656,0.1528,1.0,1.0,0.7344,0.5417,0.4802}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.625,0.0625,0.0,0.8023,0.5,0.1875,0.0556,0.7797}, new double[]{0.0,1.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.8125,0.4688,0.088,0.8475,0.5625,0.4219,0.4537,0.3785}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5625,0.4531,0.4398,0.4124,0.875,0.9844,0.6019,0.5424}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.8125,0.4688,0.088,0.8475,0.375,0.3594,0.4306,0.4237}, new double[]{0.0,1.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5,0.1875,0.0556,0.7797,0.25,0.1719,0.0556,0.8531}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{1.0,0.9375,0.1806,0.9718,0.0,0.0,0.3241,0.3729}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5625,0.4219,0.4537,0.3785,0.75,0.5625,0.8333,0.0}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.75,0.625,1.0,0.0169,0.875,0.9844,0.6019,0.5424}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.6875,1.0,0.5556,0.5311,0.625,0.7656,0.1528,1.0}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.5625,0.4063,0.4491,0.4463,1.0,0.9375,0.1806,0.9718}, new double[]{0.0,0.0,1.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.4375,0.5156,0.4352,0.4237,1.0,0.7344,0.5417,0.4802}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.75,0.5625,0.8333,0.0,0.8125,0.4688,0.088,0.8475}, new double[]{0.0,1.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.625,0.7656,0.1528,1.0,0.625,0.0625,0.0,0.8023}, new double[]{1.0,0.0,0.0}));
        trainingSet.addRow(new DataSetRow(new double[]{0.625,0.0625,0.0,0.8023,0.5625,0.2813,0.4167,0.4181}, new double[]{1.0,0.0,0.0}));
        testSet.addRow(new DataSetRow(new double[]{0.5625,0.4531,0.4398,0.4124,0.0,0.0,0.3241,0.3729}, new double[]{0.0,0.0,1.0}));
        testSet.addRow(new DataSetRow(new double[]{0.75,0.5,0.4722,0.435,0.875,0.9844,0.6019,0.5424}, new double[]{0.0,1.0,0.0}));
        testSet.addRow(new DataSetRow(new double[]{0.5,0.1875,0.0556,0.7797,0.75,0.625,1.0,0.0169}, new double[]{0.0,0.0,1.0}));
        testSet.addRow(new DataSetRow(new double[]{1.0,0.7344,0.5417,0.4802,0.375,0.3594,0.4306,0.4237}, new double[]{1.0,0.0,0.0}));
        testSet.addRow(new DataSetRow(new double[]{0.4375,0.5156,0.4352,0.4237,0.6875,1.0,0.5556,0.5311}, new double[]{0.0,1.0,0.0}));
        testSet.addRow(new DataSetRow(new double[]{0.375,0.3594,0.4306,0.4237,0.375,0.4844,0.4815,0.4068}, new double[]{0.0,0.0,1.0}));
        testSet.addRow(new DataSetRow(new double[]{0.5625,0.4531,0.4398,0.4124,1.0,0.9375,0.1806,0.9718}, new double[]{0.0,0.0,1.0}));
        testSet.addRow(new DataSetRow(new double[]{0.625,0.0625,0.0,0.8023,0.4375,0.5156,0.4352,0.4237}, new double[]{1.0,0.0,0.0}));
        testSet.addRow(new DataSetRow(new double[]{0.5,0.1875,0.0556,0.7797,0.5625,0.4531,0.4398,0.4124}, new double[]{0.0,0.0,1.0}));
        //trainingSet.addRow(new DataSetRow(new double[]{1, 1}, new double[]{0}));
        
        
        //trainingSet.addRow(new DataSetRow(new double[]{1, 1}, new double[]{0}));
        // create multi layer perceptron
        MultiLayerPerceptron perceptron = new MultiLayerPerceptron(TransferFunctionType.SIGMOID, 8, 30, 3);
        //System.out.println("hi2");
        // learn the training set
        perceptron.learn(trainingSet, rule);
        //System.out.println("hi3");
        System.out.println("Output attributes are: Home team wins, Draw, Visitor team wins");
        for(DataSetRow dataRow : testSet.getRows()) {
           
            perceptron.setInput(dataRow.getInput());
            perceptron.calculate();
            double[] output = perceptron.getOutput();
            for(int a=0;a<3;a++) {
                if(output[a]>0.5)
                    output[a]=1;
                else
                    output[a]=0;
            }
            System.out.print("Input: " + Arrays.toString(dataRow.getInput()));
            System.out.println(" Output: " + Arrays.toString(output));

    
        }
    }
}
