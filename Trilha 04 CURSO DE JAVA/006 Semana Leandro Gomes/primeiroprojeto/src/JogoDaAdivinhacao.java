import java.util.Random;
import java.util.Scanner;

public class JogoDaAdivinhacao {

    public static void main(String[] args) {
        // Gera um número aleatório entre 0 e 100
        Random random = new Random();
        int numeroSecreto = random.nextInt(100);

        // Inicializa o contador de tentativas
        int tentativasRestantes = 5;

        // Inicia o jogo
        Scanner scanner = new Scanner(System.in);
        System.out.println("Bem-vindo ao jogo de adivinhação!");
        System.out.println("Você tem 5 tentativas para adivinhar um número entre 0 e 100.");

        while (tentativasRestantes > 0) {
            System.out.print("Digite um número: ");
            int palpite = scanner.nextInt();

            if (palpite == numeroSecreto) {
                System.out.println("Parabéns! Você adivinhou o número!");
                break;
            } else if (palpite < numeroSecreto) {
                System.out.println("O número secreto é maior que o seu palpite.");
            } else {
                System.out.println("O número secreto é menor que o seu palpite.");
            }

            tentativasRestantes--;
            System.out.println("Você ainda tem " + tentativasRestantes + " tentativas restantes.");
        }

        if (tentativasRestantes == 0) {
            System.out.println("Você não conseguiu adivinhar o número. O número secreto era: " + numeroSecreto);
        }

        scanner.close();
    }
}