// Função para converter valores entre moedas
function converterMoeda(valor, taxa) {
    return valor * taxa;
}

// Destino: Nova Zelândia
let passagensNZD = 13996;
let diariaHotelNZD = 79.15;
let guiaLocalNZD = 200;
let taxaNZD = 3.25;

let passagensBRLNZD = converterMoeda(passagensNZD, 1 / taxaNZD);
let diariaHotelBRLNZD = converterMoeda(diariaHotelNZD, 1 / taxaNZD);
let guiaLocalBRLNZD = converterMoeda(guiaLocalNZD, 1 / taxaNZD);

console.log("* Nova Zelândia *");
console.log("Passagens: R$ " + passagensBRLNZD.toFixed(2));
console.log("Acomodação (5 dias): R$ " + (diariaHotelBRLNZD * 5).toFixed(2));
console.log("O guia local custará R$ " + guiaLocalBRLNZD.toFixed(2));
console.log("Total R$ " + (passagensBRLNZD + (diariaHotelBRLNZD * 5) + guiaLocalBRLNZD).toFixed(2));
console.log("---");

// Destino: Tailândia
let passagensTHB = 9160;
let diariaHotelTHB = 590;
let guiaLocalTHB = 235;
let taxaTHB = 0.15;

let passagensBRLTHB = converterMoeda(passagensTHB, 1 / taxaTHB);
let diariaHotelBRLTHB = converterMoeda(diariaHotelTHB, 1 / taxaTHB);
let guiaLocalBRLTHB = converterMoeda(guiaLocalTHB, 1 / taxaTHB);

console.log("* Tailândia *");
console.log("Passagens: R$ " + passagensBRLTHB.toFixed(2));
console.log("Acomodação (5 dias): R$ " + (diariaHotelBRLTHB * 5).toFixed(2));
console.log("O guia local custará R$ " + guiaLocalBRLTHB.toFixed(2));
console.log("Total R$ " + (passagensBRLTHB + (diariaHotelBRLTHB * 5) + guiaLocalBRLTHB).toFixed(2));
console.log("---");

// Destino: Costa Rica
let passagensCRC = 5119;
let diariaHotelCRC = 2300;
let guiaLocalCRC = 3150;
let taxaCRC = 0.0089;

let passagensBRLCRC = converterMoeda(passagensCRC, 1 / taxaCRC);
let diariaHotelBRLCRC = converterMoeda(diariaHotelCRC, 1 / taxaCRC);
let guiaLocalBRLCRC = converterMoeda(guiaLocalCRC, 1 / taxaCRC);

console.log("* Costa Rica *");
console.log("Passagens: R$ " + passagensBRLCRC.toFixed(2));
console.log("Acomodação (5 dias): R$ " + (diariaHotelBRLCRC * 5).toFixed(2));
console.log("O guia local custará R$ " + guiaLocalBRLCRC.toFixed(2));
console.log("Total R$ " + (passagensBRLCRC + (diariaHotelBRLCRC * 5) + guiaLocalBRLCRC).toFixed(2));



// Função para enviar e-mail com os detalhes da viagem
function enviarEmail(nome, destino, passagens, diariaHotel, guiaLocal, custoTotal) {
    console.log("Olá, " + nome + "! É um prazer termos você como cliente e estamos ansiosos para que sua viagem possa ocorrer em breve!");
    console.log("Estou te encaminhando os orçamentos!");
    console.log(" * " + destino + " *");
    console.log("Passagens: R$ " + passagens.toFixed(2));
    console.log("Acomodação (5 dias): R$ " + (diariaHotel * 5).toFixed(2));
    console.log("O guia local custará R$ " + guiaLocal.toFixed(2));
    console.log("Total R$ " + custoTotal.toFixed(2));
}

// Exemplo de utilização:
enviarEmail("Fulana", "Nova Zelândia", passagensBRLNZD, diariaHotelBRLNZD, guiaLocalBRLNZD, passagensBRLNZD + (diariaHotelBRLNZD * 5) + guiaLocalBRLNZD);

//_________________________

//Melhorias envio do e-mail
// Função para converter valores entre moedas com base nas cotações fornecidas pelo usuário
function converterMoeda(valor, taxa) {
    return valor * taxa;
}

// Função para enviar e-mail com os detalhes da viagem
function enviarEmail(nome, destino, passagens, diariaHotel, guiaLocal, custoTotal) {
    console.log("Olá, " + nome + "! É um prazer termos você como cliente e estamos ansiosos para que sua viagem possa ocorrer em breve!");
    console.log("Estou te encaminhando os orçamentos!");
    console.log(" * " + destino + " *");
    console.log("Passagens: R$ " + passagens.toFixed(2));
    console.log("Acomodação (5 dias): R$ " + (diariaHotel * 5).toFixed(2));
    console.log("O guia local custará R$ " + guiaLocal.toFixed(2));
    console.log("Total R$ " + custoTotal.toFixed(2));
}

// Preenchimento dos detalhes de cada destino via prompt()
let destino = prompt("Informe o destino da viagem:");
let passagens = parseFloat(prompt("Informe o valor das passagens:"));
let diariaHotel = parseFloat(prompt("Informe o valor da diária do hotel:"));
let guiaLocal = parseFloat(prompt("Informe o valor do guia local:"));
let dias = parseInt(prompt("Informe a quantidade de dias da viagem:"));

// Preenchimento das cotações de moeda para cada destino via prompt()
let taxaMoeda = parseFloat(prompt("Informe a cotação da moeda local em relação ao real:"));

let passagensBRL = converterMoeda(passagens, taxaMoeda);
let diariaHotelBRL = converterMoeda(diariaHotel, taxaMoeda);
let guiaLocalBRL = converterMoeda(guiaLocal, taxaMoeda);
let custoTotal = passagensBRL + (diariaHotelBRL * dias) + guiaLocalBRL;

enviarEmail("Fulano", destino, passagensBRL, diariaHotelBRL, guiaLocalBRL, custoTotal);
