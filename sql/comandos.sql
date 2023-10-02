-- Inserir o novo CEP. Ele não adiciona o colaborador se não colocar o CEP... (PK..)
INSERT INTO c##brh.endereco(cep, uf, cidade, bairro)
VALUES ('12345-678', 'SP', 'Ribeirão Preto', 'Ipiranga');

INSERT INTO C##brh.COLABORADOR (matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco)
VALUES ('Fulano123', '123.456.789-01', 'Fulano de Tal', 5000.00, 'SEDES', '12345-678', 'Rua A, 123', 'Apt 2B');

INSERT INTO C##brh.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES ('(61) 9 9999-9999', 'Fulano123', 'M'); -- Mobile phone

INSERT INTO C##brh.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES ('(61) 3030-4040', 'Fulano123', 'R'); 

INSERT INTO C##brh.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES ('fulano@email.com', 'Fulano123', 'P'); 

INSERT INTO C##brh.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES ('fulano.tal@brh.com', 'Fulano123', 'T'); 

INSERT INTO C##brh.PROJETO (nome, responsavel, inicio, fim)
VALUES ('BI', 'Fulano123', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));

INSERT INTO C##brh.PAPEL (nome)
VALUES ('Especialista de Negócios');

INSERT INTO C##brh.ATRIBUICAO (colaborador, projeto, papel)
VALUES ('Fulano123', (SELECT id FROM C##brh.PROJETO WHERE nome = 'BI'), (SELECT id FROM C##brh.PAPEL WHERE nome = 'Especialista de Negócios'));

INSERT INTO C##brh.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES ('111.222.333-44', 'Beltrana de Tal', TO_DATE('2000-01-15', 'YYYY-MM-DD'), 'Filho(a)', 'Fulano123');

INSERT INTO C##brh.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES ('222.333.444-55', 'Cicrana de Tal', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 'Cônjuge', 'Fulano123');

-- CONSULTA DEPARTAMENTO
SELECT sigla, nome
FROM C##brh.DEPARTAMENTO
ORDER BY nome;

-- CONSULTA DEPENDENTES
SELECT C.nome AS "Nome do Colaborador", D.nome AS "Nome do Dependente", D.data_nascimento AS "Data de Nascimento do Dependente", D.parentesco AS "Parentesco do Dependente"
FROM C##brh.COLABORADOR C
INNER JOIN C##brh.DEPENDENTE D ON C.matricula = D.colaborador
ORDER BY C.nome, D.nome;

-- REMOVE DP ESPECIFICO
-- Remover Atribuições
DELETE FROM C##brh.ATRIBUICAO WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover Dependentes
DELETE FROM C##brh.DEPENDENTE WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover Telefones
DELETE FROM C##brh.TELEFONE_COLABORADOR WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover E-mails
DELETE FROM C##brh.EMAIL_COLABORADOR WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover colaboradores (não deve ser a tabela TELEFONE_COLABORADOR)
DELETE FROM C##brh.COLABORADOR WHERE departamento = 'SECAP';
-- Remover Departamento
DELETE FROM C##brh.DEPARTAMENTO WHERE sigla = 'SECAP';

-- RELATORIO DE CONTATO
SELECT
    C.nome AS "Nome",
    E.email AS "Email",
    T.numero AS "Telefone"
FROM
    C##brh.COLABORADOR C
LEFT JOIN
    C##brh.EMAIL_COLABORADOR E ON C.matricula = E.colaborador AND E.tipo = 'T'
LEFT JOIN
    C##brh.TELEFONE_COLABORADOR T ON C.matricula = T.colaborador AND T.tipo = 'M'
ORDER BY
    "Nome";

-- DESAFIO RELATORIO ANALITICO
SELECT
    D.nome AS "Departamento",
    D.chefe AS "Chefe do Departamento",
    C.nome AS "Colaborador",
    P.nome AS "Projeto",
    PA.nome AS "Nome do Papel",
    TO_CHAR(TC.numero) AS "Telefone",
    DE.nome AS "Dependente"
FROM
    C##brh.DEPARTAMENTO D
JOIN
    C##brh.COLABORADOR C ON D.sigla = C.departamento
LEFT JOIN
    C##brh.PROJETO P ON C.matricula = P.responsavel
LEFT JOIN
    C##brh.PAPEL PA ON C.matricula = TO_CHAR(PA.id)
LEFT JOIN
    C##brh.TELEFONE_COLABORADOR TC ON C.matricula = TC.colaborador
LEFT JOIN
    C##brh.DEPENDENTE DE ON C.matricula = DE.colaborador
ORDER BY
    "Projeto", "Colaborador", "Dependente";

-- LISTA DEPENDENTES

SELECT C##BRH.DEPENDENTE.*,C##BRH.COLABORADOR.nome AS "Nome do Colaborador"  
FROM C##BRH.DEPENDENTE 
INNER JOIN C##BRH.COLABORADOR 
ON C##BRH.COLABORADOR.MATRICULA = C##BRH.DEPENDENTE.COLABORADOR
WHERE (EXTRACT(MONTH FROM C##BRH.DEPENDENTE.DATA_NASCIMENTO) IN (4,5,6))
OR (UPPER(C##BRH.DEPENDENTE.NOME) LIKE '%H%') ORDER BY C##BRH.COLABORADOR.nome,C##BRH.DEPENDENTE.NOME;

-- LISTA COLABORADOR MAIOR SALARIO

SELECT
    nome,
    salario
FROM
    c##brh.colaborador
WHERE salario = (SELECT MAX(salario) FROM c##brh.colaborador);

-- RELATORIO SENIORIDADE

SELECT
    matricula,
    nome,
    salario,
    CASE
        WHEN salario BETWEEN 0 AND 3000 THEN 'JUNIOR'
        WHEN salario BETWEEN 3000.01 AND 6000 THEN 'PLENO'
        WHEN salario BETWEEN 6000.01 AND 20000 THEN 'SENIOR'
        WHEN salario > 20000 THEN 'CORPO DIRETOR'
        ELSE 'DESCONHECIDO'
    END AS SENIORIDADE
FROM
    c##brh.colaborador
ORDER BY
    SENIORIDADE, NOME;

-- LISTAR COLABORADOR EM PROJETO

SELECT
    C##brh.DEPARTAMENTO.nome AS Nome_Departamento,
    C##brh.PROJETO.nome AS Nome_Projeto,
    COUNT(C##brh.ATRIBUICAO.colaborador) AS Quantidade_Colaboradores
FROM
    C##brh.DEPARTAMENTO
INNER JOIN
    C##brh.COLABORADOR ON C##brh.DEPARTAMENTO.sigla = C##brh.COLABORADOR.departamento
INNER JOIN
    C##brh.ATRIBUICAO ON C##brh.COLABORADOR.matricula = C##brh.ATRIBUICAO.colaborador
INNER JOIN
    C##brh.PROJETO ON C##brh.ATRIBUICAO.projeto = C##brh.PROJETO.id
GROUP BY
    C##brh.DEPARTAMENTO.nome, C##brh.PROJETO.nome
ORDER BY
    C##brh.DEPARTAMENTO.nome, C##brh.PROJETO.nome;


-- LISTAR COLABORADORES COM MAIS DEPENDENTES
-- No relatório deve ter somente colaboradores com 2 ou mais dependentes.
-- Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente.

SELECT 
    C.NOME,
    COUNT(*) AS "QUANTIDADE DE DEPENDENTES"
FROM
    BRH.DEPENDENTE D
INNER JOIN
    BRH.COLABORADOR C ON D.COLABORADOR = C.MATRICULA
GROUP BY 
    C.NOME
HAVING (COUNT(*)) >= 2
ORDER BY
   "QUANTIDADE DE DEPENDENTES" DESC, C.NOME;


-- LISTAR FAIXA ETÁRIA DOS DEPENDENDES
-- Criando consulta que liste o CPF do dependente, o nome do dependente, a data de nascimento (formato brasileiro), parentesco, matrícula do colaborador, a idade do dependente e sua faixa etária;
-- Se o dependente tiver menos de 18 anos, informar a faixa etária Menor de idade;
-- Se o dependente tiver 18 anos ou mais, informar faixa etária Maior de idade;
-- Ordenar consulta por matrícula do colaborador e nome do dependente.

SELECT 
    CPF,
    NOME AS "NOME DO DEPENDENTE",
    TO_CHAR(DATA_NASCIMENTO,'DD/MM/YYYY') AS "DATA DE NASCIMENTO",
    PARENTESCO,
    COLABORADOR AS "MATRICULA DO COLABORADOR",
    TRUNC((MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO))/12) AS IDADE,
    CASE 
        WHEN (TRUNC((MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO))/12)) < 18 THEN 'MENOR DE IDADE'
        ELSE 'MAIOR DE IDADE'
    END AS "FAIXA ETÁRIA"
FROM 
    BRH.DEPENDENTE
ORDER BY
    COLABORADOR, NOME;


-- PAGINAR LISTAGEM DE COLABORADORES
-- O usuário quer paginar a listagem de colaboradores em páginas de 10 registros cada. Há 26 colaboradores na base, então há 3 páginas:
-- Página 1: da Ana ao João (registros 1 ao 10);
-- Página 2: da Kelly à Tati (registros 11 ao 20); e
-- Página 3: do Uri ao Zico (registros 21 ao 26).
-- Crie uma consulta que liste a segunda página
-- Ordene pelo nome do colaborador.

SELECT 
    *    
FROM 
    BRH.COLABORADOR
ORDER BY NOME
OFFSET 10 ROWS
 FETCH NEXT 10 ROWS ONLY;

 

