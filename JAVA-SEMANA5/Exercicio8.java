public class Exercicio8 {
    public static void main(String[] args) {
        // Cenário 1: tamanho do cabeçalho é 20
        imprimirCenario(20);

        // Cenário 2: tamanho do cabeçalho é 40
        imprimirCenario(40);
    }

    public static String gerarCenario(int tamanho) {
        StringBuilder linha = new StringBuilder();
        for (int i = 0; i < tamanho; i++) {
            linha.append("*"); // Adiciona o caractere sublinhado para formar a linha
        }
        return linha.toString();
    }

    public static void imprimirCenario(int tamanho) {
        // Gerar e imprimir a linha do cabeçalho
        String cabecalho = gerarCenario(tamanho);
        System.out.println(cabecalho);
        System.out.println("Seja bem-vindo ao COMEX!");
        System.out.println(cabecalho); // Usar a mesma linha para o rodapé do cabeçalho
        System.out.println("Seja bem-vindo ao COMEX!");
        System.out.println(cabecalho); // Usar a mesma linha para separar os clientes
        System.out.println();
    }
}




