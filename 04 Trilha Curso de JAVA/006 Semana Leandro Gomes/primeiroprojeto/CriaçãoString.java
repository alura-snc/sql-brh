public class CriaçãoString {

    public static void main (String[] args) {

        String empresa = "Alura";
        String saudacao = "Olá, ";
        String mensagem;
        mensagem = saudacao + empresa + "!";
        System.out.println(mensagem);
        System.out.println("=========================================================================================");

        //abaixo é linha em branco
        System.out.println("");

        String senha = "12345";
        if (senha.equals("12345")) {
            System.out.println("Acesso autorizado!");
        } else {
            System.out.println("Senha incorreta.");
        }

        //abaixo é linha em branco
        System.out.println("");

        String mensagem2 = """
                  Este é um Text Block.
                  Ele permite escrever textos com múltiplas linhas
                  sem precisar usar caracteres de escape ou quebras de linha manualmente ou concatenações.
                  """;
        System.out.println(mensagem2);
        System.out.println("==========================================================================================");
        System.out.println("");

        String nome = "Maria";
        int idade = 30;
        double valor = 55.9999;
        System.out.println(String.format("Meu nome é %s, eu tenho %d anos e hoje gastei %.2f reais", nome, idade, valor));

//Uma das maneiras mais comuns de se formatar textos em Java é utilizando o método format(), da classe String.
//Esse método permite formatar um texto utilizando diversos placeholders, que são representados pelo caractere % seguido
//de uma letra que indica o tipo de dado que será inserido no placeholder.
//Por exemplo, %s indica que uma String será inserida no placeholder,
//%d indica um valor inteiro e %f indica um valor de ponto flutuante. Exemplo acima.
//Nesse exemplo, os valores das variáveis nome, idade e valor são passados como parâmetros para o método String.format,
// substituindo os placeholders %s, %d e %.2f, respectivamente. O resultado impresso será "Meu nome é Maria, eu
// tenho 30 anos e hoje gastei 55,99 reais". Perceba também que o placeholder %.2f indica que o valor deve ser
// formatado com duas casas decimais.

        System.out.println(mensagem2);
        System.out.println("=========================================================================================");

        String nome2 = "João";
        int aulas = 4;

        String mensagemDiferente = """
                  Olá, %s!
                  Boas vindas ao curso de Java.
                  Teremos %d aulas para te mostrar o que é preciso para você dar o seu primeiro mergulho na linguagem!
                  """.formatted(nome2, aulas);

        System.out.println(mensagemDiferente);

        System.out.println(mensagem2);
        System.out.println("==========================================================================================");



    }

}