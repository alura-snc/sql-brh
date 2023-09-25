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


