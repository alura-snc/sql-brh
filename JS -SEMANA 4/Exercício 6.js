// Criar a lista pessoa com os valores
let pessoa = {
    nome: "Fulano",
    idade: 25,
    CPF: "123.456.789-00",
    altura: 1.75,
    maiorIdade: true
};

// Exibir os valores da lista pessoa no console
console.log("Nome:", pessoa.nome);
console.log("Idade:", pessoa.idade);
console.log("CPF:", pessoa.CPF);
console.log("Altura:", pessoa.altura);
console.log("Maior de idade:", pessoa.maiorIdade);


//------


// Função para receber letra e adicionar à lista de letras
function recebeLetra(letra) {
    letras.push(letra);
}

// Lista para armazenar as letras
let letras = [];

// Solicitar ao usuário para inserir as letras
for (let i = 0; i < 10; i++) {
    let letra = prompt("Digite uma letra:");
    recebeLetra(letra);
}

// Exibir todas as letras no console
console.log("Letras inseridas:", letras.join(", "));


//------


// Criar uma lista para armazenar as letras
let letras = [];

// Função para receber letra e adicionar à lista de letras
function recebeLetra(letra) {
    letras.push(letra);
}

// Solicitar ao usuário para inserir as letras
for (let i = 0; i < 10; i++) {
    let letra = prompt("Digite uma letra:");
    recebeLetra(letra);
}

// Exibir informações específicas sobre as letras
console.log("a) A primeira letra digitada:", letras[0]);
console.log("b) A quarta letra digitada:", letras[3]);
console.log("c) A quinta letra digitada:", letras[4]);
console.log("d) A última letra digitada:", letras[letras.length - 1]);
console.log("e) O tamanho da lista criada:", letras.length);
