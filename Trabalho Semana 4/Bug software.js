
// Bug no software //
let Altura = document.querySelector('Altura');
let Raio = document.querySelector('Raio');
let totalVolume = document.querySelector('Resultado');
console.log(Altura);
console.log(Raio);

    if (Entradas(raio) && Entradas(altura)) {
        let area = calCirculo(raio);
        let volume = calCilindro(area, altura)*1000;
        resultadoVolume.innerHTML=`${volume.toFixed(2)} Litros`;
    } else{
        resultadoVolume.innerHTML="Valor não permitido, digite números";
    }
    function validarEntradas(valor) {
    return (!isNaN(valor) && valor>0) ? true : false;
}

function calCirculo(raioMetros) {
    return Math.PI * raioMetros ** 2;
}

function calCilindro(areaBaseMetros, alturaMetros) {
    return areaBaseMetros * alturaMetros;
}

