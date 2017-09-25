int[][] colorMatrix = new int[50][50];
int[][] testMatrix = new int[50][50];
int startTime = millis();
int intervalDur = 100;
boolean keyed=false;
void setup ()
{
 size(600,600);
 print("Press Space to Start, P to Pause, C to Clear.");
 println(" Draw anywhere!");
 for(int x = 0; x < 50; x++)
 {
   for(int y = 0; y < 50; y++)
   {
       colorMatrix[x][y] = 0;
   }
 }
}
 
void mousePressed () 
  { 
    if(mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0) {
      if(colorMatrix[mouseX/12][mouseY/12]==1)
      colorMatrix[mouseX/12][mouseY/12]=0;
      else
      colorMatrix[mouseX/12][mouseY/12] = 1; 
    }
  }
  void mouseDragged () 
  { 
    if(mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0)
    colorMatrix[mouseX/12][mouseY/12] = 1; 
  }


int getNeigh(int x,int y) 
{
  int num=0;
    if(x>0) {
    if(testMatrix[x-1][y]==1)
    num++;
    if(y>0)
    if(testMatrix[x-1][y-1]==1)
    num++;
    if(y<49)
    if(testMatrix[x-1][y+1]==1)
    num++;
 }
 if(x<49) {
    if(testMatrix[x+1][y]==1)
    num++;
    if(y>0)
    if(testMatrix[x+1][y-1]==1)
    num++;
    if(y<49)
    if(testMatrix[x+1][y+1]==1)
    num++;
  }
  if(y<49)
    if(testMatrix[x][y+1]==1)
    num++;
  if(y>0) 
    if(testMatrix[x][y-1]==1)
    num++;
 return num;
}
 

void changeGrid()
{
  for(int x = 0; x < 50; x++)
  {
    for(int y = 0; y < 50; y++)
    {
      testMatrix[x][y] = colorMatrix[x][y];
    }
  }
  
  for(int x = 0; x < 50; x++)
  {
    for(int y = 0; y < 50; y++)
    {
      
      if(testMatrix[x][y] == 1 && getNeigh(x,y)<2)
        colorMatrix[x][y] = 0;
      else if(testMatrix[x][y] == 1 && getNeigh(x,y)>3)
        colorMatrix[x][y] = 0;
      else if(testMatrix[x][y] == 0 && getNeigh(x,y)==3)
        colorMatrix[x][y] = 1;
    }
  }
}

void draw()
{    
  if(millis() - startTime >= intervalDur)
  {
    for(int x = 0; x < 600; x+=12)
    {
      for(int y = 0; y < 600; y+=12)
      {
        if(colorMatrix[x/12][y/12] == 1)
          fill(0);
        else
          fill(225);
        rect(x,y,12,12);
      }
    }
    if(keyPressed==true)
      keyed=true;
    if(keyed==true && key!='p' && key==' ') {
    changeGrid();
    startTime = millis();
    }
      else if(key=='c')
      {
         for(int x = 0; x < 50; x++)
         {
           for(int y = 0; y < 50; y++)
           {
             colorMatrix[x][y]=0;
             key = 'p';
           }
         }
      }
  }
}
 
