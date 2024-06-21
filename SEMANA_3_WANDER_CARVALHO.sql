--SEMANA 3

-- CARD 1 - Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;

SELECT c.nome AS nome_colaborador, d.nome AS nome_dependente, d.data_nascimento, d.parentesco, d.cpf
FROM brh.dependente d
INNER JOIN brh.colaborador c ON d.colaborador = c.matricula
WHERE
    TO_CHAR(d.DATA_NASCIMENTO, 'MM') IN ('04', '05', '06')
    OR d.NOME LIKE '%h%'
ORDER BY c.nome ASC, d.NOME ASC;

-- CARD 2 - Criar consulta que liste nome e o salário do colaborador com o maior salário
    
SELECT nome, salario
FROM brh.colaborador
WHERE
salario = (
    SELECT MAX(salario)
    FROM brh.colaborador
);  
-- A subconsulta (SELECT MAX(salario) FROM BRH.colaborador encontra o maior salário entre todos os colaboradores.
-- A consulta principal seleciona o nome e o salario dos colaboradores cujo salário corresponde ao valor encontrado pela subconsulta. Verificar LIMIT com Order BY - desempenho da consulta.

--CARD 3 - Relatório de senioridade

SELECT
    matricula,
    nome,
    salario,
    CASE
        WHEN salario <= 3000 THEN 'Júnior'
        WHEN salario > 3000 AND salario <= 6000 THEN 'Pleno'
        WHEN salario > 6000 AND salario <= 20000 THEN 'Sênior'
        ELSE 'Corpo diretor'
    END AS senioridade
FROM
    brh.colaborador
    
-- CARD 4 - Listar quantidade de colaboradores em projetos

SELECT 
d.nome, 
p.nome as nome_projeto, 
COUNT(*) 
FROM brh.departamento d 
INNER JOIN brh.colaborador c on d.sigla = c.departamento 
INNER JOIN brh.atribuicao a on c.matricula = a.colaborador 
INNER JOIN brh.projeto p on a.projeto= p.id 
GROUP BY d.nome, p.nome 
ORDER BY d.nome, p.nome;

--Explicação:
--Seleção de Colunas:
--d.nome: Seleciona o nome do departamento da tabela departamento.
--p.nome as nome_projeto: Seleciona o nome do projeto da tabela projeto e o renomeia como nome_projeto para clareza na saída.

--Junções:
--INNER JOIN brh.colaborador c on d.sigla = c.departamento: Junta a tabela departamento com a tabela colaborador, usando a condição de que a sigla do departamento deve ser igual ao departamento do colaborador. Isso significa que somente os colaboradores que pertencem a um departamento específico serão incluídos.
--INNER JOIN brh.atribuicao a on c.matricula = a.colaborador: Junta o resultado da junção anterior com a tabela atribuicao, baseando-se na condição de que a matrícula do colaborador deve corresponder ao colaborador na tabela atribuicao. Isso inclui apenas as atribuições que pertencem aos colaboradores já filtrados.
--INNER JOIN brh.projeto p on a.projeto = p.id: Junta o resultado da junção anterior com a tabela projeto, onde o id do projeto em atribuicao deve corresponder ao id do projeto em projeto. Isso filtra ainda mais os dados para incluir apenas os projetos aos quais os colaboradores foram atribuídos.

--Agrupamento:
--GROUP BY d.nome, p.nome: Agrupa os resultados pelas colunas d.nome (nome do departamento) e p.nome (nome do projeto). Isso é necessário para a função de agregação COUNT(*), para contar o número de registros em cada grupo único de departamento e projeto.

--Função de Agregação:
--COUNT(*): Conta o número total de registros em cada grupo formado pela cláusula GROUP BY. Isso indica o número de atribuições (ou, de forma indireta, o número de colaboradores) para cada combinação de departamento e projeto.

--Ordenação dos Resultados:
--ORDER BY d.nome, p.nome: Ordena os resultados primeiro pelo nome do departamento e depois pelo nome do projeto. Isso significa que os resultados serão listados de forma organizada, primeiramente agrupados por departamento e, dentro de cada departamento, ordenados pelos nomes dos projetos.


--CARD 5 - Listar colaboradores com mais dependentes

SELECT c.nome as nome_colaborador, COUNT(*) as Quantidade
FROM brh.colaborador c
INNER JOIN brh.dependente d 
on c.matricula = d.colaborador
GROUP BY c.nome
HAVING COUNT(*) >=2
ORDER BY COUNT(*) DESC, c.nome ASC;

--Explicação:

--Seleção de Colunas
--c.nome as nome_colaborador: Seleciona o nome do colaborador da tabela colaborador e o renomeia como nome_colaborador para a saída.
--COUNT(*) as qtd: Usa a função de agregação COUNT(*) para contar o número total de linhas (dependentes) que correspondem a cada colaborador, e nomeia essa contagem como qtd (quantidade) para a saída.

--Junções:
--INNER JOIN brh.dependente d on c.matricula = d.colaborador: Realiza uma junção interna entre as tabelas colaborador e dependente com base na condição de que a matrícula do colaborador na tabela colaborador deve ser igual à coluna colaborador na tabela dependente. Isso efetivamente filtra os dados para incluir apenas os colaboradores que têm dependentes.

--Agrupamento:
--GROUP BY c.nome: Agrupa os resultados pelo nome do colaborador. Isso é necessário para a função de agregação COUNT(*), permitindo contar o número de dependentes para cada colaborador individualmente.

--Filtro de Agrupamento:
--HAVING COUNT(*) >= 2: Aplica um filtro sobre os grupos criados pela cláusula GROUP BY, selecionando apenas aqueles grupos (ou seja, colaboradores) que têm dois ou mais dependentes associados a eles. A cláusula HAVING é usada aqui em vez de WHERE porque estamos filtrando grupos, não linhas individuais.

--Ordenação dos Resultados:
--ORDER BY COUNT(*) DESC, c.nome ASC: Ordena os resultados primeiramente pela quantidade de dependentes de forma descendente (DESC), de modo que os colaboradores com mais dependentes apareçam primeiro. Em caso de empate na quantidade de dependentes, os resultados são então ordenados pelo nome do colaborador de forma ascendente (ASC), garantindo que a listagem seja alfabética dentro de cada nível de quantidade de dependentes.



--CARD IMPORTANTE 1 - Relatório analítico de equipes

SELECT 
    p.nome AS projeto_atual,
    c.nome AS nome_colaborador,
    COALESCE(
        LISTAGG(dep.nome || ' (' || dep.parentesco || ')', ', ') WITHIN GROUP (ORDER BY dep.nome), 
        'Nada Consta'
    ) AS dependentes,
    d.nome AS nome_departamento,
    chefe.nome AS nome_chefe,
    pa.nome AS nome_papel,
    COALESCE(tm.numero, 'Nada Consta') AS telefone_movel_colaborador,
    COALESCE(tr.numero, 'Nada Consta') AS telefone_residencial_colaborador
FROM brh.departamento d
INNER JOIN brh.colaborador c ON d.sigla = c.departamento
INNER JOIN brh.colaborador chefe ON d.chefe = chefe.matricula
INNER JOIN brh.atribuicao a ON c.matricula = a.colaborador
INNER JOIN brh.projeto p ON a.projeto = p.id
INNER JOIN brh.papel pa ON a.papel = pa.id
LEFT JOIN brh.telefone_colaborador tm ON c.matricula = tm.colaborador AND tm.tipo = 'M'
LEFT JOIN brh.telefone_colaborador tr ON c.matricula = tr.colaborador AND tr.tipo = 'R'
LEFT JOIN brh.dependente dep ON c.matricula = dep.colaborador
GROUP BY p.nome, c.nome, d.nome, chefe.nome, pa.nome, tm.numero, tr.numero
ORDER BY p.nome, c.nome;

--Explicação
--Esta consulta SQL está projetada para extrair informações detalhadas sobre colaboradores de um banco de dados de recursos humanos, incluindo informações sobre os departamentos aos quais estão alocados, seus chefes, os projetos atuais em que estão trabalhando, seus papéis nesses projetos, até dois números de telefone para cada um, e os nomes de seus dependentes. A consulta faz uso de várias junções (INNER JOIN e LEFT JOIN) para unir as informações de diferentes tabelas relacionadas, e ordena os resultados por nome do projeto, nome do colaborador e nome do dependente.

--Seleção de Campos
--d.nome AS nome_departamento: Seleciona o nome do departamento.
--chefe.nome AS nome_chefe: Seleciona o nome do chefe do departamento, que é obtido por uma junção da tabela departamento com a tabela colaborador.
--c.nome AS nome_colaborador: Seleciona o nome do colaborador.
--p.nome AS projeto_atual: Seleciona o nome do projeto atual no qual o colaborador está trabalhando.
--pa.nome AS nome_papel: Seleciona o nome do papel que o colaborador desempenha no projeto.
--t1.numero AS telefone1_colaborador e t2.numero AS telefone2_colaborador: Tentam selecionar dois números de telefone para o colaborador, assumindo que possam existir mais de um.
--dep.nome AS nome_dependente: Seleciona o nome dos dependentes associados ao colaborador.

--Junções
--Junções INNER JOIN: Usadas para relacionar estritamente tabelas onde a correspondência de chaves é esperada, assegurando que só serão retornados os registros que tenham correspondência nas tabelas relacionadas.
--brh.departamento com brh.colaborador (para chefe e colaboradores): Para relacionar colaboradores aos seus departamentos e identificar o chefe de cada departamento.
--brh.atribuicao com brh.colaborador: Para ligar colaboradores às suas atribuições de projetos.
--brh.projeto com brh.atribuicao: Para conectar as atribuições aos projetos específicos.
--brh.papel com brh.atribuicao: Para identificar o papel desempenhado pelo colaborador no projeto.
--Junções LEFT JOIN: Usadas para incluir todos os registros da tabela à esquerda (brh.colaborador), mesmo se não houver correspondência na tabela à direita (brh.telefone_colaborador, brh.dependente). Isso é útil para casos em que alguns colaboradores podem não ter telefones registrados ou dependentes.
--brh.telefone_colaborador (duas vezes): Para tentar obter dois números de telefone por colaborador. No entanto, como destacado anteriormente, sem critérios adicionais para distinguir t1 de t2, esta abordagem pode não funcionar como esperado.
--brh.dependente: Para listar dependentes associados a cada colaborador.

--Ordenação
--A consulta ordena os resultados primeiro pelo nome do projeto, depois pelo nome do colaborador, e finalmente pelo nome do dependente. Isso organiza os dados de uma maneira que agrupa colaboradores pelo projeto em que estão trabalhando e, dentro de cada projeto, ordena-os alfabeticamente, juntamente com seus dependentes, também em ordem alfabética.

--Função LISTAGG
--LISTAGG é uma função de agregação em Oracle SQL que concatena valores de várias linhas de uma coluna em uma única string, separada por um delimitador definido pelo usuário. Neste caso, usamos LISTAGG para juntar os nomes dos dependentes e seus parentescos em uma coluna dependentes.
--Dentro do LISTAGG, usamos a concatenação de strings (||) para unir o nome do dependente (dep.nome) e seu parentesco (dep.parentesco), separados por parênteses. Esses pares nome-parentesco são então separados uns dos outros por vírgulas na string resultante.

--Tratamento de NULL com CASE
--Como LISTAGG retorna NULL se não houver linhas para agrupar (ou seja, se um colaborador não tiver dependentes), utilizamos uma expressão CASE para verificar o resultado de LISTAGG. Se for NULL, substituímos por "Nada Consta" para tornar a saída mais amigável.

--Junções (JOIN)
--A consulta faz várias junções internas (INNER JOIN) para relacionar colaboradores aos seus departamentos, atribuições, projetos atuais e papéis. Isso garante que só sejam considerados na consulta os colaboradores que possuem um departamento, projeto e papel definidos.
--Usamos junções à esquerda (LEFT JOIN) para os telefones móveis e residenciais e para os dependentes. Isso permite incluir colaboradores mesmo que eles não tenham números de telefone ou dependentes registrados. Os valores NULL resultantes para telefones são tratados com COALESCE, substituindo-os por "Nada Consta".

--COALESCE
--COALESCE é usada para substituir valores NULL nos números de telefone móvel e residencial, fornecendo um valor padrão "Nada Consta" caso não exista um número registrado.

--Agrupamento e Ordenação
--A cláusula GROUP BY agrupa os resultados pelas chaves únicas dos colaboradores e outras colunas selecionadas, preparando o terreno para a agregação feita por LISTAGG.
--ORDER BY ordena os resultados primeiro pelo nome do projeto (projeto_atual), depois pelo nome do colaborador (nome_colaborador), garantindo que a saída seja organizada e fácil de navegar.



--CARD IMPORTANTE 2 - Relatório analítico de equipes

SELECT 
c.matricula AS matricula_colaborador,
dep.nome AS nome_dependente,
dep.cpf AS cpf_dependente,
TO_CHAR(dep.data_nascimento, 'DD/MM/YYYY') AS data_nascimento,
dep.parentesco,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM dep.data_nascimento) - (CASE WHEN TO_CHAR(SYSDATE, 'MMDD') < TO_CHAR(dep.data_nascimento, 'MMDD') 
    THEN 1 ELSE 0 END) AS idade_dependente,
    CASE 
        WHEN EXTRACT(YEAR FROM SYSDATE) -  EXTRACT(YEAR FROM dep.data_nascimento) - (CASE WHEN TO_CHAR(SYSDATE, 'MMDD') < TO_CHAR(dep.data_nascimento, 'MMDD') 
        THEN 1 ELSE 0 END) < 18 THEN 'Menor de idade'
        ELSE 'Maior de idade'
    END AS faixa_etaria
FROM 
brh.dependente dep
INNER JOIN 
brh.colaborador c ON dep.colaborador = c.matricula
ORDER BY 
c.matricula, dep.nome;
    
--Explicação:
--Esta consulta SQL foi projetada para ser executada em um ambiente Oracle, focando em extrair informações detalhadas sobre os dependentes de colaboradores. A consulta seleciona várias informações relevantes, calcula a idade de cada dependente, determina sua faixa etária com base nessa idade e ordena os resultados pela matrícula do colaborador e pelo nome do dependente.

--Seleção de Campos
--c.matricula AS matricula_colaborador: Retorna a matrícula do colaborador associado ao dependente. Isso identifica unicamente cada colaborador dentro da organização.
--dep.nome AS nome_dependente: Mostra o nome do dependente, fornecendo uma identificação humana legível para cada entrada de dependente na lista.
--dep.cpf AS cpf_dependente: Exibe o CPF (Cadastro de Pessoas Físicas) do dependente, que é um identificador único para cidadãos no Brasil.

--TO_CHAR(dep.data_nascimento, 'DD/MM/YYYY') AS data_nascimento: Converte a data de nascimento do dependente para o formato de data brasileiro (dia/mês/ano), tornando a data mais compreensível para usuários acostumados com esse formato.

--dep.parentesco: Informa o tipo de relação de parentesco entre o dependente e o colaborador (como filho(a), cônjuge, etc.).

--Cálculo da Idade e Faixa Etária dependente

--EXTRACT(YEAR FROM SYSDATE):
--Esta expressão extrai o ano atual do sistema. SYSDATE é uma função no Oracle que retorna a data e hora atuais do sistema. Portanto, EXTRACT(YEAR FROM SYSDATE) retorna apenas o componente do ano da data atual.

--EXTRACT(YEAR FROM dep.data_nascimento):
--Semelhante à expressão acima, mas esta extrai o ano de nascimento do dependente da coluna data_nascimento na tabela dependente.

--Subtração dos Anos:
--A idade preliminar é calculada pela subtração do ano atual (obtido na etapa 1) pelo ano de nascimento do dependente (etapa 2).

--Ajuste baseado no Mês e Dia:
--A parte final da expressão ajusta a idade preliminar com base no mês e no dia atual em relação ao mês e dia de nascimento. Se o dia e mês atuais forem antes do dia e mês de nascimento do dependente, isso significa que o dependente ainda não fez aniversário no ano atual, então 1 ano é subtraído da idade preliminar.
--TO_CHAR(SYSDATE, 'MMDD') < TO_CHAR(dep.data_nascimento, 'MMDD'): Esta comparação verifica se a combinação de mês e dia atuais (convertidos em uma string MMDD para fácil comparação) é menor que a combinação de mês e dia de nascimento do dependente. Se verdadeiro (ou seja, o dependente ainda não fez aniversário no ano corrente), então 1 é subtraído da idade calculada.

--Determinação da Faixa Etária (faixa_etaria)
--A expressão CASE subsequente utiliza o mesmo cálculo de idade para classificar o dependente como 'Menor de idade' se tiver menos de 18 anos, ou 'Maior de idade' caso contrário. Essa verificação é feita comparando a idade calculada com 18 anos.

--Ordenação dos Resultados
--ORDER BY c.matricula, dep.nome: Os resultados são ordenados primeiro pela matrícula do colaborador e, em seguida, pelo nome do dependente. Esta ordenação facilita a busca e análise dos dados, agrupando todos os dependentes sob o respectivo colaborador de forma alfabética.


-- CARD IMPORTANTE 3 - Paginar listagem de colaboradores
SELECT 
    c.nome AS nome_colaborador
FROM 
    brh.colaborador c
ORDER BY 
    c.nome
OFFSET 10 ROWS -- Pula os primeiros 10 registros, correspondendo à primeira página
FETCH NEXT 10 ROWS ONLY; -- Obtém os próximos 10 registros, correspondendo à segunda página


-- Explicação:
--ORDER BY c.nome: Ordena os colaboradores pelo nome. Isso garante que a paginação seja consistente e previsível, baseando-se na ordem alfabética dos nomes dos colaboradores.

--OFFSET 10 ROWS: Pula os primeiros 10 registros, pois cada página tem 10 registros, você pula a primeira página de registros para começar na segunda página.

--FETCH NEXT 10 ROWS ONLY: Após pular os primeiros 10 registros, essa cláusula especifica que apenas os próximos 10 registros devem ser retornados, correspondendo aos registros de 11 a 20, que formam a segunda página.


--OU solução 2

SELECT * FROM (
  SELECT
    temp.*,
    ROWNUM AS rn
  FROM (
    SELECT
      c.nome AS nome_colaborador
    FROM
      brh.colaborador c
    ORDER BY
      c.nome
  ) temp
) WHERE rn BETWEEN 11 AND 20;

--Subconsulta Interna (temp):
--Primeiro, selecionamos os colaboradores e ordenamos pelo nome para garantir que a ordem seja consistente. Essa subconsulta é essencial porque ROWNUM é atribuído às linhas conforme elas são retornadas, o que significa que você precisa ordenar os resultados antes de aplicar ROWNUM.

--Subconsulta Externa:
--Em seguida, na subconsulta externa, atribuímos ROWNUM a cada linha resultante da subconsulta interna. Isso é feito na subconsulta externa para garantir que ROWNUM seja aplicado após os resultados já estarem ordenados.

--Seleção Final:
--Por fim, na consulta mais externa, filtramos as linhas baseadas no valor de rn (que representa o ROWNUM da subconsulta externa), selecionando as linhas de 11 a 20, que correspondem à segunda página de 10 registros.



--Desafio Relatório de plano de saúde

SELECT
    c.nome_colaborador, -- Seleciona o nome do colaborador da subconsulta 'c'.
    'R$ ' || TO_CHAR(c.salario, 'FM999G999G999G990D00') AS salario, -- Formata o salário do colaborador como valor monetário em reais.
    c.senioridade, -- Seleciona a senioridade do colaborador da subconsulta 'c'.
    'R$ ' || TO_CHAR(NVL(SUM(d.valor_dependente), 0) + c.valor_porcentagem_senioridade, 'FM999G999G999G990D00') AS valor_mensalidade_total, -- Calcula e formata o valor total da mensalidade, somando os valores dos dependentes (ou 0 se não houver dependentes) com o valor adicional da senioridade.
    c.descricao_senioridade || '; ' || COALESCE(LISTAGG(d.descricao_dependente, '; ') WITHIN GROUP (ORDER BY d.nome_dependente), 'Sem dependentes') AS detalhes_calculo_mensalidade -- Concatena a descrição da senioridade com as descrições dos dependentes (ou 'Sem dependentes' se não houver).
FROM (
    SELECT
        matricula, -- Seleciona a matrícula do colaborador.
        nome AS nome_colaborador, -- Seleciona o nome do colaborador.
        salario, -- Seleciona o salário do colaborador.
        CASE -- Inicia um bloco CASE para determinar o valor adicional baseado na senioridade.
            WHEN salario <= 3000 THEN 0.01 -- Se o salário for até 3000, o adicional é 1% do salário.
            WHEN salario > 3000 AND salario <= 6000 THEN 0.02 -- Se o salário estiver entre 3001 e 6000, o adicional é 2% do salário.
            WHEN salario > 6000 AND salario <= 20000 THEN 0.03 -- Se o salário estiver entre 6001 e 20000, o adicional é 3% do salário.
            ELSE 0.05 -- Para salários acima de 20000, o adicional é 5% do salário.
        END * salario AS valor_porcentagem_senioridade, -- Calcula o valor adicional da senioridade multiplicando o percentual pelo salário.
        CASE -- Inicia outro bloco CASE para determinar a categoria de senioridade baseada no salário.
            WHEN salario <= 3000 THEN 'Júnior'
            WHEN salario > 3000 AND salario <= 6000 THEN 'Pleno'
            WHEN salario > 6000 AND salario <= 20000 THEN 'Sênior'
            ELSE 'Corpo diretor'
        END AS senioridade, -- Atribui a categoria de senioridade baseada no salário.
        'Senioridade (' || CASE -- Concatena a descrição da senioridade, incluindo a categoria e o percentual aplicado.
            WHEN salario <= 3000 THEN 'Júnior - 1%'
            WHEN salario > 3000 AND salario <= 6000 THEN 'Pleno - 2%'
            WHEN salario > 6000 AND salario <= 20000 THEN 'Sênior - 3%'
            ELSE 'Corpo diretor - 5%'
        END || '): R$ ' || TO_CHAR(CASE -- Inclui também o valor monetário resultante da aplicação do percentual ao salário.
            WHEN salario <= 3000 THEN 0.01
            WHEN salario > 3000 AND salario <= 6000 THEN 0.02
            WHEN salario > 6000 AND salario <= 20000 THEN 0.03
            ELSE 0.05
        END * salario, 'FM999G999G999G990D00') AS descricao_senioridade -- Formata esse valor monetário como reais.
    FROM
        brh.colaborador -- Da tabela de colaboradores.
) c
LEFT JOIN ( -- Realiza um JOIN com a subconsulta 'd' para incluir informações dos dependentes.
    SELECT
        colaborador, -- Seleciona a matrícula do colaborador a quem o dependente está associado.
        nome AS nome_dependente, -- Seleciona o nome do dependente.
        parentesco, -- Seleciona o tipo de parentesco do dependente com o colaborador.
        data_nascimento, -- Seleciona a data de nascimento do dependente.
        CASE -- Determina o valor adicional baseado na idade do dependente.
            WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_nascimento) >= 18 THEN 50 -- Se o dependente for maior de idade, adiciona R$50.
            ELSE 25 -- Se o dependente for menor de idade, adiciona R$25.
        END AS valor_dependente, -- Calcula o valor adicional do dependente.
        nome || ' (' || parentesco || ', ' ||  -- Concatena a descrição do dependente, incluindo nome, parentesco e se é maior ou menor de idade.
        CASE
            WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_nascimento) < 18 THEN 'menor de idade: R$ 25'
            ELSE 'maior de idade: R$ 50'
        END || ')' AS descricao_dependente -- Inclui o valor monetário correspondente.
    FROM
        brh.dependente -- Da tabela de dependentes.
) d ON c.matricula = d.colaborador -- Faz a ligação dos dependentes com os respectivos colaboradores.
GROUP BY
    c.nome_colaborador, c.salario, c.senioridade, c.valor_porcentagem_senioridade, c.descricao_senioridade -- Agrupa os resultados por colaborador para permitir a agregação.
ORDER BY
    c.nome_colaborador; -- Ordena os resultados pelo nome do colaborador.

--Observação: A formatação 'FM999G999G999G990D00' usada na função TO_CHAR do Oracle SQL é um modelo de formatação numérica que define como um número deve ser convertido em texto.
--FM: O modificador FM (Fill Mode) na frente do modelo de formatação remove qualquer espaço em branco que normalmente seria incluído no início ou no final do texto formatado. Isso garante que o resultado seja uma string compacta, sem espaços extras antes do primeiro dígito ou depois do último.

--999G999G999G990D00:

--999: Representa os dígitos do número, onde cada 9 indica que o dígito naquela posição pode ser substituído por um número, se houver um número para exibir. Se não houver número suficiente para preencher todas as posições 9, o Oracle não exibe espaços extras (devido ao FM), nem zeros à esquerda. Isso permite que o número seja exibido no formato correto sem preenchimento desnecessário.
--G: Representa o separador de grupo (normalmente conhecido como separador de milhar). Em muitos países, incluindo o Brasil, esse separador é uma vírgula (,), mas pode ser um ponto (.) em sistemas configurados para usar padrões de outros países. O caracter G será substituído pelo símbolo apropriado de acordo com as configurações locais (NLS) do banco de dados.
--990: Similar aos 9s anteriores, mas aqui especificamente para assegurar a presença de pelo menos um dígito antes do separador decimal, se houver algum número a ser exibido.
--D: Representa o separador decimal. Como o G, o símbolo que substitui o D depende das configurações locais do banco de dados. Em muitas configurações, é uma vírgula (,), mas pode ser um ponto (.) dependendo da localidade.
--00: Após o D, esses zeros garantem que sempre haverá dois dígitos após o separador decimal, assegurando a formatação padrão para valores monetários, onde centavos são importantes. Se o número original tiver menos de duas casas decimais, zeros serão adicionados para preencher.
--Portanto, a formatação 'FM999G999G999G990D00' é usada para formatar números de forma que sejam exibidos como valores monetários, com separadores de milhar e duas casas decimais, adaptando-se às configurações locais de idioma e região do banco de dados, e removendo espaços em branco desnecessários.

 
 
 --  Desafio Listar colaboradores que participaram de todos os projetos
 
SELECT 
    a.colaborador,
    COUNT(DISTINCT a.projeto) AS projetos_do_colaborador,
    (SELECT nome FROM brh.colaborador WHERE matricula = a.colaborador) AS nome_colaborador
FROM 
    brh.atribuicao a
GROUP BY 
    a.colaborador
HAVING 
    COUNT(DISTINCT a.projeto) = (SELECT COUNT(*) FROM brh.projeto);







