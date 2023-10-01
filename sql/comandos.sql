-- Novo Bairro
INSERT INTO brh.endereco (cep, uf, cidade, bairro) 
VALUES ('11015-003', 'SP', 'Santos', 'Vila Matias');

-- Novo Colaborador
INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES ('A124', 'Guilherme', '368.174.850-02', '15321', 'DEPTI', '11015-003', 'Av. Conselheiro Nébias', '309');

-- Novos Telefones: Celular ('M'), Residencial ('R') e Corporativo ('C').
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) 
VALUES ('A124', '(13) 97483-7325', 'M');
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) 
VALUES ('A124', '(13) 3361-2052', 'R');
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) 
VALUES ('A124', '(13) 2105-7764', 'C');

-- Novos E-mails: Particular ('P') e Corporativo ('T').
INSERT INTO brh.email_colaborador (colaborador, email, tipo) 
VALUES ('A124', 'guilherme@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) 
VALUES ('A124', 'guilherme@corporativo.com', 'T');

-- Dependentes
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('373.554.600-56', 'A124', 'Adelaide', 'CÃ´njuge', to_date('1991-11-10', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('575.362.630-07', 'A124', 'Luiza', 'Filho(a)', to_date('2018-06-02', 'yyyy-mm-dd'));

-- Novo Projeto
INSERT INTO brh.projeto (nome, responsavel, inicio, fim) 
VALUES ('BI', 'A124', to_date('2023-09-25', 'yyyy-mm-dd'), null);

-- Papel do Colaborador no Projeto BI
INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'A124', 4);

-- Relatório de Departamentos
SELECT sigla, nome FROM brh.departamento ORDER BY nome;

-- Relatório de Dependentes
SELECT
    C.nome AS "Nome do Colaborador",
    D.nome AS "Nome do Dependente",
    D.data_nascimento AS "Data de Nascimento do Dependente",
    D.parentesco AS "Parentesco do Dependente"
FROM
    brh.colaborador C
INNER JOIN
    brh.dependente D
ON
    C.matricula = D.colaborador
ORDER BY
C.nome, D.nome;

-- Excluir Departamento
DELETE FROM brh.departamento
WHERE sigla = 'SECAP';

-- Relatório de Contatos
SELECT
    C.nome AS "Nome do Colaborador",
    E.email AS "Email de Trabalho",
    TC.numero AS "Telefone Celular"
FROM
    brh.colaborador C
LEFT JOIN
    brh.email_colaborador E
ON
    C.matricula = E.colaborador
    AND E.tipo = 'T'
LEFT JOIN
    brh.telefone_colaborador TC
ON
    C.matricula = TC.colaborador
    AND TC.tipo = 'M'
ORDER BY
    "Nome do Colaborador";

-- Relatório Análitico de Equipes
SELECT
    D.nome AS "Nome do Departamento",
    C1.nome AS "Nome do Chefe do Departamento",
    C2.nome AS "Nome do Colaborador",
    P.nome AS "Nome do Projeto",
    PA.nome AS "Nome do Papel",
    TC.numero AS "Número de Telefone",
    DP.nome AS "Nome do Dependente"
FROM
    brh.departamento D
LEFT JOIN
    brh.colaborador C1
ON
    D.chefe = C1.matricula
LEFT JOIN
    brh.colaborador C2
ON
    D.sigla = C2.departamento
LEFT JOIN
    brh.atribuicao A
ON
    C2.matricula = A.colaborador
LEFT JOIN
    brh.projeto P
ON
    A.projeto = P.id
LEFT JOIN
    brh.papel PA
ON
    A.papel = PA.id
LEFT JOIN
    brh.telefone_colaborador TC
ON
    C2.matricula = TC.colaborador
    AND TC.tipo = 'M' 
LEFT JOIN
    brh.dependente DP
ON
    C2.matricula = DP.colaborador
ORDER BY
    "Nome do Projeto", "Nome do Colaborador", "Nome do Dependente";

-- Semana 3 
-- Filtrar Dependentes
SELECT * FROM brh.dependente
WHERE (EXTRACT(MONTH FROM data_nascimento) IN (4, 5, 6))
    OR (UPPER(nome) LIKE '%H%');

-- Listar Colaborador com Maior Salário
SELECT nome, salario
FROM brh.colaborador
WHERE salario = (SELECT MAX(salario) FROM brh.colaborador);

-- Relatório de Senioridade
SELECT
    matricula,
    nome,
    salario,
    CASE
        WHEN salario > 20000 THEN 'Corpo Diretor'
        WHEN salario > 6000 THEN 'Sênior'
        WHEN salario > 3000 THEN 'Pleno'
        ELSE 'Júnior'
    END AS nivel_senioridade
FROM
    brh.colaborador
ORDER BY
    DECODE(
        CASE
            WHEN salario > 20000 THEN 'Corpo Diretor'
            WHEN salario > 6000 THEN 'Sênior'
            WHEN salario > 3000 THEN 'Pleno'
            ELSE 'Júnior'
        END,
        'Corpo Diretor', 1,
        'Júnior', 2,
        'Pleno', 3,        
        'Sênior', 4        
    ),
    nome;









