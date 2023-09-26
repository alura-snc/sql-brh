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

