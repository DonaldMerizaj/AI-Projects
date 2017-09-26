import java.util.*;
import javax.swing.JOptionPane;
int[][] colorMatrix = new int[50][50];
int[][] testMatrix = new int[50][50];
int[][] expMatrix = new int[50][50];
int[][] pathMatrix = new int[50][50];
boolean keyed=false;
boolean first=false;
boolean goal=false;
int finalx;
int finaly;
int startx;
int starty;
boolean end=false;
Node finalnode =null;
Comparator<Node> comparator = new GCostComparator();
Comparator<Node> Hcomparator = new HCostComparator();
Comparator<Node> Fcomparator = new FCostComparator();
Node current=null;
PriorityQueue<Node> fringe = new PriorityQueue<Node>(11, comparator);
PriorityQueue<Node> hfringe = new PriorityQueue<Node>(11, Hcomparator);
PriorityQueue<Node> ffringe = new PriorityQueue<Node>(11, Fcomparator);
ArrayList<Node> nodes = new ArrayList<Node> ();
ArrayList<Node> finalnodes = new ArrayList<Node> ();
int expcost =0;
boolean pressed=false;
boolean uniform=false;
boolean astar=false;
boolean greedy=false;
void setup ()
{
  size(600, 600);
  for (int x = 0; x < 50; x++)
  {
    for (int y = 0; y < 50; y++)
    {
      colorMatrix[x][y] = 0;
      expMatrix[x][y]=0;
      pathMatrix[x][y]=0;
    }
  }
  String type = JOptionPane.showInputDialog("Which type of searching method?");
  if (type.equals("Uniform") || type.equals("uniform"))
    uniform=true; else if (type.equals("Greedy") || type.equals("greedy"))
    greedy=true; else if (type.equals("Astar") || type.equals("astar") || type.equals("AStar"))
    astar=true; else {
    JOptionPane.showMessageDialog(null, "No such searching method found.");
    exit();
  }
}

void mousePressed () 
{ 
  if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && first==false) {
    colorMatrix[mouseX/12][mouseY/12] = 1; 
    startx=mouseX/12;
    starty=mouseY/12;
    current = new Node(startx, starty);
    println(startx+" "+starty);
    fringe.add(current);
    hfringe.add(current);
    ffringe.add(current);
    first=true;
    JOptionPane.showMessageDialog(null, "Press a square for end location.");
  } else if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && first==true && goal==false) {
    colorMatrix[mouseX/12][mouseY/12] = 2;
    finalx=mouseX/12;
    finaly=mouseY/12; 
    println(finalx+" "+finaly);
    goal=true;
    JOptionPane.showMessageDialog(null, "Drag to create walls, click on walls to remove them.");
  } else if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && first==true && goal==true && colorMatrix[mouseX/12][mouseY/12] == 0) {
    colorMatrix[mouseX/12][mouseY/12] = 3;
  } else if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0 && first==true && goal==true && colorMatrix[mouseX/12][mouseY/12] == 3) {
    colorMatrix[mouseX/12][mouseY/12] = 0;
  }
}
void mouseDragged () 
{ 
  if (mouseX<600 && mouseY<600 && mouseX>0 && mouseY>0)
    colorMatrix[mouseX/12][mouseY/12] = 3;
}




void changeGrid()
{
  for (int x = 0; x < 50; x++)
  {
    for (int y = 0; y < 50; y++)
    {
      testMatrix[x][y] = colorMatrix[x][y];
    }
  }



  //uniform:
  if (uniform==true) {
    if (!fringe.isEmpty()) {
      current = fringe.poll(); //pops the first item in queue, sets current node as node popped
      // test if the node is the goal.
      if (testMatrix[current.x][current.y]==2) {
        finalnode=current;
        end=true;
        //exit();
      }
      testMatrix[current.x][current.y]=4;
      expMatrix[current.x][current.y]=4;
      println(current.x+" "+current.y);
      // Add unvisited child nodes to fringe's Queue
      if (current.x>0) {
        if (testMatrix[current.x-1][current.y]==0 || testMatrix[current.x-1][current.y]==2) {
          Node child = new Node(current.x-1, current.y);
          if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setParent(current);                 
            fringe.add(child);
          } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
            for (Node node: fringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                  fringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setParent(current);
                  fringe.add(child);
                  break;
                }
            }
          }
        }
        if (current.y>0)
          if (testMatrix[current.x-1][current.y-1]==0 || testMatrix[current.x-1][current.y-1]==2) {
            Node child = new Node(current.x-1, current.y-1);
            if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setParent(current);                 
              fringe.add(child);
            } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
              for (Node node: fringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                    fringe.remove(node);
                    child.setG(current.getG()+10);
                    child.setParent(current);
                    fringe.add(child);
                    break;
                  }
              }
            }
          }
        if (current.y<49)
          if (testMatrix[current.x-1][current.y+1]==0 || testMatrix[current.x-1][current.y+1]==2) {
            Node child = new Node(current.x-1, current.y+1);
            if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setParent(current);                 
              fringe.add(child);
            } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
              for (Node node: fringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                    fringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setParent(current);
                    fringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.x<49) {
        if (testMatrix[current.x+1][current.y]==0 || testMatrix[current.x+1][current.y]==2) {
          Node child = new Node(current.x+1, current.y);
          if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setParent(current);                 
            fringe.add(child);
          } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
            for (Node node: fringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                  fringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setParent(current);
                  fringe.add(child);
                  break;
                }
            }
          }
        }    
        if (current.y>0)
          if (testMatrix[current.x+1][current.y-1]==0 || testMatrix[current.x+1][current.y-1]==2) {
            Node child = new Node(current.x+1, current.y-1);
            if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setParent(current);                 
              fringe.add(child);
            } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
              for (Node node: fringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                    fringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setParent(current);
                    fringe.add(child);
                    break;
                  }
              }
            }
          }    
        if (current.y<49)
          if (testMatrix[current.x+1][current.y+1]==0 || testMatrix[current.x+1][current.y+1]==2) {
            Node child = new Node(current.x+1, current.y+1);
            if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setParent(current);                 
              fringe.add(child);
            } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
              for (Node node: fringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                    fringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setParent(current);
                    fringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.y<49)
        if (testMatrix[current.x][current.y+1]==0 || testMatrix[current.x][current.y+1]==2) {
          Node child = new Node(current.x, current.y+1);
          if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setParent(current);                 
            fringe.add(child);
          } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
            for (Node node: fringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                  fringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setParent(current);
                  fringe.add(child);
                  break;
                }
            }
          }
        }  
      if (current.y>0) 
        if (testMatrix[current.x][current.y-1]==0 || testMatrix[current.x][current.y-1]==2) {
          Node child = new Node(current.x, current.y-1);
          if (!searchQueue(fringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setParent(current);                 
            fringe.add(child);
          } else if (searchQueue(fringe, child)) { //if it is not visited but already in fringe
            for (Node node: fringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getG()>node.getG()) { //replaces node with child if child g is greater
                  fringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setParent(current);
                  fringe.add(child);
                  break;
                }
            }
          }
        }
    }
  }

  //greedy:

  if (greedy==true) {
    if (!ffringe.isEmpty()) {
      current = ffringe.poll(); //pops the first item in queue, sets current node as node popped
      // test if the node is the goal.
      if (testMatrix[current.x][current.y]==2) {
        finalnode=current;
        end=true;
        //exit();
      }
      testMatrix[current.x][current.y]=4;
      expMatrix[current.x][current.y]=4;
      println(current.x+" "+current.y);
      // Add unvisited child nodes to fringe's Queue
      if (current.x>0) {
        if (testMatrix[current.x-1][current.y]==0 || testMatrix[current.x-1][current.y]==2) {
          Node child = new Node(current.x-1, current.y);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100);
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }
        if (current.y>0)
          if (testMatrix[current.x-1][current.y-1]==0 || testMatrix[current.x-1][current.y-1]==2) {
            Node child = new Node(current.x-1, current.y-1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+10);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
        if (current.y<49)
          if (testMatrix[current.x-1][current.y+1]==0 || testMatrix[current.x-1][current.y+1]==2) {
            Node child = new Node(current.x-1, current.y+1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.x<49) {
        if (testMatrix[current.x+1][current.y]==0 || testMatrix[current.x+1][current.y]==2) {
          Node child = new Node(current.x+1, current.y);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }    
        if (current.y>0)
          if (testMatrix[current.x+1][current.y-1]==0 || testMatrix[current.x+1][current.y-1]==2) {
            Node child = new Node(current.x+1, current.y-1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }    
        if (current.y<49)
          if (testMatrix[current.x+1][current.y+1]==0 || testMatrix[current.x+1][current.y+1]==2) {
            Node child = new Node(current.x+1, current.y+1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.y<49)
        if (testMatrix[current.x][current.y+1]==0 || testMatrix[current.x][current.y+1]==2) {
          Node child = new Node(current.x, current.y+1);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }  
      if (current.y>0) 
        if (testMatrix[current.x][current.y-1]==0 || testMatrix[current.x][current.y-1]==2) {
          Node child = new Node(current.x, current.y-1);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*100); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }
    }
  }





  //astar:

  if (astar==true) {
    if (!ffringe.isEmpty()) {
      current = ffringe.poll(); //pops the first item in queue, sets current node as node popped
      // test if the node is the goal.
      if (testMatrix[current.x][current.y]==2) {
        finalnode=current;
        end=true;
        //exit();
      }
      testMatrix[current.x][current.y]=4;
      expMatrix[current.x][current.y]=4;
      println(current.x+" "+current.y);
      // Add unvisited child nodes to fringe's Queue
      if (current.x>0) {
        if (testMatrix[current.x-1][current.y]==0 || testMatrix[current.x-1][current.y]==2) {
          Node child = new Node(current.x-1, current.y);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10);
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }
        if (current.y>0)
          if (testMatrix[current.x-1][current.y-1]==0 || testMatrix[current.x-1][current.y-1]==2) {
            Node child = new Node(current.x-1, current.y-1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+10);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
        if (current.y<49)
          if (testMatrix[current.x-1][current.y+1]==0 || testMatrix[current.x-1][current.y+1]==2) {
            Node child = new Node(current.x-1, current.y+1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.x<49) {
        if (testMatrix[current.x+1][current.y]==0 || testMatrix[current.x+1][current.y]==2) {
          Node child = new Node(current.x+1, current.y);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }    
        if (current.y>0)
          if (testMatrix[current.x+1][current.y-1]==0 || testMatrix[current.x+1][current.y-1]==2) {
            Node child = new Node(current.x+1, current.y-1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }    
        if (current.y<49)
          if (testMatrix[current.x+1][current.y+1]==0 || testMatrix[current.x+1][current.y+1]==2) {
            Node child = new Node(current.x+1, current.y+1);
            if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
              child.setG(current.getG()+14);
              child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
              child.setF(child.getG()+child.getH());
              child.setParent(current);                 
              ffringe.add(child);
            } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
              for (Node node: ffringe) {
                if (node.x==child.x&&node.y==child.y)
                  if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                    ffringe.remove(node);
                    child.setG(current.getG()+14);
                    child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                    child.setF(child.getG()+child.getH());
                    child.setParent(current);
                    ffringe.add(child);
                    break;
                  }
              }
            }
          }
      }
      if (current.y<49)
        if (testMatrix[current.x][current.y+1]==0 || testMatrix[current.x][current.y+1]==2) {
          Node child = new Node(current.x, current.y+1);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }  
      if (current.y>0) 
        if (testMatrix[current.x][current.y-1]==0 || testMatrix[current.x][current.y-1]==2) {
          Node child = new Node(current.x, current.y-1);
          if (!searchQueue(ffringe, child)) { //checks if it is not visited and not in fringe
            child.setG(current.getG()+10);
            child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
            child.setF(child.getG()+child.getH());
            child.setParent(current);                 
            ffringe.add(child);
          } else if (searchQueue(ffringe, child)) { //if it is not visited but already in fringe
            for (Node node: ffringe) {
              if (node.x==child.x&&node.y==child.y)
                if (child.getF()>node.getF()) { //replaces node with child if child f is greater
                  ffringe.remove(node);
                  child.setG(current.getG()+10);
                  child.setH((abs(finalx-child.x)+abs(finaly-child.y))*10); 
                  child.setF(child.getG()+child.getH());
                  child.setParent(current);
                  ffringe.add(child);
                  break;
                }
            }
          }
        }
    }
  }
}
public boolean searchQueue(PriorityQueue<Node> queue, Node newNode) {
  for (Node node: queue) {
    if (node.x==newNode.x&&node.y==newNode.y)
      return true;
  }
  return false;
}
void draw()
{ 
  if (!first && !pressed) {
    JOptionPane.showMessageDialog(null, "Press a square for starting location."); 
    pressed=true;
  }
  if (!end) {

    for (int x = 0; x < 600; x+=12)
    {
      for (int y = 0; y < 600; y+=12)
      {
        if (colorMatrix[x/12][y/12] == 1)
          fill(0, 0, 220); else if (colorMatrix[x/12][y/12] == 2)
          fill(255, 0, 0); else if (colorMatrix[x/12][y/12]==3)
          fill(0); else if (colorMatrix[x/12][y/12]==4)
          fill(0, 220, 0);
        else
          fill(225);
        if (expMatrix[x/12][y/12]==4 && colorMatrix[x/12][y/12] != 1)
          fill(100, 220, 0);

        rect(x, y, 12, 12);
      }
    }
  } else {
    while (finalnode.getPar ()!=null) {
      finalnode=finalnode.getPar();
      expcost++;
      pathMatrix[finalnode.x][finalnode.y]=1;
      if (pathMatrix[finalnode.x][finalnode.y]==1)
        fill(255, 204, 0);
      rect(finalnode.x*12, finalnode.y*12, 12, 12);
    }
    fill(0, 0, 220);
    rect(startx*12, starty*12, 12, 12);
    print("Cost: "+expcost);
    noLoop();
    JOptionPane.showMessageDialog(null, "Cost: "+expcost);
  }


  if (keyPressed==true)
    keyed=true;

  if (keyed==true && key==' ') {
    if (!end)
      changeGrid();
  }
}

