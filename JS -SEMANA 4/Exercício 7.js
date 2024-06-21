// Atribuir valores às bases, alturas e raio das figuras
let baseRetangulo = 5;
let alturaRetangulo = 3;
let raioCirculo = 2;
let baseTriangulo = 4;
let alturaTriangulo = 6;

// Calcular as áreas das figuras utilizando as fórmulas e os valores fornecidos
let areaRetangulo = baseRetangulo * alturaRetangulo;
let areaCirculo = Math.PI * Math.pow(raioCirculo, 2);
let areaTriangulo = (baseTriangulo * alturaTriangulo) / 2;

// Exibir os resultados dos cálculos das áreas no console
console.log("a) Área do retângulo:", areaRetangulo);
console.log("b) Área do círculo:", areaCirculo);
console.log("c) Área do triângulo retângulo:", areaTriangulo);

