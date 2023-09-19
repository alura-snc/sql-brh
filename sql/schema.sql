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