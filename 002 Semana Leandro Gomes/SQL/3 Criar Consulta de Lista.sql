-- TAREFA 01 INSERIR COLABORADOR
-- 1) ADICIONAR PAPEL DESEMPENHADO
Select * from brh.papel;
INSERT INTO brh.papel (id, nome) VALUES (8, 'ESPECIALISTA DE NEGÓCIOS');


-- 2) ADICIONANDO NOVO DEPARTAMENTO
Select * from brh.departamento;
INSERT INTO brh.departamento (sigla, nome, chefe, departamento_superior) 
VALUES ('NPROJ', 'NOVO PROJETO BI', 'EU', 'DIR');

UPDATE brh.departamento SET chefe = 'A123' WHERE SIGLA = 'NPROJ';

DELETE FROM brh.departamento WHERE SIGLA = 'NPROJ';

-- 3) ADICIONANDO ENDEREÇO
Select * from brh.endereco;
INSERT INTO brh.endereco (cep, uf, cidade, bairro) 
VALUES ('72345-150', 'SP', 'GUARULHOS', 'SÃO PAULO');


-- 4) ADICIONANDO COLABORADOR
Select * from brh.colaborador;
INSERT INTO brh.colaborador (matricula,cpf,nome,salario,departamento,cep,
logradouro,complemento_endereco) 
VALUES ('A000','123.456.789-00','Fulano','12345','DEPTI','72345-150',
'Bryantown','AP 12');

UPDATE brh.colaborador SET logradouro = 'BOTANICO' WHERE matricula = 'A000';


-- 5) ADICIONANDO TELEFONE
Select * from brh.telefone_colaborador;
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) 
VALUES ('A123', '(99) 99999-9999', 'M'); 
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) 
VALUES ('A123', '(88) 8888-8888', 'R');

UPDATE brh.telefone_colaborador SET colaborador = 'Z123' WHERE colaborador = 'A123';


-- 6) ADICIONANDO E-MAIL
Select * from brh.email_colaborador;
INSERT INTO brh.email_colaborador (colaborador, email, tipo) 
VALUES ('Z123', 'FULANO@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) 
VALUES ('Z123', 'fulanocorp@corporativo.com', 'T');


-- 7) ADICIONANDO DEPENDENTES
Select * from brh.dependente;
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('111.111.111-11', 'Z123', 'Beltrana de Tal', 'Filho(a)', to_date('2017-03-06', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('222.222.222-22', 'Z123', 'Cicrana de Tal', 'Cônjuge', to_date('2000-09-10', 'yyyy-mm-dd'));


-- 8) CADASTRO DO PROJETO
Select * from brh.projeto;
INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) 
VALUES (5, 'BI', 'Z123', to_date('2022-01-01', 'yyyy-mm-dd'), null);


-- 9) ATRIBUINDO PROJETO
Select * from brh.atribuicao;
INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'Z123', 8);

-- TAREFA 2 ATUALIZAÇÃO DE CADASTRO DE COLABORADOR--
-- 1)Nome do Colaborador
Select * from brh.colaborador;
Select * from brh.colaborador where nome Like '%Maria%';

UPDATE brh.colaborador SET nome = 'Maria Mendonça' WHERE matricula = 'M123';
Select * from brh.colaborador where nome Like '%Maria%';

-- 2)E-mail do Colaborador
Select * from brh.email_colaborador;
Select * from brh.email_colaborador where email like '%maria%';

UPDATE brh.email_colaborador SET email = 'maria.mendonca@email.com' WHERE colaborador = 'M123' and tipo = 'P';
UPDATE brh.email_colaborador SET email = 'maria.mendonca@corporativo.com' WHERE colaborador = 'M123' and tipo = 'T';

-- TAREFA 3 CRIAR CONSULTA DE LISTA --
-- 1)matricula do colaborador;
Select * from brh.colaborador;
Select MATRICULA from brh.colaborador;

-- 2)nome do dependente;
SELECT * from brh.dependente
SELECT NOME from brh.dependente;

-- 3)data de nascimento do dependente
SELECT * from brh.dependente
SELECT DATA_NASCIMENTO from brh.dependente;

-- 4) UDAR AS 3 VARIAVEIS ACIMA --
SELECT COLABORADOR, NOME, DATA_NASCIMENTO, PARENTESCO from brh.dependente
WHERE parentesco = 'Cônjuge'; 


