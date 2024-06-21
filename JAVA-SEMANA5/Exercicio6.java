public class Exercicio6 {
    public static void main(String[] args) {
        // Arrays para armazenar os nomes e anos de nascimento dos clientes
        String[] nomesClientes = {"Maria Silva", "João Pereira", "Ana Costa"};
        int[] anosNascimentoClientes = {1990, 1985, 2000};

        // Exibir a listagem de clientes no console
        System.out.println("Listagem de Clientes:");
        for (int i = 0; i < nomesClientes.length; i++) {
            System.out.println("Cliente " + (i + 1) + ": " + nomesClientes[i] + " - Ano de Nascimento: " + anosNascimentoClientes[i]);
        }
    }
}


