import java.util.Scanner;

public class ContaBancaria {
    public static void main(String[] args) {

 // 1) Inicializa dados do cliente
       String nome = "Leandro Gomes";
        String tipoConta = "Corrente";
        double saldo = 3000;

        System.out.println("===================================================");
        System.out.println("Nome do Cliente: " + nome);
        System.out.println("Tipo Conta: " + tipoConta);
        System.out.println("Saldo Atual: " + saldo);
        System.out.println("===================================================");

 // 2) Menu Opções
        System.out.println();

        String menu = """
                ** Digite sua Opção **
                1 - Consultar Saldo
                2 - Trasnferir Valor
                3 - Receber Valor
                4 - Sair
                """;
        Scanner leitura = new Scanner(System.in);

        int opcao = 0;
        while (opcao != 4){
            System.out.println(menu);
            opcao = leitura.nextInt();

// 3) Visualização do Saldo

        if (opcao == 1){
            System.out.println("O Saldo atualizado é: " +saldo);}

        else if (opcao == 2){
            System.out.println("Qual o valor a ser transferido: ");
            double valor = leitura.nextDouble();
            if (valor > saldo) {
                System.out.println("Não há saldo para realizar operação"); }
            else {
                saldo = saldo - valor;
                System.out.println("Saldo atualizado R$" +saldo);
            }

        }else if (opcao == 3){
            System.out.println("Valor Recebido");
            double valor = leitura.nextDouble();
            saldo = saldo + valor;
            System.out.println("Saldo Atualizado: R$" + saldo);

        }else if (opcao != 4){
            System.out.println("Opção Invalida");

        }
            System.out.println("Obrigado por utilizar nosso programa!");

        }

    }
}

