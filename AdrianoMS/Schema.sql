DROP TABLE brh.papel;
DROP TABLE brh.departamento;
DROP TABLE brh.colaborador;
DROP TABLE brh.email_colaborador;
DROP TABLE brh.telefone_colaborador;
DROP TABLE brh.dependente;
DROP TABLE brh.endereco_colaborador;
DROP TABLE brh.projeto;
DROP TABLE brh.atribuicao;

alter session set "_ORACLE_SCRIPT"=true;

-- Verifique se a tablespace 'users' existe
SELECT tablespace_name FROM dba_tablespaces WHERE tablespace_name = 'USERS';

-- Conecte-se como SYSDBA
sqlplus sys as sysdba

-- Crie o usuário 'brh'
CREATE USER brh 
    IDENTIFIED BY brh
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users;

-- Conceda permissões ao usuário 'brh'
GRANT CONNECT, RESOURCE TO brh;


    
CREATE TABLE brh.papel (
    id INTEGER NOT NULL,
    nome VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_papel PRIMARY KEY (id),
    CONSTRAINT papel_unico UNIQUE (nome)
);

CREATE TABLE brh.departamento(
    sigla VARCHAR2(6) NOT NULL,
    nome VARCHAR2(255) NOT NULL,
    chefe VARCHAR(10) NOT NULL,
    departamento_superior VARCHAR2(6) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (sigla),
    CONSTRAINT fk_departamento_superior FOREIGN KEY (departamento_superior)
    references brh.departamento(sigla)

);

CREATE TABLE brh.colaborador(
    matricula VARCHAR2(10) NOT NULL,
    cpf VARCHAR2(14) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    salario NUMBER(10,2) NOT NULL,
    departamento VARCHAR2(6) NOT NULL,
    CONSTRAINT pk_colaborador PRIMARY KEY (matricula),
    CONSTRAINT fk_departamento FOREIGN KEY (departamento)
    REFERENCES brh.departamento (sigla)
);

CREATE TABLE brh.email_colaborador(
    matricula_colaborador VARCHAR2(10) NOT NULL,
    email VARCHAR2(150) NOT NULL,
    tipo CHAR(1) default 'R' NOT NULL,
    CONSTRAINT pk_email PRIMARY KEY (matricula_colaborador, email),
    CONSTRAINT fk_email_colaborador
		FOREIGN KEY (matricula_colaborador)
		REFERENCES brh.colaborador (matricula),
	CONSTRAINT tipo_email_valido CHECK (tipo in ('P', 'T'))

);

CREATE TABLE brh.telefone_colaborador(
    numero VARCHAR2(20) NOT NULL,
    matricula_colaborador VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_telefone_colaborador PRIMARY KEY (numero, matricula_colaborador),
    CONSTRAINT fk_telefone_colaborador FOREIGN KEY (matricula_colaborador)
    REFERENCES brh.colaborador (matricula)
);

CREATE TABLE brh.dependente(
    cpf VARCHAR2(14) NOT NULL,
    matricula_colaborador VARCHAR2(10) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    parentesco VARCHAR(20) NOT NULL,
    CONSTRAINT pk_dependente PRIMARY KEY (cpf, matricula_colaborador),
    CONSTRAINT fk_dependente_colaborador FOREIGN KEY (matricula_colaborador)
    REFERENCES brh.colaborador (matricula)
);

CREATE TABLE brh.endereco_colaborador(
    matricula_colaborador VARCHAR2(10) NOT NULL,
    cep VARCHAR2(10) NOT NULL,
    estado VARCHAR2(30) NOT NULL,
    cidade VARCHAR2(150) NOT NULL,
    bairro VARCHAR2(150) NOT NULL,
    logradouro VARCHAR2(30) NOT NULL,
    complemento VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_endereco_colaborador PRIMARY KEY (cep, matricula_colaborador),
    CONSTRAINT fk_endereco_colaborador FOREIGN KEY (matricula_colaborador)
    REFERENCES brh.colaborador (matricula)

);

CREATE TABLE brh.projeto(
    id INTEGER NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    responsavel VARCHAR2(10) NOT NULL,
    inicio DATE NOT NULL,
    fim DATE,
    CONSTRAINT pk_projeto PRIMARY KEY (id),
    CONSTRAINT f_projeto_responsavel FOREIGN KEY (responsavel)
    REFERENCES brh.colaborador (matricula)

);

CREATE TABLE brh.atribuicao(
    colaborador VARCHAR2(10) NOT NULL,
    projeto INTEGER NOT NULL,
    papel INTEGER NOT NULL,
    CONSTRAINT pk_atribuicao PRIMARY KEY (colaborador, projeto, papel),
    CONSTRAINT fk_atribuicao_colaborador FOREIGN KEY (colaborador)
    REFERENCES brh.colaborador (matricula),
    CONSTRAINT fk_atribuicao_projeto FOREIGN KEY (projeto)
    REFERENCES brh.projeto (id),
    CONSTRAINT fk_atribuicao_papel FOREIGN KEY (papel)
    REFERENCES brh.papel (id)
);


ALTER TABLE brh.departamento 
	add CONSTRAINT fk_chefe_departamento
	FOREIGN KEY (chefe) 
	REFERENCES brh.colaborador (matricula)
	DEFERRABLE INITIALLY DEFERRED;
    
    
COMMIT;
