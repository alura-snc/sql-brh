public class Maintestes {

    public static void main (String[] args) {
        System.out.println("Esse é o Screen Match");
        System.out.println("Filme: Top Gun - Maverick");

        int anoDeLancamento = 2022;
        System.out.println("Ano de Lançamento (Concatenação): " + anoDeLancamento);
        boolean incluidoNoPlano = true;

        double notaDoFilme = 8.1;

        // Média calcula com base em 3 notas //
        System.out.println("Nota do Filme: ");
        double media = (9.8 + 6.3 + 8.0) / 3;
        System.out.println(media);
        String sinopse;
        sinopse = "Filme de Aventura dos anos 80";
        System.out.println(sinopse);

        System.out.println("=========================================================================================");

        //Classificação do Filme. Nota 8 = a 4 estrelas (feita operação matemática media/2

        String classificacao;
        classificacao = String.valueOf((int) (media / 2));
        System.out.println("Classificação: " + classificacao);

        /* Este é um exemplo de comentário
de várias linhas em Java
que será ignorado pelo compilador */

    }

}
