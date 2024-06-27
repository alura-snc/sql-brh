
CREATE TABLE brh_Departamento (
    sigla_departamento VARCHAR2(10) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    departamento_superior VARCHAR2(50),
    chefe VARCHAR2(15) NOT NULL
);


CREATE TABLE brh_Colaborador (
    matricula VARCHAR2(15) NOT NULL PRIMARY KEY,
    departamento VARCHAR2(50) NOT NULL,
    cpf VARCHAR2(11) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_brh_Colaborador_Departamento FOREIGN KEY (departamento)
        REFERENCES brh_Departamento(sigla_departamento)
);


CREATE TABLE brh_Projeto (
    id_projeto VARCHAR2(8) NOT NULL PRIMARY KEY,
    nome VARCHAR2(150) NOT NULL,
    inicio DATE NOT NULL,
    fim DATE,
    matricula VARCHAR2(15) NOT NULL,
    CONSTRAINT FK_brh_Projeto_Colaborador FOREIGN KEY (matricula)
        REFERENCES brh_Colaborador(matricula)
);


CREATE TABLE brh_Telefones (
    colaborador VARCHAR2(15) NOT NULL,
    telefones VARCHAR2(30),
    tipo VARCHAR2(18),
    CONSTRAINT PK_brh_Telefones PRIMARY KEY (colaborador),
    CONSTRAINT FK_brh_Telefones_Colaborador FOREIGN KEY (colaborador)
        REFERENCES brh_Colaborador(matricula)
);


CREATE TABLE brh_Emails (
    colaborador VARCHAR2(15) NOT NULL,
    emails VARCHAR2(100),
    CONSTRAINT PK_brh_Emails PRIMARY KEY (colaborador),
    CONSTRAINT FK_brh_Emails_Colaborador FOREIGN KEY (colaborador)
        REFERENCES brh_Colaborador(matricula)
);


CREATE TABLE brh_Dependente (
    cpf VARCHAR2(11) NOT NULL PRIMARY KEY,
    colaborador VARCHAR2(15) NOT NULL,
    nome VARCHAR2(150) NOT NULL,
    parentesco VARCHAR2(30) NOT NULL,
    data_nascimento DATE NOT NULL,
    CONSTRAINT FK_brh_Dependente_Colaborador FOREIGN KEY (colaborador)
        REFERENCES brh_Colaborador(matricula)
);


CREATE TABLE brh_Endereco (
    cep VARCHAR2(8) NOT NULL PRIMARY KEY,
    logradouro VARCHAR2(150) NOT NULL,
    bairro VARCHAR2(50) NOT NULL,
    complemento VARCHAR2(10),
    cidade VARCHAR2(50) NOT NULL,
    estado VARCHAR2(2) NOT NULL,
    colaborador VARCHAR2(15) NOT NULL,
    CONSTRAINT FK_brh_Endereco_Colaborador FOREIGN KEY (colaborador)
        REFERENCES brh_Colaborador(matricula)
);


CREATE TABLE brh_Papel (
    id_papel VARCHAR2(10) NOT NULL PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL
);


CREATE TABLE brh_Atribuicao (
    matricula VARCHAR2(15) NOT NULL,
    id_projeto VARCHAR2(8) NOT NULL,
    id_papel VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_brh_Atribuicao PRIMARY KEY (matricula, id_projeto, id_papel),
    CONSTRAINT FK_brh_Atribuicao_Colaborador FOREIGN KEY (matricula)
        REFERENCES brh_Colaborador(matricula),
    CONSTRAINT FK_brh_Atribuicao_Projeto FOREIGN KEY (id_projeto)
        REFERENCES brh_Projeto(id_projeto),
    CONSTRAINT FK_brh_Atribuicao_Papel FOREIGN KEY (id_papel)
        REFERENCES brh_Papel(id_papel)
);
