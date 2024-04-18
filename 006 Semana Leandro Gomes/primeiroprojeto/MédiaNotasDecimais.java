public class MédiaNotasDecimais {
    public static void main (String[] args) {
        System.out.println("01 REALIZAR MEDIA DE 2 NOTAS DECIMAIS");
        System.out.println("");

        //01 EXERCÍCIO
        System.out.println("Nota Maicon Média: ");
        double nota1 = 9.1;
        double nota2 = 10.0;
        double notaMedia = (nota1 + nota2) / 2;
        System.out.println(notaMedia);

        System.out.println("==========================================================================================");
        //02 EXERCÍCIO
        System.out.println("");
        System.out.println("02 NOTA INTEIRA");
        double notaFracionada = 9.55;
        int notaInteira = (int) notaFracionada;
        System.out.println("A nota inteira neste caso é de: " + notaInteira);

        System.out.println("==========================================================================================");
        //03 EXERCÍCIO Declare uma variável do tipo char (letra) e uma variável do tipo String (palavra).
        //Atribua valores a essas variáveis e concatene-as em uma mensagem.
        System.out.println("");
        System.out.println("03 VARIAVEL CHAR E STRING");

        char alternativa1 = 'A';
        char alternativa2 = 'B';
        char alternativa3 = 'C';
        char alternativa4 = 'D';

        String mensagem = ("A segunda letra do alfabeto é representada por qual das alternativas? ");
        System.out.println(mensagem + "A resposta é: " + alternativa2);

        System.out.println("==========================================================================================");
//04 EXERCÍCIO Declare uma variável do tipo double precoProduto e uma variável do tipo int (quantidade).
//Calcule o valor total multiplicando o preço do produto pela quantidade e apresente o resultado em uma mensagem.
        System.out.println("");
        System.out.println("04 CALCULE O VALOR TOTAL");
        double precoProduto = 6.55;
        int quantidade = 10;
        double valorTotal = (precoProduto * quantidade);

        System.out.println("O valor final é de: " + valorTotal);

        System.out.println("==========================================================================================");
//05 EXERCÍCIO Declare uma variável do tipo double valorEmDolares. Atribua um valor em dólares a essa variável.
//Considere que o valor de 1 dólar é equivalente a 4.94 reais. Realize a conversão do valor em dólares para reais e
//imprima o resultado formatado.
        System.out.println("");
        System.out.println("05 CONVERSÃO DE REAIS EM DOLAR");
        int dollar = 1;
        System.out.println("Valor do Dollar: " + dollar);
        double reais = 5.10;
        System.out.println("Valor do Real: " + reais);

        dollar = 2;
        reais = 4.96;
        double valorEmDolares = (dollar * reais);

        System.out.println("Valor convertido final é de: " + valorEmDolares);

        System.out.println("==========================================================================================");
//06 EXERCÍCIO Declare uma variável do tipo double precoOriginal. Atribua um valor em reais a essa variável,
//representando o preço original de um produto. Em seguida, declare uma variável do tipo double percentualDesconto e
//atribua um valor percentual de desconto ao produto (por exemplo, 10 para 10%). Calcule o valor do desconto em reais,
// aplique-o ao preço original e imprima o novo preço com desconto.
        System.out.println("");
        System.out.println("06 DESCONTO E INFORMAR PREÇO ORIGINAL");

                double precoOriginal = 100.0;
                double percentualDesconto = 10.0;

                double valorDesconto = (percentualDesconto / 100.0) * precoOriginal;
        // pode-se aplicar precoOriginal - percentualDesconto
                double novoPreco = precoOriginal - valorDesconto;

                System.out.println("Preço original: R$ " + precoOriginal);
                System.out.println("Desconto: R$ " + valorDesconto);
                System.out.println("Novo preço com desconto: R$ " + novoPreco);
            }

}
