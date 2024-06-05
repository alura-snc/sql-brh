import java.util.Scanner;

public class CalculoFatorial {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Digite um número inteiro positivo: ");
        int numero = scanner.nextInt();
        scanner.close();

        long fatorial = 1;

        if (numero < 0) {
            System.out.println("O fatorial não pode ser calculado para números negativos.");
        } else {
            for (int i = 1; i <= numero; i++) {
                fatorial *= i;
            }
            System.out.println("O fatorial de " + numero + " é " + fatorial + ".");
        }
    }
}

//Importação da Classe Scanner:
//Explicação: Importa a classe Scanner para ler a entrada do usuário.
//Exemplo: import java.util.Scanner;

// Declaração da Classe e Método main:
//Explicação: Define a classe principal e o método main, onde o programa começa a execução.
//Exemplo:
//java
//Copy code
//public class CalculoFatorial {
//    public static void main(String[] args) {

//Criação do Objeto Scanner e Entrada do Usuário:
//Explicação: Cria um objeto Scanner para ler a entrada do usuário e solicita um número inteiro positivo.
//Exemplo:
//java
//Copy code
//Scanner scanner = new Scanner(System.in);
//System.out.print("Digite um número inteiro positivo: ");
//int numero = scanner.nextInt();
//scanner.close();

//Inicialização da Variável Fatorial:
//Explicação: Inicializa a variável fatorial com 1, pois o fatorial de qualquer número é pelo menos 1.
//Exemplo: long fatorial = 1;

//Verificação se o Número é Negativo:
//Explicação: Verifica se o número inserido é negativo, pois o fatorial não é definido para números negativos.
//Exemplo:
//java
//Copy code
//if (numero < 0) {
//    System.out.println("O fatorial não pode ser calculado para números negativos.");
//} else {
//    // Cálculo do fatorial
//}

//Cálculo do Fatorial:
//Explicação: Usa um loop for para calcular o fatorial do número inserido pelo usuário.
//Exemplo:
//java
//Copy code
//for (int i = 1; i <= numero; i++) {
//    fatorial *= i;
//}

//Exibição do Resultado:
//Explicação: Exibe o resultado do cálculo do fatorial.
//Exemplo:
//java
//Copy code
//System.out.println("O fatorial de " + numero + " é " + fatorial + "