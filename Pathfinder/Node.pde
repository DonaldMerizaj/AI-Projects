class Node {
  public int g;
  public int h;
  public int f;
  public int x;
  public int y;
  public Node parent;
  public int expNum;
  Node(int x, int y) {
    this.x=x;
    this.y=y;
    g = 0;
    h = 0;
    f = 0;
  }
  public int getF() {
    return f;
  }
  public void setF(int f) {
    this.f=f;
  }

  public int getH() {
    return h;
  }

  public void setH(int h) {
    this.h = h;
  }

  public int getG() {
    return g;
  }

  public void setG(int g) {
    this.g = g;
  }

  public Node getPar() {
    return parent;
  }

  public void setParent(Node parent) {
    this.parent = parent;
  }

  public int getExpNum() {
    return expNum;
  }

  public void setExpNum(int expNum) {
    this.expNum = expNum;
  }
}

