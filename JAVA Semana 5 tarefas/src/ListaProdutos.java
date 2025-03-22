import java.util.Scanner;

public class ListaProdutos {
    public static void main(String[] args) {
        System.out.println(">>>>>> Lista de produtos <<<<<<");
        System.out.println("\n----------------------------------------");

        // nomes produtos e preços //
        java.util.Map<String, Double> produtos = new java.util.HashMap<>();
        produtos.put("Celular", 1800.0);
        produtos.put("Livro1", 50.0);
        produtos.put("Notebook", 3000.0);

        // ler a entrada de informações //
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nome do produto: ");
        String nomeProduto = scanner.nextLine();

        // exibe o preço //
        if (produtos.containsKey(nomeProduto)) {
            double preco = produtos.get(nomeProduto);
            System.out.printf("O preço é R$ %.2f%n", preco);
            System.out.println("\n--------------------------------------");
        } else {
            System.out.println("Produto não encontrado");
            System.out.println("\n--------------------------------------");
        }
    }
}
