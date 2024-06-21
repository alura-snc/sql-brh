// Cria um array de objetos, cada um representando uma cidade e contendo o número de clientes e o faturamento correspondente.
const cidadesInfo = [
    // Cada objeto tem propriedades 'cidade', 'clientes' e 'faturamento'.
    { cidade: "Belo Horizonte", clientes: 23, faturamento: 2950 },
    { cidade: "São Paulo", clientes: 12, faturamento: 3950 },
    { cidade: "Salvador", clientes: 11, faturamento: 1329 },
    { cidade: "Campo Grande", clientes: 10, faturamento: 2412 },
    { cidade: "Curitiba", clientes: 8, faturamento: 626 }
  ];
  
  // Utiliza a função 'reduce' para somar o número total de clientes de todas as cidades.
  // A função 'reduce' percorre cada elemento do array, acumulando um valor; neste caso, a soma dos clientes.
  const totalClientes = cidadesInfo.reduce((total, cidade) => total + cidade.clientes, 0);
  
  // Imprime a soma total de clientes usando 'console.log'.
  console.log(`Nas capitais de BH, SP, BA, MS e PR, Jéssica possui ${totalClientes} clientes.`);
  
  // Utiliza o método 'forEach' para executar uma função para cada elemento do array 'cidadesInfo'.
  cidadesInfo.forEach(cidade => {
    // Calcula a média de faturamento dividindo o faturamento pelo número de clientes.
    // A função 'Math.round' é usada para arredondar o valor para o inteiro mais próximo.
    const media = Math.round(cidade.faturamento / cidade.clientes);
    // Imprime a média de faturamento por cliente para cada cidade.
    console.log(`${cidade.cidade}: R$ ${media}`);
  });
  
  // Novamente usa a função 'reduce' para calcular o faturamento total de todas as cidades.
  const faturamentoTotal = cidadesInfo.reduce((total, cidade) => total + cidade.faturamento, 0);
  // Calcula a média de faturamento total por cliente e imprime o valor.
  const mediaTotal = Math.round(faturamentoTotal / totalClientes);
  console.log(`Faturamento médio por cliente nas cinco cidades onde Jéssica mais tem clientes ativos é de R$ ${mediaTotal}`);
  
  // Define constantes para os custos de frete para São Paulo e outros estados.
  const freteSP = 9;
  const freteOutros = 14;
  
  // Define uma constante para o percentual do custo de produção em relação ao faturamento.
  const custoProducaoPct = 0.20;
  
  // Utiliza 'forEach' para calcular e imprimir o lucro por cidade.
  cidadesInfo.forEach(cidade => {
    // Usa um operador ternário para atribuir o custo de frete correto com base na cidade.
    const frete = cidade.cidade === "São Paulo" ? freteSP : freteOutros;
    // Calcula o frete total multiplicando o número de clientes pelo custo de frete.
    const freteTotal = cidade.clientes * frete;
    // Calcula o custo de produção subtraindo o frete total do faturamento e multiplicando pelo percentual de custo de produção.
    const custoProducao = (cidade.faturamento - freteTotal) * custoProducaoPct;
    // Calcula o lucro subtraindo o custo de frete e produção do faturamento e usa 'Math.round' para arredondar o valor.
    const lucro = Math.round(cidade.faturamento - freteTotal - custoProducao);
    // Imprime o lucro por cidade.
    console.log(`Lucro em ${cidade.cidade}: R$ ${lucro}`);
  });
  