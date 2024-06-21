public class Exercicio7 {
    public static void main(String[] args) {
        // Ano atual
        int anoAtual = 2024;

        // Informações do primeiro cliente
        String nomeCliente1 = "Fulano";
        int dataDeNascimentoCliente1 = 1980;
        int idadeCliente1 = anoAtual - dataDeNascimentoCliente1;
        String classificacaoIdade1 = ClassificacaoEtaria(idadeCliente1);

        // Informações do segundo cliente
        String nomeCliente2 = "Sicrano";
        int dataDeNascimentoCliente2 = 2000;
        int idadeCliente2 = anoAtual - dataDeNascimentoCliente2;
        String classificacaoIdade2 = ClassificacaoEtaria(idadeCliente2);

        // Exibir informações dos clientes
        System.out.println(">>> Listagem dos Clientes");
        System.out.println(">>> Ano atual: " + anoAtual);
        System.out.println("___________________________________");
        System.out.println("Nome: " + nomeCliente1);
        System.out.println("Data de Nascimento: " + dataDeNascimentoCliente1);
        System.out.println("Idade: " + idadeCliente1 + " - " + classificacaoIdade1);
        System.out.println("___________________________________");
        System.out.println("Nome: " + nomeCliente2);
        System.out.println("Data de Nascimento: " + dataDeNascimentoCliente2);
        System.out.println("Idade: " + idadeCliente2 + " - " + classificacaoIdade2);
    }

    // Método para determinar a classificação etária
    public static String ClassificacaoEtaria(int idade) {
        if (idade <= 17) {
            return "ADOLESCENTE";
        } else if (idade <= 29) {
            return "JOVEM";
        } else if (idade <= 59) {
            return "ADULTO";
        } else {
            return "IDOSO";
        }
    }
}

