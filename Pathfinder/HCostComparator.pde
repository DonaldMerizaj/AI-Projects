import java.util.Comparator;

public class HCostComparator implements Comparator<Node>
{
    public int compare(Node x, Node y)
    {
        if (x.getH() < y.getH())
        {
            return -1;
        }
        if (x.getH() > y.getH())
        {
            return 1;
        }
        return 0;
        
    }
}

