
// Ex. A //
let i =1;
while (i <= 50){
    (i%2 == 0) == true ? document.write(`O número ${i} é par <br>`) : document.write(`O número ${i} é ímpar <br>`);
    i++;    
}

// Ex. B //
document.write('<br> <br> Múltiplos de 3: <br>')
let m = 1;
while (m <= 100){
    if (m%3 == 0) document.write(`${m} <br>`);
    m++;
}

// Ex. C //
document.write('<br><br>Sequência de 100 até 0, pulando de dois em dois:');
for (var sequencia = 100; sequencia >= 0; sequencia--){
    document.write(sequencia);
    sequencia--;
} 