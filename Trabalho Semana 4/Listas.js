// Ex.1 //
let pessoa = ["Tony Stark","21","555.222.333-21", 1.73, true];
let i = 0;
while (i <= (pessoa.length - 1)){
    document.write(pessoa[i] + '<br>');
    i++;    
}
document.write('<br>');

// Ex.2 //
let letras = [];
let letraInformada;

function recebeLetra(){
    letraInformada = prompt("Digite uma letra: ");
    letras.push(letraInformada);
}
for (j = 1; j<=10; j++) {
    recebeLetra();
}
for (k = 0; k < (letras.length); k++){
    document.write(letras[k] + '<br>');
}

// Ex.3 //

a) A primeira letra digitada
b) A quarta letra digitada
c) A quinta letra digitada
d) A última letra digitada
e) O tamanho da lista criada

document.write(`Primeira letra digitada: ${letras[0]} <br>`);
document.write(`Quarta letra digitada: ${letras[3]} <br>`);
document.write(`Quinta letra digitada: ${letras[4]} <br>`);
document.write(`Última letra digitada: ${letras[letras.length-1]} <br>`);
document.write(`Tamanho da lista criada: ${letras.length}`);