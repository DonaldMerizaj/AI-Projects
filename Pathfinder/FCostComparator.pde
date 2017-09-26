import java.util.Comparator;

public class FCostComparator implements Comparator<Node>
{
    public int compare(Node x, Node y)
    {
        if (x.getF() < y.getF())
        {
            return -1;
        }
        if (x.getF() > y.getF())
        {
            return 1;
        }
        return 0;
        
    }
}

