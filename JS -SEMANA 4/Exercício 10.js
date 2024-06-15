// Função para calcular média da turma de Matemática
function calcularMediaMatematica() {
    let notas = [];
    let nota;
    while (true) {
        nota = prompt("Insira a nota do aluno (digite 'SAIR' para finalizar):");
        if (nota === "SAIR") {
            break;
        }
        notas.push(parseFloat(nota));
    }
    
    let totalNotas = 0;
    for (let i = 0; i < notas.length; i++) {
        totalNotas += notas[i];
    }
    
    let media = totalNotas / notas.length;
    alert("A média da turma de Matemática é: " + media.toFixed(2));
}

// Chamando a função para calcular média da turma de Matemática
calcularMediaMatematica();

//--------------

// Função para calcular média do aluno
function calcularMediaAluno(prova, trabalho) {
    return (prova + trabalho) / 2;
}

// Função para verificar se aluno está abaixo da média e enviar e-mail para diretoria
function verificarMediaAluno(nome, disciplina, media) {
    if (media < 7.0) {
        console.log("Nome do aluno: " + nome);
        console.log("Disciplina: " + disciplina);
        console.log("Média do bimestre: " + media.toFixed(2));
        console.log("Enviado e-mail para diretoria sobre aluno abaixo da média.");
    }
}

// Exemplo de utilização:
let nomeAluno = "Fulano";
let disciplina = "Matemática";
let prova = 8.5;
let trabalho = 6.5;

let mediaAluno = calcularMediaAluno(prova, trabalho);
verificarMediaAluno(nomeAluno, disciplina, mediaAluno);


//-----------

// Função para selecionar líder de turma com base na média em Língua Portuguesa e Matemática
function selecionarLider(aluno1, aluno2, aluno3) {
    let mediaPortuguesa1 = aluno1.mediaPortuguesa;
    let mediaPortuguesa2 = aluno2.mediaPortuguesa;
    let mediaPortuguesa3 = aluno3.mediaPortuguesa;
    
    if (mediaPortuguesa1 >= mediaPortuguesa2 && mediaPortuguesa1 >= mediaPortuguesa3) {
        return aluno1.nome;
    } else if (mediaPortuguesa2 >= mediaPortuguesa1 && mediaPortuguesa2 >= mediaPortuguesa3) {
        return aluno2.nome;
    } else {
        return aluno3.nome;
    }
}

// Exemplo de utilização:
let aluno1 = { nome: "Fulano", mediaPortuguesa: 8.2, mediaMatematica: 7.5 };
let aluno2 = { nome: "Ciclano", mediaPortuguesa: 7.8, mediaMatematica: 8.0 };
let aluno3 = { nome: "Beltrano", mediaPortuguesa: 7.5, mediaMatematica: 7.8 };

let liderTurma = selecionarLider(aluno1, aluno2, aluno3);
console.log("Líder da turma selecionado: " + liderTurma);
