using Comex;

String logo = @"
░█████╗░░█████╗░███╗░░░███╗███████╗██╗░░██╗
██╔══██╗██╔══██╗████╗░████║██╔════╝╚██╗██╔╝
██║░░╚═╝██║░░██║██╔████╔██║█████╗░░░╚███╔╝░
██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░░██╔██╗░
╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗██╔╝╚██╗
░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚═╝";


Console.WriteLine(logo);
ExibeMenu();



void ExibeMenu()
{
    Console.WriteLine("1 - Cadastrar produto");
    Console.WriteLine("-1 - Para sair");

    Console.WriteLine("Selecione a opção desejada\n");
    string opcaoEscolhida = Console.ReadLine()!;
    int opcaoEscolhidaNumerica = int.Parse(opcaoEscolhida);

    switch (opcaoEscolhidaNumerica)
    {
        case 1: RegistrarProduto();
            break;
        case -1: Console.WriteLine("Bye Bye");
            break;
    }
}

void RegistrarProduto()
{
    Console.Clear();
    Console.WriteLine("Registro de produtos");
    Console.Write("Digite o nome do produto: ");
    String nomeProduto = Console.ReadLine()!;
    Produto produto = new Produto(nomeProduto);
    Console.WriteLine($"O Produto {nomeProduto} foi cadastrado com sucesso");
    Thread.Sleep(2000);
    Console.Clear();
    ExibeMenu();
}