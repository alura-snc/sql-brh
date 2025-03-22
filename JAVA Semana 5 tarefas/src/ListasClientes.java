import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

public class ListasClientes {
    public static void main(String[] args) {
        System.out.println("\nSeja bem vindo ao COMEX!");
        System.out.println("\n>>>>> Listagem de clientes <<<<<<<");
        Scanner scanner = new Scanner(System.in);

        // nome do cliente //
        System.out.println("\n-----------------------------");
        System.out.print("\nNome = ");
        String nome = scanner.nextLine();

        // data de nascimento //
        System.out.print("Data de nascimento (dd/MM/yyyy) = ");
        String dataNascimentoString = scanner.nextLine();

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dataNascimento = null;
        try {
            dataNascimento = sdf.parse(dataNascimentoString);
        } catch (ParseException e) {
            System.out.println("Utilize o formato dd/MM/yyyy");
            System.exit(1);
        }

        // idade do cliente //
        int idade = idadeCliente(dataNascimento);
        System.out.println("Idade = " + idade);
        System.out.println("-----------------------------");
        scanner.close();
    }
       public static int idadeCliente(Date dataNascimento) {
        Calendar hoje = Calendar.getInstance();
        Calendar nascimento = Calendar.getInstance();
        nascimento.setTime(dataNascimento);

        int idade = hoje.get(Calendar.YEAR) - nascimento.get(Calendar.YEAR);
        if (hoje.get(Calendar.MONTH) < nascimento.get(Calendar.MONTH) ||
                (hoje.get(Calendar.MONTH) == nascimento.get(Calendar.MONTH) &&
                 hoje.get(Calendar.DAY_OF_MONTH) < nascimento.get(Calendar.DAY_OF_MONTH))) {

            idade--;
        }
        return idade;

       }
}

