import javax.swing.JOptionPane;
int[][] colorMatrix = new int[14][14];
int[][] testMatrix = new int[14][14];
int[] obj = new int[8];
int[] val = new int[4];
int startTime = millis();
int intervalDur = 100;
boolean keyed=false;
PImage img;
int a=2;
int b=2;
void setup ()
{
  size(700, 700);
  img = loadImage("poro.PNG");
  for (int x = 0; x < 14; x++)
  {
    for (int y = 0; y < 14; y++)
    {
      colorMatrix[x][y] = 0;
    }
  }
  for (int n=0; n<14; n++)
    colorMatrix[n][0]=1;
  for (int n=0; n<14; n++)
    colorMatrix[n][13]=1;
  for (int n=1; n<13; n++)
    colorMatrix[0][n]=1;
  for (int n=1; n<13; n++)
    colorMatrix[13][n]=1;
  colorMatrix[a][b]=2;
  colorMatrix[0][0]=3;
  colorMatrix[0][1]=3;
  for (int x=0; x<8; x++)
    obj[x]=0;
  for (int x=0; x<4; x++)
    val[x]=0;

}

void mousePressed () 
{ 
  if (mouseX<650 && mouseY<650 && mouseX>50 && mouseY>50 && colorMatrix[mouseX/50][mouseY/50]!=2) {
    if (colorMatrix[mouseX/50][mouseY/50]==1)
      colorMatrix[mouseX/50][mouseY/50]=0;
    else
      colorMatrix[mouseX/50][mouseY/50] = 1;
  }
}
void mouseDragged () 
{ 
  if (mouseX<700 && mouseY<700 && mouseX>0 && mouseY>0 && colorMatrix[mouseX/50][mouseY/50]!=2)
    colorMatrix[mouseX/50][mouseY/50] = 1;
}


void getNeigh()
{
  for (int n=0; n<8; n++)
    obj[n]=0;
  if (a>0) {
    if (testMatrix[a-1][b]==1)
      obj[7]=1;
    if (testMatrix[a-1][b]==3)
      obj[7]=2;
    if (b>0)
      if (testMatrix[a-1][b-1]==1)
        obj[0]=1;
    if (b<49)
      if (testMatrix[a-1][b+1]==1)
        obj[6]=1;
  }
  if (a<49) {
    if (testMatrix[a+1][b]==1)
      obj[3]=1;
    if (testMatrix[a+1][b]==3)
      obj[3]=2;
    if (b>0)
      if (testMatrix[a+1][b-1]==1)
        obj[2]=1;
    if (b<49)
      if (testMatrix[a+1][b+1]==1)
        obj[4]=1;
  }
  if (b<49)
    if (testMatrix[a][b+1]==1)
      obj[5]=1;
  if (b<49)
    if (testMatrix[a][b+1]==3)
      obj[5]=2;
  if (b>0) 
    if (testMatrix[a][b-1]==1)
      obj[1]=1;
  if (b>0)
    if (testMatrix[a][b-1]==3)
      obj[1]=2;
}
void sense() {
  for (int x=0; x<4; x++)
  val[x]=0;
  if (obj[1]==1||obj[2]==1)
    val[0]=1;
  if (obj[3]==1||obj[4]==1)
    val[1]=1;
  if (obj[5]==1||obj[6]==1)
    val[2]=1;
  if (obj[7]==1||obj[0]==1)
    val[3]=1;
}

void changeGrid()
{
  for (int x = 0; x < 14; x++)
  {
    for (int y = 0; y < 14; y++)
    {
      testMatrix[x][y] = colorMatrix[x][y];
    }
  }
  getNeigh();
  sense();
  if (val[0]!=1&&val[1]!=1&&val[2]!=1&&val[3]!=1) {
    colorMatrix[a][b]=0;
    b--;
  } else if (val[0]==1&&val[1]==0) {
    colorMatrix[a][b]=0;
    a++;
  } else if (val[1]==1&&val[2]==0) {
    colorMatrix[a][b]=0;
    b++;
  } else if (val[2]==1&&val[3]==0) {
    colorMatrix[a][b]=0;
    a--;
  } else if (val[3]==1&&val[0]==0) {
    colorMatrix[a][b]=0;
    b--;
  }
  colorMatrix[a][b]=2;
  
   if(obj[1]==2||obj[3]==2||obj[5]==2||obj[7]==2) {
   JOptionPane.showMessageDialog(frame,"GameOver");
    exit();
   }
}

void draw()
{    
  if (millis() - startTime >= intervalDur)
  {
    for (int x = 0; x < 700; x+=50)
    {
      for (int y = 0; y < 700; y+=50)
      {
        if (colorMatrix[x/50][y/50] == 1)
          fill(50); 
          else if (colorMatrix[x/50][y/50] == 3)
          fill(150, 200, 0);
        else
          fill(225);
        rect(x, y, 50, 50);
      }
    }
    image(img,a*50+1,b*50+1);
    if (keyPressed==true)
      keyed=true;
    if (keyed==true && key!='p' && key==' ') {
      changeGrid();
      startTime = millis();
    } else if (key=='c')
    {
      for (int x = 0; x < 14; x++)
      {
        for (int y = 0; y < 14; y++)
        {
          colorMatrix[x][y]=0;
        }
      }
      colorMatrix[a][b]=2;
      key = 'p';
      for (int n=0; n<14; n++)
        colorMatrix[n][0]=1;
      for (int n=0; n<14; n++)
        colorMatrix[n][13]=1;
      for (int n=1; n<13; n++)
        colorMatrix[0][n]=1;
      for (int n=1; n<13; n++)
        colorMatrix[13][n]=1;
    }
  }
}

