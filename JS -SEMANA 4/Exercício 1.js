// 1. Criar e atribuir valores às variáveis
var nome = "João";
var telefone = "123456789";
var possuiConvenio = true;
var profissao = "Engenheiro";
var salario = 5000;

// Concatenar as variáveis em uma string na variável 'profissional'
var profissional = "Nome: " + nome + ", Telefone: " + telefone + ", Possui Convênio Médico: " + possuiConvenio + ", Profissão: " + profissao + ", Salário: " + salario;

// Exibir a variável 'profissional' usando document.write() em um arquivo HTML
document.write(profissional);

// Exibir a variável 'profissional' usando console.log()
console.log(profissional);

// 2. Trocar valores entre duas variáveis
var a = 10;
var b = 20;

console.log("Valores iniciais - a: " + a + ", b: " + b);

// Trocar os valores entre as variáveis 'a' e 'b'
var temp = a;
a = b;
b = temp;

console.log("Valores após a troca - a: " + a + ", b: " + b);

// Armazenar dois números inteiros em duas variáveis
var a = 10;
var b = 20;

// Exibir os valores iniciais
console.log("Valores iniciais - a: " + a + ", b: " + b);

// Trocar os valores entre as variáveis 'a' e 'b'
var temp = a;
a = b;
b = temp;

// Exibir os valores após a troca
console.log("Valores após a troca - a: " + a + ", b: " + b);
