import java.util.stream.IntStream;
import java.util.List;
import java.util.stream.Collectors;
import java.util.ArrayList;

final class FunctionalEvenGenerator {
    private FunctionalEvenGenerator() { }

    public static List<Integer> generateFirstNEven(int n) {
        if (n <= 0) {
            return List.of();
        }

        return IntStream.iterate(2, i -> i + 2)
                        .limit(n)
                        .boxed()
                        .collect(Collectors.toList());
    }
}

final class ProceduralEvenGenerator {
    private ProceduralEvenGenerator() { }

    public static List<Integer> generateFirstNEven(int n) {
        List<Integer> evenNumbers = new ArrayList<>();
        
        if (n <= 0) {
            return evenNumbers;
        }

        for (int i = 1; i <= n; i++) {
            evenNumbers.add(i * 2);
        }
        
        return evenNumbers;
    }
}

public class Main {
    public static void main(String[] args) {
        int n = 10;

        System.out.println("Functional: " + FunctionalEvenGenerator.generateFirstNEven(n));
        System.out.println("Procedural: " + ProceduralEvenGenerator.generateFirstNEven(n));
    }
}