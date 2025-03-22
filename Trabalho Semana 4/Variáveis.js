// Criar 5 variáveis Ex1 //
let nome = "Tony Stark";
let telefone = "(11)95555-4444";
let convenioMedico = true;
let profissao = "Engenheiro";
let salario = 150.000;
let profissional = `Colaborador ${nome}, telefone ${telefone}, Convenio ${textoConvenio}, profissão ${profissao} e salário de R$${salario}.`;

console.log(profissional);

//Variáveis Ex2 //
let num1 = 1;
let num2 = 2;

document.write(`Número um: ${num1}`);
document.write(`Número dois: ${num2}`);
document.write('<br>');

document.write('Troca:');
document.write('<br>');
let troca1 = num1;
let troca2 = num2;
num1 = num2;
num2 = num1;

document.write(`Número um: ${num1}`);
document.write('<br>');
document.write(`Número dois: ${num2}`);

