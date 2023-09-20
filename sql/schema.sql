CREATE TABLE TB_COLABORADOR 
( 
 matricula VARCHAR2(4),  
 cpf VARCHAR2(11),  
 telefone1 VARCHAR2(13),  
 telefone2 VARCHAR2(13),  
 e_mail_pessoal VARCHAR2(30),  
 e_mail_corporativo VARCHAR2(30),  
 cargo VARCHAR2(20),  
 departamento VARCHAR2(20)
); 

CREATE TABLE TB_CARGO 
( 
 cod_cargo VARCHAR2(20) PRIMARY KEY NOT NULL,  
 nome VARCHAR2(50) NOT NULL,  
 sigla_depto VARCHAR2(10),  
 salario NUMBER(10,2) NOT NULL  
); 

CREATE TABLE TB_DEPARTAMENTO 
( 
 sigla VARCHAR2(4) PRIMARY KEY,  
 nome VARCHAR2(10) NOT NULL,  
 chefe VARCHAR2(20),  
 departamento_superior VARCHAR2(4)  
); 

CREATE TABLE TB_DEPENDENTE 
( 
 cod_dependente VARCHAR2(4) PRIMARY KEY,  
 colaborador VARCHAR2(4),  
 nome VARCHAR2(50) NOT NULL,  
 data_nascimento DATE NOT NULL,  
 parentesco VARCHAR2(30) NOT NULL 
); 

CREATE TABLE TB_PROJETO 
( 
 id VARCHAR2(4) PRIMARY KEY,  
 nome VARCHAR2(10),  
 responsavel VARCHAR2(10),  
 inicio DATE,  
 fim DATE  
); 

CREATE TABLE TB_ATRIBUICAO 
( 
 colaborador VARCHAR2(4),  
 projeto VARCHAR2(4),  
 papel VARCHAR2(4)  
); 

CREATE TABLE TB_PAPEL 
( 
 id INT PRIMARY KEY,  
 nome VARCHAR2(10) 
); 

CREATE TABLE TB_ENDERECO 
( 
 cod_endereco VARCHAR2(20) PRIMARY KEY,  
 matricula VARCHAR2(4),  
 logradouro VARCHAR2(30) NOT NULL,  
 complemento VARCHAR2(20),  
 bairro VARCHAR2(20) NOT NULL,  
 cidade VARCHAR2(20) NOT NULL,  
 estado VARCHAR2(20) NOT NULL,  
 cep VARCHAR2(11) 
); 




INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de negócios');
INSERT INTO brh.projeto (nome, responsavel, inicio, fim) VALUES ('BI', 'D123', to_date('2022-01-01', 'yyyy-mm-dd'), to_date('2022-10-31', 'yyyy-mm-dd'));
INSERT INTO brh.endereco (cep, uf, cidade, bairro) VALUES ('11700-200', 'SP', 'Praia Grande', 'Forte');
INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('A124', 'Fulano de Tal', '140.544.345.55', '21703', 'DIR', '11700-200', 'Avenida 1', 'Casa 19');
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 99999-9999', 'M');
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 3030-4040 ', 'R');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('A124', 'fulano@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('A124', 'fulano.tal@brh.com', 'T');
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('243.231.555-67', 'A124', 'Beltrana de Tal', 'Filho(a)', to_date('2018-01-01', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('123.874.279-30', 'A124', 'Cicrana de tal', 'Cônjuge', to_date('1984-06-07', 'yyyy-mm-dd'));
INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (9, 'A124', 8);
 
select sigla, nome from brh.departamento order by nome;

SELECT brh.colaborador.nome, brh.dependente.nome, brh.dependente.data_nascimento, brh.dependente.parentesco
FROM brh.colaborador, brh.dependente
WHERE brh.colaborador.matricula = brh.dependente.colaborador
ORDER BY brh.colaborador.nome;

DELETE FROM brh.departamento WHERE brh.departamento.sigla = 'SECAP';

select * from brh.departamento;


SELECT brh.colaborador.nome, brh.email_colaborador.email , brh.telefone_colaborador.numero
FROM brh.colaborador, brh.email_colaborador, brh.telefone_colaborador
WHERE brh.colaborador.matricula = brh.email_colaborador.colaborador AND brh.email_colaborador.tipo = 'T' AND brh.telefone_colaborador.tipo = 'M';

SELECT brh.departamento.nome, brh.departamento.chefe, brh.colaborador.nome, brh.atribuicao.projeto, brh.atribuicao.papel, brh.telefone_colaborador.numero, brh.dependente.nome
FROM brh.departamento, brh.colaborador, brh.atribuicao, brh.telefone_colaborador, brh.dependente
WHERE brh.colaborador.matricula = brh.departamento.chefe AND brh.colaborador.matricula = brh.atribuicao.colaborador AND brh.colaborador.matricula = brh.telefone_colaborador.colaborador AND brh.colaborador.matricula = brh.dependente.colaborador





