public class ListagemEtariaClientes {
    public static void main(String[] args) {

        System.out.println(">>> Listagem de Clientes");
        System.out.println(">>> Ano atual: 2023");
        String separador = "_______________________________";
        String cliente1 = "Fulano";
        String cliente2 = "Sicrano";

        int datanasc_c1 = 1980;
        int datanasc_c2 = 2000;
        int idade_c1 = 43;
        int idade_c2 = 23;


        System.out.println(separador);
        System.out.println("Nome:" + cliente1);
        System.out.println("Data de Nascimento:" + datanasc_c1);
        System.out.println("Idade:" + idade_c1);

        if (idade_c1 <= 17) {
            System.out.println("Característica Etária: ADOLESCENTE");
        } else if (idade_c1 >= 18 && idade_c1 <= 29) {
            System.out.println("Característica Etária: JOVEM");
        } else if (idade_c1 >= 30 && idade_c1 <= 59) {
            System.out.println("Característica Etária: ADULTO");
        } else {
            System.out.println("Característica Etária: IDOSO");
        }

        System.out.println(separador);
        System.out.println("Nome:" + cliente2);
        System.out.println("Data de Nascimento:" + datanasc_c2);
        System.out.println("Idade:" + idade_c2);

        if (idade_c2 <= 17) {
            System.out.println("Característica Etária: ADOLESCENTE");
        } else if (idade_c2 >= 18 && idade_c2 <= 29) {
            System.out.println("Característica Etária: JOVEM");
        } else if (idade_c2 >= 30 && idade_c2 <= 59) {
            System.out.println("Característica Etária: ADULTO");
        } else {
            System.out.println("Característica Etária: IDOSO");
        }
    }
}