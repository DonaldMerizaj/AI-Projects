import java.util.Comparator;

public class GCostComparator implements Comparator<Node>
{
    public int compare(Node x, Node y)
    {
        if (x.getG() < y.getG())
        {
            return -1;
        }
        if (x.getG() > y.getG())
        {
            return 1;
        }
        return 0;
        
    }
}

