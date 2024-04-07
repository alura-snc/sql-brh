public class ListagemProdutos {
    public static void main(String[] args) {

        System.out.println(">>> Listagem dos Produtos");
        String separador = "_______________________________";
        String produto1 = "Livro";
        String produto2 = "Celular";

        double preco_pr1 = 49.95;
        double preco_pr2 = 1470.76;

        System.out.println(separador);
        System.out.println("Nome:" + produto1);
        System.out.println("Preço: R$" + preco_pr1);

        System.out.println(separador);
        System.out.println("Nome:" + produto2);
        System.out.println("Preço: R$" + preco_pr2);

    }
}
