import java.util.Scanner;

public class ParImpar {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Digite um número inteiro: ");
        int numero = scanner.nextInt();
        scanner.close();

        if (numero % 2 == 0) {
            System.out.println(numero + " é um número par.");
        } else {
            System.out.println(numero + " é um número ímpar.");
        }
    }
}

//Claro, vamos analisar o programa linha por linha para entender como ele funciona:
//import java.util.Scanner;: Esta linha importa a classe Scanner do pacote java.util, que é usada para ler a entrada do usuário.
//public class ParImpar {: Aqui é declarada a classe ParImpar, que contém o método main onde o programa começa sua execução.
//public static void main(String[] args) {: Este é o método principal do programa. É onde o código é executado quando o programa é iniciado.
//Scanner scanner = new Scanner(System.in);: Cria um novo objeto Scanner chamado scanner, que é usado para ler a entrada do usuário.
//System.out.print("Digite um número inteiro: ");: Exibe uma mensagem para o usuário, solicitando que ele insira um número inteiro.
//int numero = scanner.nextInt();: Lê o número inteiro digitado pelo usuário e armazena-o na variável numero.
//scanner.close();: Fecha o objeto Scanner para liberar os recursos.
//if (numero % 2 == 0) {: Inicia um bloco condicional if que verifica se o número digitado é divisível por 2 (ou seja, se é par).
//System.out.println(numero + " é um número par.");: Se o número for par, exibe uma mensagem informando isso.
//} else {: Inicia o bloco else que é executado se o número não for par.
//System.out.println(numero + " é um número ímpar.");: Exibe uma mensagem informando que o número é ímpar.
//}: Fecha o bloco if-else.