// Solicitar que o usuário digite sua idade
var idade = prompt("Digite sua idade:");

// Converter a entrada do usuário para um número inteiro
idade = parseInt(idade);

// Verificar se a pessoa pode votar usando estruturas condicionais
if (idade < 16) {
    console.log("Você não pode votar, pois ainda não completou 16 anos.");
} else if (idade >= 16 && idade <= 17) {
    console.log("Seu voto é opcional, pois você tem entre 16 e 17 anos.");
} else if (idade >= 18 && idade <= 70) {
    console.log("Você é obrigado a votar, pois tem entre 18 e 70 anos.");
} else {
    console.log("Seu voto é opcional, pois você tem mais de 70 anos.");
}
