import java.util.Scanner;

public class Tabuada {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Digite um número para exibir a tabuada:");
        int numero = scanner.nextInt();

        System.out.println("Tabuada do " + numero + ":");

        for (int i = 1; i <= 10; i++) {
            int resultado = numero * i;
            System.out.println(numero + " x " + i + " = " + resultado);
        }

        scanner.close();

//NOTA: Neste programa, solicitamos ao usuário um número inteiro e, em seguida, utilizamos um loop for para calcular
//e exibir a tabuada desse número de 1 a 10. Cada linha da tabuada mostra a multiplicação do número digitado pelo valor
//do contador do loop (de 1 a 10) e o resultado da multiplicação.
    }
}