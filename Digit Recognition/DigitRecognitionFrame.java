/**
 * 
 */
 

import java.util.ArrayList;

import java.awt.HeadlessException;
import javax.swing.JFrame;

/**
 * @author delgadomatac

 */



public class DigitRecognitionFrame extends JFrame {

    /**
     * 
     */
    private static final long serialVersionUID = -8688901065711771599L;
    /**
     * 
     */

    private javax.swing.JButton m_addNoiseButton;
    private javax.swing.JButton m_classifyButton;
    private javax.swing.JButton m_clearButton;
    private javax.swing.JButton m_trainButton;
    private javax.swing.JButton m_generateButton;
    private DigitRecognitionPanel m_outputPanel;
    private javax.swing.JPanel m_digitsPanel;

    private javax.swing.JPanel m_mainPanel;
    private DigitRecognitionPanel m_inputPanel;
    private javax.swing.JPanel m_toolbarPanel;
    private DigitRecognitionPanel [] digitPanels;
    
    public static final int NUM_DIGITS =10;
    /**
     * @throws HeadlessException
     */
    
    static final double[] ONE   = { 0,1,1,0,0,
        0,0,1,0,0,
        0,0,1,0,0,
        0,0,1,0,0,
        0,0,1,0,0,
        0,0,1,0,0,
        1,1,1,1,1 };
    static final double[] TWO   = { 0,1,1,1,0,
        1,0,0,0,1,
        0,0,0,1,0,
        0,0,1,0,0,
        0,1,0,0,0,
        1,0,0,0,0,
        1,1,1,1,1 };
    static final double[] THREE = { 0,1,1,1,0,
        1,0,0,0,1,
        0,0,0,0,1,
        0,0,1,1,0,
        0,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0 };
    static final double[] FOUR  = { 0,0,1,1,0,
        0,1,0,1,0,
        0,1,0,1,0,
        1,0,0,1,0,
        1,1,1,1,1,
        0,0,0,1,0,
        0,0,0,1,0 };
    static final double[] FIVE  = { 1,1,1,1,1,
        1,0,0,0,0,
        1,1,1,1,0,
        0,0,0,0,1,
        0,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0 };
   static final double[] SIX   = { 0,0,1,1,1,
        0,1,0,0,0,
        1,1,1,1,0,
        1,0,0,0,1,
        1,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0 };
   static final double[] SEVEN = { 1,1,1,1,1,
        0,0,0,0,1,
        0,0,0,1,0,
        0,0,1,0,0,
        0,0,1,0,0,
        0,1,0,0,0,
        0,1,0,0,0 };
   static final double[] EIGHT = { 0,1,1,1,0,
        1,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0,
        1,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0 };
   static final double[] NINE  = { 0,1,1,1,0,
        1,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,1,
        0,0,0,0,1,
        0,0,0,1,0,
        0,1,1,0,0 };
   static final double[] ZERO  = { 0,1,1,1,0,
        1,0,0,0,1,
        1,0,0,0,1,
        1,0,0,0,1,
        1,0,0,0,1,
        1,0,0,0,1,
        0,1,1,1,0 };
   static final double[] ERROR  = { 
       0,1,1,1,1,
       1,0,0,0,0,
       1,0,0,0,0,
       0,1,1,1,0,
       1,0,0,0,0,
       1,0,0,0,0,
       0,1,1,1,1 };
   static final public double[] [] DIGITS = 
     { ZERO, ONE, TWO,   THREE, FOUR, 
       FIVE, SIX, SEVEN, EIGHT, NINE };
            double rate = 0.1;
           double[][] ds1 = new double[300][36];
           Perceptron gate1 = new Perceptron(35);
           Perceptron gate2 = new Perceptron(35);
           Perceptron gate3 = new Perceptron(35);
           Perceptron gate4 = new Perceptron(35);
           Perceptron gate5 = new Perceptron(35);
           Perceptron gate6 = new Perceptron(35);
           Perceptron gate7 = new Perceptron(35);
           Perceptron gate8 = new Perceptron(35);
           Perceptron gate9 = new Perceptron(35);
           Perceptron gate10 = new Perceptron(35);
    public DigitRecognitionFrame() throws HeadlessException {
        // TODO Auto-generated constructor stub
    }


    /**
     * @param arg0
     * @throws HeadlessException
     */
    
    

    public DigitRecognitionFrame(String arg0) throws HeadlessException {
        super(arg0);
        // TODO Auto-generated constructor stub
        initComponents();
    }

    
    public void initComponents () {

        m_classifyButton = new javax.swing.JButton();
        m_clearButton = new javax.swing.JButton();
        m_addNoiseButton = new javax.swing.JButton();
        m_trainButton = new javax.swing.JButton();
        m_generateButton = new javax.swing.JButton();
        m_outputPanel = new DigitRecognitionPanel(DigitRecognitionPanel.NORMAL_SIZE);
        m_digitsPanel = new javax.swing.JPanel();

        m_mainPanel = new javax.swing.JPanel();
        m_inputPanel = new DigitRecognitionPanel(DigitRecognitionPanel.NORMAL_SIZE);
        m_toolbarPanel = new javax.swing.JPanel();
        
        digitPanels = new DigitRecognitionPanel [NUM_DIGITS];
        for (int k= 0; k< digitPanels.length; k++) {
            digitPanels [k] = new DigitRecognitionPanel (DigitRecognitionPanel.THUMBNAIL_SIZE);
            digitPanels [k].setDigit(DIGITS[k]);
        }
        
        m_digitsPanel.setPreferredSize(new java.awt.Dimension(200, 60));
        getContentPane().add(m_digitsPanel, java.awt.BorderLayout.SOUTH);
        
        m_mainPanel.setLayout(new java.awt.BorderLayout());

        m_inputPanel.setLayout(null);

        m_inputPanel.setPreferredSize(new java.awt.Dimension((5+1)*25,(7+1)*25));
        m_mainPanel.add(m_inputPanel, java.awt.BorderLayout.WEST);

        m_toolbarPanel.setLayout(new java.awt.FlowLayout(java.awt.FlowLayout.CENTER, 5, 10));

        m_toolbarPanel.setMinimumSize(new java.awt.Dimension(100, 500));
        m_toolbarPanel.setPreferredSize(new java.awt.Dimension(100, 300));        


        m_generateButton.setText("Generate");
        m_generateButton.setMaximumSize(new java.awt.Dimension(85, 23));
        m_generateButton.setPreferredSize(new java.awt.Dimension(85, 23));
        m_generateButton.setMargin(new java.awt.Insets(2, 10, 2, 10));
        m_generateButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                generateButtonActionPerformed(evt);
            }
        });        
        m_toolbarPanel.add(m_generateButton);
        m_trainButton.setText("Train");
        m_trainButton.setMaximumSize(new java.awt.Dimension(85, 23));
        m_trainButton.setPreferredSize(new java.awt.Dimension(85, 23));
        m_trainButton.setMargin(new java.awt.Insets(2, 10, 2, 10));
        m_trainButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                trainButtonActionPerformed(evt);
            }
        });
        m_toolbarPanel.add(m_trainButton);
        
      
        m_classifyButton.setText("Classify");
        m_classifyButton.setMargin(new java.awt.Insets(2, 10, 2, 10));
        m_classifyButton.setPreferredSize(new java.awt.Dimension(85, 23));
        m_classifyButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                classifyButtonActionPerformed(evt);
            }
        });

        m_toolbarPanel.add(m_classifyButton);

        m_addNoiseButton.setText("Add Noise");
        m_addNoiseButton.setMargin(new java.awt.Insets(2, 10, 2, 10));
        m_addNoiseButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addNoiseButtonActionPerformed(evt);
            }
        });
        m_toolbarPanel.add(m_addNoiseButton);           
        
        m_clearButton.setText("Clear");
        m_clearButton.setMaximumSize(new java.awt.Dimension(85, 23));
        m_clearButton.setPreferredSize(new java.awt.Dimension(85, 23));
        m_clearButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                clearButtonActionPerformed(evt);
            }
        });

        m_toolbarPanel.add(m_clearButton);

     

        
        // The digit Panels
        for (int k= 0; k< digitPanels.length; k++) {
            digitPanels[k].setLayout(null);

            digitPanels[k].setPreferredSize(new java.awt.Dimension(35,50));
            digitPanels[k].addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    digitsPanelMouseClicked(evt);
                }
            });

            m_digitsPanel.add(digitPanels[k]);
        }
        
        


        m_mainPanel.add(m_toolbarPanel, java.awt.BorderLayout.CENTER);        
        


        m_outputPanel.setLayout(new java.awt.BorderLayout());

        m_outputPanel.setPreferredSize(new java.awt.Dimension((5+1)*25,(7+1)*25));
        m_mainPanel.add(m_outputPanel, java.awt.BorderLayout.EAST);

        getContentPane().add(m_mainPanel, java.awt.BorderLayout.CENTER);

        pack();   
    }

    private void generateButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_classifyButtonActionPerformed

        // Here  add your code to classify.
    // Run the input through the ten perceptrons.
    // Choose the one selected 
    //just for testing sake.

    int x=0;
    for(int i=0; i<10; i++) {
        for(int n=0; n<30; n++) {
            //m_inputPanel.clear();
            //m_inputPanel.setDigit(DIGITS[i]);
            //for(int p=0;p<n;p++) {
            //    m_inputPanel.addNoise(0.10);
            //}
            double[] temp = new double[35];
            temp=DIGITS[i];
                for (int k=0; k< temp.length; k++) {
                    if (Math.random() < n*0.01) {
                        if (temp[k] == 0) 
                            temp[k] += Math.random();
                        else
                            temp[k] -= (Math.random() * temp[k]);
                    }
                }
          
            //temp=m_inputPanel.getDigit();
            for(int a=0;a<35;a++) {
                ds1[x][a]=temp[a];
            }
            x++;
            //m_inputPanel.repaint();
        }
    }
    //System.out.println(x);
    //System.out.println(ds1[299][34]);
    for(int i=0;i<300;i++) {
        ds1[i][35]=0;
    }
    javax.swing.JOptionPane.showMessageDialog(this, "Data Generated!");
    //m_outputPanel.clear();
   }

    
    private void classifyButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_classifyButtonActionPerformed

         // Here add your code to classify.
        // Run the input through all ten perceptrons.
        // Choose the one selected 
        double[] temp = new double[35];
        temp=m_inputPanel.getDigit();
        double[] testdata = new double[36];
        testdata[0]=-1;
        for(int i=1;i<36;i++) {
            testdata[i]=temp[i-1];
        }
        gate1.setInputs(testdata);
        gate2.setInputs(testdata);
        gate3.setInputs(testdata);
        gate4.setInputs(testdata);
        gate5.setInputs(testdata);
        gate6.setInputs(testdata);
        gate7.setInputs(testdata);
        gate8.setInputs(testdata);
        gate9.setInputs(testdata);
        gate10.setInputs(testdata);
        ArrayList<Perceptron> gate = new ArrayList<Perceptron>();
        gate.add(gate1);
        gate.add(gate2);
        gate.add(gate3);
        gate.add(gate4);
        gate.add(gate5);
        gate.add(gate6);
        gate.add(gate7);
        gate.add(gate8);
        gate.add(gate9);
        gate.add(gate10);
        //double min = Math.abs(1-gate1.activate());
        //int num = 0;
        /*
        for(int a=0;a<10;a++) {
            if(Math.abs(1-gate.get(a).activate())<min) {
                min=Math.abs(1-gate.get(a).activate());
                num = a;
            }
        }
        System.out.println(num);
        */
        
        if(gate1.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[0]);
            System.out.println("0");
        }
        else if(gate2.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[1]);
            System.out.println("1");
        }
        else if(gate3.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[2]);
            System.out.println("2");
        }
        else if(gate4.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[3]);
            System.out.println("3");
        }
        else if(gate5.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[4]);
            System.out.println("4");
        }
        else if(gate6.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[5]);
            System.out.println("5");
        }
        else if(gate7.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[6]);
            System.out.println("6");
        }
        else if(gate8.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[7]);
            System.out.println("7");
        }
        else if(gate9.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[8]);
            System.out.println("8");
        }
        else if(gate10.activate()==1) {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(DIGITS[9]);
            System.out.println("9");
        }
        else {
            m_outputPanel.clear();
            m_outputPanel.repaint();
            m_outputPanel.setDigit(ERROR);
            System.out.println("Error");
        }
        
        //Next line just for testing sake.
        
        //m_outputPanel.setDigit(ERROR);
        //m_outputPanel.repaint();
        javax.swing.JOptionPane.showMessageDialog(this, "Classified!");
        //m_outputPanel.clear();
    }

    private void clearButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_clearButtonActionPerformed
        m_inputPanel.clear();
        m_inputPanel.repaint();
        m_outputPanel.clear();
        m_outputPanel.repaint();
    }

    private void addNoiseButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addNoiseButtonActionPerformed
        m_inputPanel.addNoise(0.10);
        m_inputPanel.repaint();
    }

    private void trainButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addNoiseButtonActionPerformed
        // Here add your code to Train the 10 perceptrons OK.
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=0; x<30; x++) {
            ds1[x][35]=1;
        }
        gate1.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=30; x<60; x++) {
            ds1[x][35]=1;
        }
        gate2.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=60; x<90; x++) {
            ds1[x][35]=1;
        }
        gate3.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=90; x<120; x++) {
            ds1[x][35]=1;
        }
        gate4.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=120; x<150; x++) {
            ds1[x][35]=1;
        }
        gate5.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=150; x<180; x++) {
            ds1[x][35]=1;
        }
        gate6.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=180; x<210; x++) {
            ds1[x][35]=1;
        }
        gate7.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=210; x<240; x++) {
            ds1[x][35]=1;
        }
        gate8.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=240; x<270; x++) {
            ds1[x][35]=1;
        }
        gate9.train(ds1, rate);
        for(int i=0;i<300;i++) {
            ds1[i][35]=0;
        }
        for(int x=270; x<300; x++) {
            ds1[x][35]=1;
        }
        gate10.train(ds1, rate);
        javax.swing.JOptionPane.showMessageDialog(this, "Trained!");
    }  
    
    private void digitsPanelMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_templateMouseClicked
        DigitRecognitionPanel src = (DigitRecognitionPanel)evt.getSource();

        m_inputPanel.setDigit(src.getDigit());
        m_inputPanel.repaint();
    }
}
