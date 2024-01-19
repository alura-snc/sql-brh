-- Novo Bairro para endere�o
INSERT INTO brh.endereco (cep, uf, cidade, bairro) VALUES ('11015-003', 'SP', 'Santos', 'Vila Mathias');

-- Novo Colaborador
INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES ('A124', 'Guilherme', '368.174.850-02', 10000, 'DEPTI', '11015-003', 'Av. Conselheiro N�bias', '309');

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
VALUES ('373.554.600-56', 'A124', 'Adelaide', 'Cônjuge', to_date('1991-11-10', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('575.362.630-07', 'A124', 'Luiza', 'Filho(a)', to_date('2018-06-02', 'yyyy-mm-dd'));

-- Novo Projeto
INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) 
VALUES (5, 'BI', 'A124', to_date('2023-09-25', 'yyyy-mm-dd'), null);

-- Papel do Colaborador no Projeto BI
INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'A124', 1);

-- Relat�rio de C�njuges
SELECT
  C.nome AS "Nome do Colaborador",
  D.nome AS "Nome do C�njuge",
  D.data_nascimento AS "Data de Nascimento do C�njuge"
FROM
  brh.colaborador C
JOIN
  brh.dependente D
ON 
  C.matricula = D.colaborador
WHERE
  D.parentesco = 'Cônjuge'
ORDER BY
  C.nome;
 
-- Filtrar Dependentes
SELECT
  C.nome AS "Nome do Colaborador",
  D.nome AS "Nome do Dependente",
  D.parentesco AS "Parentesco",
  D.data_nascimento AS "Data de Nascimento do Dependente"
FROM
  brh.colaborador C
JOIN
  brh.dependente D
ON 
  C.matricula = D.colaborador
WHERE
  (EXTRACT(MONTH FROM D.data_nascimento) IN (4, 5, 6) OR D.nome LIKE '%h%')
ORDER BY
  D.nome;

-- Listar colaborador com maior sal�rio
SELECT
  nome AS "Nome do Colaborador",
  salario AS "Sal�rio"
FROM
  brh.colaborador
WHERE
  salario = (SELECT MAX(salario) FROM brh.colaborador);

