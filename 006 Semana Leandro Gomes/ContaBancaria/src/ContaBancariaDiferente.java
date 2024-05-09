import java.util.Scanner;

    public class ContaBancariaDiferente {
        public static void main(String[] args) {
            Scanner entrada = new Scanner(System.in);
            int opcao = 0;
            double saldo = 3000;
            double valor;
//1) Menu opções
            String menu =
                    """ 
                    Operações
                    
                    1- Consultar saldo
                    2- Receber Valor
                    3- Transferir Valor
                    4- Sair""";
//2) inicializar os dados do cliente
            System.out.println(
                    """
                    *********************************
                    Dados iniciais do cliente:
                    
                    Nome:           Leandro Gomes
                    Tipo de conta:  Corrente
                    Saldo inicial:  R$ 3000,00
                    *********************************
             
                    """ + menu);
//3) imputando informações para cada ação do menu
            while (opcao != 4){
                System.out.println("Digite a opção desejada: ");
                opcao = entrada.nextInt();

                if (opcao == 1){
                    System.out.println("Seu saldo atual é de R$" + saldo);
                    System.out.println(menu);
                }
                if (opcao == 2){
                    System.out.println("Digite o valor que irá receber:");
                    saldo += entrada.nextDouble();
                    System.out.println("Saldo atualizado: R$" + saldo);
                    System.out.println(menu);
                }
                if (opcao == 3){
                    System.out.println("Digite o valor que deseja transferir:");
                    valor = entrada.nextDouble();
                    if (valor > saldo){
                        System.out.println("Saldo insuficiente para realizar a transferência.");
                        System.out.println(menu);
                    }else{
                        saldo -= valor;
                        System.out.println("Saldo atualizado: R$" + saldo);
                        System.out.println(menu);
                    }
                }
                if (opcao > 4){
                    System.out.println("Opção inválida.");
                    System.out.println(menu);
                }
            }
//4) mensagem final ao sair

            System.out.println("Obrigado por utilizar nosso programa!");
        }
    }
