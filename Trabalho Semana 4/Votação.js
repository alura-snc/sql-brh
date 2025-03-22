// Votação por idade - Brasil //

let idade = prompt("Informe sua idade: ");

// Voto obrigatório //
if (idade >= 18 & idade <= 70) {
    document.write('Votação obrigatória. Bom voto!');

// Idade insuficiente //
} else if (idade < 16) {
    document.write('Idade insuficiente para o voto')

// Voto opcional //
} else document.write('Seu voto é opcional');
