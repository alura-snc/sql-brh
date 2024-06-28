
Vamos abordar cada uma das solicitações:

// a) Mostrar os números de 1 a 50 na tela, indicando se são pares ou ímpares:


// Utilizando o for
console.log("Usando for:");
for (let i = 1; i <= 50; i++) {
    if (i % 2 === 0) {
        console.log(i + " é par");
    } else {
        console.log(i + " é ímpar");
    }
}

// Utilizando o while

console.log("\nUsando while:");
let j = 1;
while (j <= 50) {
    if (j % 2 === 0) {
        console.log(j + " é par");
    } else {
        console.log(j + " é ímpar");
    }
    j++;
}

//b) Mostrar apenas os múltiplos de 3 entre 1 e 100:

console.log("\nMúltiplos de 3 entre 1 e 100:");
for (let i = 3; i <= 100; i += 3) {
    console.log(i);
}

//c) Mostrar a sequência de 100 até 0, pulando de dois em dois:


console.log("\nSequência de 100 até 0, pulando de dois em dois:");
for (let i = 100; i >= 0; i -= 2) {
    console.log(i);
}

// d) Implementação do jogo do PIM:

console.log("\nJogo do PIM:");
for (let i = 1; i <= 40; i++) {
    if (i % 4 === 0) {
        console.log("PIM");
    } else {
        console.log(i);
    }
}