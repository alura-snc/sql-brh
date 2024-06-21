// Definir as variáveis
var raio = 3.5; // raio da piscina em metros
var altura = 1.6; // altura da piscina em metros
var pi = 3.14; // valor aproximado de pi

// Calcular a área da base (área de um círculo)
var areaBase = pi * Math.pow(raio, 2);

// Calcular o volume da piscina em metros cúbicos
var volumeMetrosCubicos = areaBase * altura;

// Converter o volume para litros (1m³ = 1000L)
var volumeLitros = volumeMetrosCubicos * 1000;

// Exibir o volume da piscina em litros
console.log("O volume da piscina é de aproximadamente " + volumeLitros.toFixed(2) + " litros.");
