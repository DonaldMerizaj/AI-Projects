import java.util.*;
import javax.swing.JOptionPane;
int[][] grid = new int[3][3];
PImage Circle;
PImage Cross;
boolean first=false;
boolean bot=false;
boolean play=false;
boolean breaked=false;
boolean firstpress=false;
int count;
boolean pressed=true;
boolean end=false;
boolean event=false;
boolean event1=false, event2=false, event3=false, event4=false, event5=false;
int round=0;
void setup (){
  size(600, 600);
  Circle = loadImage("Circle.png");
  Cross = loadImage("Cross.png");
  String type = JOptionPane.showInputDialog("Do you want to play against the computer or another player?");
  type+=" ";
  if (type.equals("Computer ") || type.equals("computer "))
    bot=true; else if (type.equals("Player ") || type.equals("player "))
    play=true; else {     
    JOptionPane.showMessageDialog(null, "Wrong input!"); 
    exit();
  }
  for (int x = 0; x < 3; x++)
  {
    for (int y = 0; y < 3; y++)
    {
      grid[x][y] = 0;
    }
  }
}
void mousePressed () 
{ 
  //against player
  if (!pressed) {
    if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && grid[mouseX/200][mouseY/200]<1 && play) {
      if (!first)
        grid[mouseX/200][mouseY/200] = 1;
      if (first)
        grid[mouseX/200][mouseY/200] = 2;
      first=!first;
      firstpress=true;
      pressed=true;
    }
    //against computer
    if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && grid[mouseX/200][mouseY/200]<1 && bot) {
      grid[mouseX/200][mouseY/200] = 1;
      pressed=true;
      firstpress=true;
    }
  }
  round++;
}
int check() {
  for (int x=0;x<3;x++) {
    if (grid[x][0]==2 && grid[x][1]==2 && grid[x][2]==2)
      return 2;
  }
  for (int y=0;y<3;y++) {
    if (grid[0][y]==2 && grid[1][y]==2 && grid[2][y]==2)
      return 2;
  }
  if (grid[0][0]==2 && grid[1][1]==2 && grid[2][2]==2)
    return 2;
  if (grid[0][2]==2 && grid[1][1]==2 && grid[2][0]==2)
    return 2;
  for (int x=0;x<3;x++) {
    if (grid[x][0]==1 && grid[x][1]==1 && grid[x][2]==1)
      return 1;
  }
  for (int y=0;y<3;y++) {
    if (grid[0][y]==1 && grid[1][y]==1 && grid[2][y]==1)
      return 1;
  }
  if (grid[0][0]==1 && grid[1][1]==1 && grid[2][2]==1)
    return 1;
  if (grid[0][2]==1 && grid[1][1]==1 && grid[2][0]==1)
    return 1;
  if (grid[0][0]>=1 && grid[0][1]>=1 && grid[0][2]>=1 && grid[1][0]>=1 && grid[1][1]>=1 && grid[1][2]>=1 && grid[2][0]>=1 && grid[2][1]>=1 && grid[2][2]>=1)
    return 3;
  return 0;
}
void ai() {
  triples();
  if (!event)
    block();
  if (!event)
    blockfork();
  if (!event)
    placemid();
  if (!event)
    oppcorner();
  if (!event)
    corner();
  if (!event)
    side();
  event=false;
}
void triples() {
  for (int x=0;x<3;x++) {
    count=0;
    if (grid[x][0]==2)
      count++;
    if (grid[x][1]==2)
      count++;
    if (grid[x][2]==2)
      count++;
    if (count==2) {
      if (grid[x][0]==0) {
        grid[x][0]=2; 
        breaked=true;
        event=true;
        break;
      } else if (grid[x][1]==0) {
        grid[x][1]=2; 
        breaked=true;
        event=true;
        break;
      } else if (grid[x][2]==0) {
        grid[x][2]=2;
        breaked=true;
        event=true;
        break;
      }
    }
  }
  if (!breaked) {
    for (int y=0;y<3;y++) {
      count=0;
      if (grid[0][y]==2)
        count++;
      if (grid[1][y]==2)
        count++;
      if (grid[2][y]==2)
        count++;
      if (count==2) {
        if (grid[0][y]==0) {
          grid[0][y]=2; 
          breaked=true;
          event=true;
          break;
        } else if (grid[1][y]==0) {
          grid[1][y]=2; 
          breaked=true;
          event=true;
          break;
        } else if (grid[2][y]==0) {
          grid[2][y]=2;
          breaked=true;
          event=true;
          break;
        }
      }
    }
  }
  if (!breaked) {
    count=0;
    if (grid[0][0]==2)
      count++;
    if (grid[1][1]==2)
      count++;
    if (grid[2][2]==2)
      count++;
    if (count==2) {
      if (grid[0][0]==0) {
        grid[0][0]=2; 
        breaked=true;
        event=true;
      } else if (grid[1][1]==0) {
        grid[1][1]=2; 
        breaked=true;
        event=true;
      } else if (grid[2][2]==0) {
        grid[2][2]=2;
        breaked=true;
        event=true;
      }
    }
  }
  if (!breaked) {
    count=0;
    if (grid[0][2]==2)
      count++;
    if (grid[1][1]==2)
      count++;
    if (grid[2][0]==2)
      count++;
    if (count==2) {
      if (grid[0][2]==0) {
        grid[0][2]=2; 
        event=true;
      } else if (grid[1][1]==0) {
        grid[1][1]=2; 
        event=true;
      } else if (grid[2][0]==0) {
        grid[2][0]=2;
        event=true;
      }
    }
  }
  breaked=false;
}
void placemid() {
  if (grid[1][1]==0) {
    grid[1][1]=2;
    event=true;
  }
}
void side() {
  if (grid[0][1]==0) {
    grid[0][1]=2;
    event=true;
  }
  else if (grid[2][1]==0) {
    grid[2][1]=2;
    event=true;
  }
  else if (grid[1][0]==0) {
    grid[1][0]=2;
    event=true;
  }
  else if (grid[1][2]==0) {
    grid[1][2]=2;
    event=true;
  }
}
void block() {
  for (int x=0;x<3;x++) {
    count=0;
    if (grid[x][0]==1)
      count++;
    if (grid[x][1]==1)
      count++;
    if (grid[x][2]==1)
      count++;
    if (count==2) {
      if (grid[x][0]==0) {
        grid[x][0]=2; 
        breaked=true;
        event=true;
        break;
      } else if (grid[x][1]==0) {
        grid[x][1]=2; 
        breaked=true;
        event=true;
        break;
      } else if (grid[x][2]==0) {
        grid[x][2]=2;
        breaked=true;
        event=true;
        break;
      }
    }
  }
  if (!breaked) {
    for (int y=0;y<3;y++) {
      count=0;
      if (grid[0][y]==1)
        count++;
      if (grid[1][y]==1)
        count++;
      if (grid[2][y]==1)
        count++;
      if (count==2) {
        if (grid[0][y]==0) {
          grid[0][y]=2; 
          breaked=true;
          event=true;
          break;
        } else if (grid[1][y]==0) {
          grid[1][y]=2; 
          breaked=true;
          event=true;
          break;
        } else if (grid[2][y]==0) {
          grid[2][y]=2;
          breaked=true;
          event=true;
          break;
        }
      }
    }
  }
  if (!breaked) {
    count=0;
    if (grid[0][0]==1)
      count++;
    if (grid[1][1]==1)
      count++;
    if (grid[2][2]==1)
      count++;
    if (count==2) {
      if (grid[0][0]==0) {
        grid[0][0]=2; 
        breaked=true;
        event=true;
      } else if (grid[1][1]==0) {
        grid[1][1]=2; 
        breaked=true;
        event=true;
      } else if (grid[2][2]==0) {
        grid[2][2]=2;
        breaked=true;
        event=true;
      }
    }
  }
  if (!breaked) {
    count=0;
    if (grid[0][2]==1)
      count++;
    if (grid[1][1]==1)
      count++;
    if (grid[2][0]==1)
      count++;
    if (count==2) {
      if (grid[0][2]==0) {
        grid[0][2]=2; 
        breaked=true;
        event=true;
      } else if (grid[1][1]==0) {
        grid[1][1]=2; 
        breaked=true;
        event=true;
      } else if (grid[2][0]==0) {
        grid[2][0]=2;
        breaked=true;
        event=true;
      }
    }
  }
  breaked=false;
}
void oppcorner() {
  if (grid[0][0]==1 && grid[2][2]==0) {
    grid[2][2]=2;
    event=true;
  } else if (grid[0][2]==1 && grid[2][0]==0) {
    grid[2][0]=2;
    event=true;
  } else if (grid[2][0]==1 && grid[0][2]==0) {
    grid[0][2]=2;
    event=true;
  } else if (grid[2][2]==1 && grid[0][0]==0) {
    grid[0][0]=2;
    event=true;
  }
}
void corner() {
  if (grid[0][0]==0) {
    grid[0][0]=2;
    event=true;
  } else if (grid[0][2]==0) {
    grid[0][2]=2;
    event=true;
  } else if (grid[2][0]==0) {
    grid[2][0]=2;
    event=true;
  } else if (grid[2][2]==0) {
    grid[2][2]=2;
    event=true;
  }
}
void blockfork() {
  if (round==2) {
    // O 
    //   X
    //     O
    if (grid[0][0]==1 && grid[2][2]==1) {
      grid[0][1]=2;
      event=true;
    } else if (grid[0][2]==1 && grid[2][0]==1) {
      grid[2][1]=2;
      event=true;
    }
  }
}
void draw() {
  if (pressed) {
    background(255);
    if (check()==3)
      event5=true;
    if (event1) {
      JOptionPane.showMessageDialog(null, "Player 1 Wins!");
      String type = JOptionPane.showInputDialog("Do you want to play again?");
      type+=" ";
      if (type.equals("yes ") || type.equals("Yes ")) {
        round=0;
        firstpress=false;
        first=false;
        event1=false;
        for (int x = 0; x < 3; x++)
        {
          for (int y = 0; y < 3; y++)
          {
            grid[x][y] = 0;
          }
        }
      } else if (type.equals("no ") || type.equals("No ")) {
        exit();
      } else {     
        JOptionPane.showMessageDialog(null, "Wrong input!"); 
        exit();
      }
    }
    if (event2) {
      JOptionPane.showMessageDialog(null, "Player Wins!");
      String type = JOptionPane.showInputDialog("Do you want to play again?");
      type+=" ";
      if (type.equals("yes ") || type.equals("Yes ")) {
        round=0;
        firstpress=false;
        first=false;
        event2=false;
        for (int x = 0; x < 3; x++)
        {
          for (int y = 0; y < 3; y++)
          {
            grid[x][y] = 0;
          }
        }
      } else if (type.equals("no ") || type.equals("No ")) {
        exit();
      } else {     
        JOptionPane.showMessageDialog(null, "Wrong input!"); 
        exit();
      }
    }
    if (event3) {
      JOptionPane.showMessageDialog(null, "Player 2 Wins!");
      String type = JOptionPane.showInputDialog("Do you want to play again?");
      type+=" ";
      if (type.equals("yes ") || type.equals("Yes ")) {
        round=0;
        firstpress=false;
        first=false;
        event3=false;
        for (int x = 0; x < 3; x++)
        {
          for (int y = 0; y < 3; y++)
          {
            grid[x][y] = 0;
          }
        }
      } else if (type.equals("no ") || type.equals("No ")) {
        exit();
      } else {     
        JOptionPane.showMessageDialog(null, "Wrong input!"); 
        exit();
      }
    }
    if (event4) {
      JOptionPane.showMessageDialog(null, "Computer Wins!");
      String type = JOptionPane.showInputDialog("Do you want to play again?");
      type+=" ";
      if (type.equals("yes ") || type.equals("Yes ")) {
        round=0;
        firstpress=false;
        first=false;
        event4=false;
        for (int x = 0; x < 3; x++)
        {
          for (int y = 0; y < 3; y++)
          {
            grid[x][y] = 0;
          }
        }
      } else if (type.equals("no ") || type.equals("No " )) {
        exit();
      } else {     
        JOptionPane.showMessageDialog(null, "Wrong input!"); 
        exit();
      }
    }
    if (event5) {
      JOptionPane.showMessageDialog(null, "Tie!");
      String type = JOptionPane.showInputDialog("Do you want to play again?");
      type+=" ";
      if (type.equals("yes ") || type.equals("Yes ")) {
        round=0;
        firstpress=false;
        first=false;
        event5=false;
        for (int x = 0; x < 3; x++)
        {
          for (int y = 0; y < 3; y++)
          {
            grid[x][y] = 0;
          }
        }
      } else if (type.equals("no ") || type.equals("No ")) {
        exit();
      } else {     
        JOptionPane.showMessageDialog(null, "Wrong input!"); 
        exit();
      }
    }
    if (bot&&firstpress)
      ai();
    print(round);
    for (int x = 0; x < 3; x++)
    {
      for (int y = 0; y < 3; y++)
      {
        if (grid[x][y] == 1)
          image(Circle, x*200, y*200);
        if (grid[x][y] == 2)
          image(Cross, x*200, y*200);
      }
    }
    for (int x = 0; x < 600; x+=200)
    {
      line(x, 0, x, 600);
    }
    for (int y = 0; y < 600; y+=200)
    {
      line(0, y, 600, y);
    }
    if (check()==1 && play)
      event1=true; else if (check()==1 && bot)
      event2=true; else if (check()==2 && play)
      event3=true; else if (check()==2 && bot)
      event4=true;
    pressed=false;
  }
}
