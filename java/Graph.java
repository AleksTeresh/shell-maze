import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * Created by aleksandr on 20.11.2017.
 */
public class Graph {
    private LLElement<?>[] graph;

    public Graph() {
    }

    /* tell how many nodes a graph has */
    public int nodes() {
        if (graph != null) {
            return graph.length;
        } else {
            return 0;
        }
    }

    /* read a graph from the file */
    public boolean readGraph(File file) {
        Scanner scanner;
        try {
            scanner = new Scanner(file);
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();

            return false;
        }

        int numOfLines = 0;
        while (scanner.hasNextLine()) {
            numOfLines++;
            scanner.nextLine();
        }

        this.graph = new LLElement<?>[numOfLines];

        try {
            scanner = new Scanner(file);
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();

            return false;
        }

        while (scanner.hasNextLine()) {
            String[] numbers = scanner.nextLine().split(" ");

            if (numbers.length > 0) {
                int nodeNumber = Integer.parseInt(numbers[0]);

                LLElement<Integer> firstElement = null;
                LLElement<Integer> lastElement = null;
                for (int i = 1; i < numbers.length; i++) {
                    if (lastElement == null) {
                        firstElement = new LLElement<Integer>(Integer.parseInt(numbers[i]));
                        lastElement = firstElement;
                    } else {
                        lastElement.setNext(new LLElement<Integer>(Integer.parseInt(numbers[i])));
                        lastElement = lastElement.getNext();
                    }
                }

                if (firstElement != null) {
                    graph[nodeNumber] = firstElement;
                }
            }
        }

        return true;
    }

    /* print a graph */
    void printGraph() {
        if (graph == null) {
            return;
        }

        for (int i = 0; i < graph.length; i++) {
            System.out.print(i + ": ");

            @SuppressWarnings("unchecked")
            LLElement<Integer> currElement = (LLElement<Integer>) graph[i];
            while (currElement != null) {
                System.out.print(currElement.getData() + " ");
                currElement = currElement.getNext();
            }

            System.out.println();
        }
    }

    /* Depth First Search
    * start is the node from where the search begins
    * visited is an array of all the visited nodes
    * pred is an describing the search path
    */
    void dfs(int start, boolean visited[], int pred[]) {
        visited[start] = true;

        @SuppressWarnings("unchecked")
        LLElement<Integer> currElement = (LLElement<Integer>) graph[start];
        while (currElement != null) {
            if (!visited[currElement.getData()]) {
                pred[currElement.getData()] = start;
                dfs(currElement.getData(), visited, pred);
            }

            currElement = currElement.getNext();
        }
    }
}
