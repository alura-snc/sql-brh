CREATE TABLE TB_BI
(
CPF VARCHAR2 (14),
COLABORADOR VARCHAR2(50),
DATA_NASCIMENTO DATE,
IDADE INTEGER,
SEXO VARCHAR2(1),
TELEFONE_CELULAR VARCHAR2(13),
TELEFONE_RESIDENCIAL VARCHAR2(12),
EMAIL_PESSOAL VARCHAR2(50),
EMAIL_TRABALHO VARCHAR2(50),
DEPENDENTE1 VARCHAR2(50),
DEPENDENTE2 VARCHAR2(50),
ENDERECO VARCHAR2(150),
BAIRRO VARCHAR2(50),
CIDADE VARCHAR2(50),
ESTADO VARCHAR2(2),
CEP VARCHAR2(9)
);

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep)
VALUES ('123.789.654-11','Fulano de Tal','01/05/95',28,'M','(61)99999-9999','(19)3030-4040',
'fulano@email.com','fulano.tal@brh.com','Filha Beltrana de Tal','Esposa Cicrana de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001');

SELECT * FROM TB_BI;

ALTER TABLE TB_BI
ADD DEPARTAMENTO VARCHAR2(50);

UPDATE TB_BI SET departamento = 'Financeiro' WHERE CPF = '123.789.654-11';

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep,departamento)
VALUES ('023.789.654-11','Pedro de Tal','01/01/00',23,'M','(61)99999-9999','(19)3030-4040',
'pedro@email.com','pedro.tal@brh.com','Filha Julha de Tal','Esposa Alguma de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001','RH');

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep,departamento)
VALUES ('123.719.654-11','Fulano de Tal','01/05/95',28,'M','(61)99999-9999','(19)3030-4040',
'fulano@email.com','fulano.tal@brh.com','Filha Beltrana de Tal','Esposa Cicrana de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001','Comercial');

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep,departamento)
VALUES ('103.719.654-11','Fulano de Tal','01/05/95',28,'M','(61)99999-9999','(19)3030-4040',
'fulano@email.com','fulano.tal@brh.com','Filha Beltrana de Tal','Esposa Cicrana de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001','Operacional');

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep,departamento)
VALUES ('120.719.654-11','Fulano de Tal','01/05/95',28,'M','(61)99999-9999','(19)3030-4040',
'fulano@email.com','fulano.tal@brh.com','Filha Beltrana de Tal','Esposa Cicrana de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001','TI');

SELECT * FROM tb_bi ORDER BY departamento ASC;

UPDATE tb_bi SET colaborador = 'Paulo' where cpf = '123.719.654-11';
UPDATE tb_bi SET colaborador = 'Fernanda' where cpf = '123.789.654-11';
UPDATE tb_bi SET colaborador = 'Renata' where cpf = '103.719.654-11';
UPDATE tb_bi SET colaborador = 'Giovanna' where cpf = '120.719.654-11';

UPDATE tb_bi SET dependente1 = 'Giordana' where cpf = '123.719.654-11';
UPDATE tb_bi SET dependente1 = 'Rafael' where cpf = '123.789.654-11';
UPDATE tb_bi SET dependente1 = 'Guilherme' where cpf = '103.719.654-11';
UPDATE tb_bi SET dependente1 = 'Joao' where cpf = '120.719.654-11';

ALTER TABLE TB_BI
ADD PARENTESCO_DEPENDENTE VARCHAR2(50);

UPDATE tb_bi SET PARENTESCO_DEPENDENTE = 'Nunes' where cpf = '023.789.654-11';
UPDATE tb_bi SET PARENTESCO_DEPENDENTE = 'Osvaldo' where cpf = '123.719.654-11';
UPDATE tb_bi SET PARENTESCO_DEPENDENTE = 'Augusta' where cpf = '123.789.654-11';
UPDATE tb_bi SET PARENTESCO_DEPENDENTE = 'Edson' where cpf = '103.719.654-11';
UPDATE tb_bi SET PARENTESCO_DEPENDENTE = 'Roberto' where cpf = '120.719.654-11';

ALTER TABLE TB_BI
ADD data_nascimento_dependente DATE;

UPDATE tb_bi SET data_nascimento_dependente = '01/05/71' where cpf = '023.789.654-11';
UPDATE tb_bi SET data_nascimento_dependente = '05/12/75' where cpf = '123.719.654-11';
UPDATE tb_bi SET data_nascimento_dependente = '30/08/66' where cpf = '123.789.654-11';
UPDATE tb_bi SET data_nascimento_dependente = '02/09/73' where cpf = '103.719.654-11';
UPDATE tb_bi SET data_nascimento_dependente = '25/11/70' where cpf = '120.719.654-11';

SELECT colaborador, dependente1, data_nascimento_dependente, PARENTESCO_DEPENDENTE FROM tb_bi ORDER BY colaborador ASC;

CREATE TABLE TB_RELATORIO_EQUIPES
(
DEPARTAMENTO VARCHAR2 (50),
CEFE_DEPARTAMENTO VARCHAR2 (50),
COLABORADOR VARCHAR2 (50),
PROJETO VARCHAR2 (50),
DESEMPENHADO VARCHAR2 (50),
TEL_COLABORADOR VARCHAR2 (14),
DEPENDENTE_COLABORADOR VARCHAR2 (50)
);

INSERT INTO TB_RELATORIO_EQUIPES (
DEPARTAMENTO, CEFE_DEPARTAMENTO, COLABORADOR,PROJETO,
DESEMPENHADO,TEL_COLABORADOR,DEPENDENTE_COLABORADOR)
VALUES (
'TI', 'CHEFE TI', 'COLABORADOR UM','HTML',
'PÁGINA 23','(19)2020-3030','Filho e Esposa');

INSERT INTO TB_RELATORIO_EQUIPES (
DEPARTAMENTO, CEFE_DEPARTAMENTO, COLABORADOR,PROJETO,
DESEMPENHADO,TEL_COLABORADOR,DEPENDENTE_COLABORADOR)
VALUES (
'RH', 'CHEFE ADM', 'COLABORADOR QUATRO','HOLERITE DOS FUNCIONARIOS',
'ADIANTADO','(19)2020-4031','Nenhum');

INSERT INTO TB_RELATORIO_EQUIPES (
DEPARTAMENTO, CEFE_DEPARTAMENTO, COLABORADOR,PROJETO,
DESEMPENHADO,TEL_COLABORADOR,DEPENDENTE_COLABORADOR)
VALUES (
'BIBLIOTECA', 'CHEFE BIBLIOTECA', 'COLABORADORA NOVE','DEVOLUCAO DE LIVROS',
'5 PESSOAS AINDA NAO DEVOLVERAM OS LIVROS','(19)2020-1031','Esposo');

INSERT INTO TB_RELATORIO_EQUIPES (
DEPARTAMENTO, CEFE_DEPARTAMENTO, COLABORADOR,PROJETO,
DESEMPENHADO,TEL_COLABORADOR,DEPENDENTE_COLABORADOR)
VALUES (
'FINANCEIRO', 'CHEFE ADM', 'COLABORADORA UM','RECEBIMENTO E PERDA',
'CONFIRMACAO DE 4 PAGAMENTOS E 14 CANCELAMENTOS DE COMPRA','(19)2020-0031','FILHA');

INSERT INTO TB_RELATORIO_EQUIPES (
DEPARTAMENTO, CEFE_DEPARTAMENTO, COLABORADOR,PROJETO,
DESEMPENHADO,TEL_COLABORADOR,DEPENDENTE_COLABORADOR)
VALUES (
'FALTAS', 'CHEFE SEC', 'COLABORADOR CINCO','VERIFICAR FALTAS DOS ALUNOS',
'TENTANDO ENTRAR EM CONTATO COM 3 ALUNAS E 1 CANCELADA','(19)2020-0041','NENHUM');

SELECT * FROM TB_RELATORIO_EQUIPES;

SELECT PROJETO, colaborador, DEPENDENTE_COLABORADOR FROM tb_relatorio_equipes ORDER BY colaborador ASC