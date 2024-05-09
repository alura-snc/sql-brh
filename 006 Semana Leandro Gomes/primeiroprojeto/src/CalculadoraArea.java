import java.util.Scanner;

public class CalculadoraArea {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int escolha = -1;

        do {
            System.out.println("Escolha uma opção:");
            System.out.println("1. Calcular área do quadrado");
            System.out.println("2. Calcular área do círculo");
            System.out.println("0. Sair");

            if (scanner.hasNextInt()) {
                escolha = scanner.nextInt();
            } else {
                scanner.next(); // Limpa o buffer do scanner
                System.out.println("Opção inválida. Tente novamente.");
                continue;
            }

            switch (escolha) {
                case 1:
                    calcularAreaQuadrado(scanner);
                    break;
                case 2:
                    calcularAreaCirculo(scanner);
                    break;
                case 0:
                    System.out.println("Saindo do programa.");
                    break;
                default:
                    System.out.println("Opção inválida. Tente novamente.");
            }
        } while (escolha != 0);

        scanner.close();
    }

    public static void calcularAreaQuadrado(Scanner scanner) {
        System.out.println("Digite o lado do quadrado:");
        double lado = scanner.nextDouble();

        double area = lado * lado;
        System.out.println("A área do quadrado é: " + area);
    }

    public static void calcularAreaCirculo(Scanner scanner) {
        System.out.println("Digite o raio do círculo:");
        double raio = scanner.nextDouble();

        double area = Math.PI * raio * raio;
        System.out.println("A área do círculo é: " + area);
    }
}
