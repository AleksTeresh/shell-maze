import java.io.File;

/**
 * Created by aleksandr on 20.11.2017.
 */
public class Main {
    /* find a maze solution */
    private static int mazeSolution(int from, int to, int pred[], int steps[]) {
        int i, n, node;
        // first count how many edges between the end and the start
        node = to; n = 1;
        while ((node = pred[node]) != from) {
            if (node == -1) {
                return 0;
            }

            n++;
        };
        // then reverse pred[] array to steps[] array
        node = to; i = n;
        while (i >= 0) {
            steps[i--] = node;
            node = pred[node];
        }
        // include also the end vertex
        return (n+1);
    }
    // private final static String FILE = "/home/aleksandr/Downloads/maze.grh";
    private final static int FROM = 0;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String file = args[0];
        if (file == null) {
          System.out.println("\nPlease provide a name of the file as an argument.");
          return;
        }

        Graph g = new Graph();
        // read the graph. and do the depth-first search
        g.readGraph(new File(file));
        // g.printGraph();
        int to = g.nodes() - 1;
        boolean visited[] = new boolean[to + 1];
        int pred[] = initPredArray(new int[to + 1]);

        g.dfs(FROM, visited, pred);
        // then check if there is a solution by looking from the backwards to the start
        int steps[] = new int[g.nodes()];
        int n = mazeSolution(FROM, to, pred, steps);

        if (n == 0) {
            System.out.println("\nA solution from " + FROM + " to " + to + " does not exist.");;
        } else {
            System.out.println("\nMaze solution from " + FROM + " to " + to);;
            for (int i = 0; i < n; i++)
                System.out.print(steps[i] + " ");
        }

        System.out.println();
    }

    private static int[] initPredArray(int[] pred) {
        for (int i = 0; i < pred.length; i++) {
            pred[i] = -1;
        }

        return pred;
    }
}
