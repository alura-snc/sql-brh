-- TB ATRIBUICAO
CREATE TABLE ATRIBUICAO (
    colaborador NVARCHAR2(100),
    projeto NUMBER,
    papel NVARCHAR2(100),
    PRIMARY KEY (projeto, colaborador, papel)
);

-- TB COLABORADOR
CREATE TABLE COLABORADOR (
    matricula VARCHAR2(20) NOT NULL,
    departamento VARCHAR2(50) NOT NULL,
    email_colab VARCHAR2(100),
    telefones_colab VARCHAR2(100),
    endereco_colab VARCHAR2(200),
    cpf VARCHAR2(14) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    salario NUMBER(10, 2),
    PRIMARY KEY (matricula, departamento)
);

-- TB DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    sigla NVARCHAR2(20) PRIMARY KEY,
    nome NVARCHAR2(100),
    chefe NVARCHAR2(20),
    departamento_superior NVARCHAR2(20)
);

-- TB DEPENDENTE
CREATE TABLE DEPENDENTE (
    cpf NVARCHAR2(14) PRIMARY KEY,
    colaborador NVARCHAR2(20),
    nome NVARCHAR2(100),
    data_nascimento DATE,
    parentesco NVARCHAR2(100)
);

-- TB PAPEL
CREATE TABLE PAPEL (
    id NVARCHAR2(20) PRIMARY KEY,
    nome NVARCHAR2(100)
);

-- TB PROJETO
CREATE TABLE PROJETO (
    id NUMBER PRIMARY KEY,
    nome NVARCHAR2(100),
    responsavel NVARCHAR2(100),
    inicio DATE,
    fim DATE
);


-- TB ENDERECO_COLAB
CREATE TABLE ENDERECO_COLAB (
    id_endereco NVARCHAR2(20) PRIMARY KEY,
    cep NUMBER,
    logradouro NVARCHAR2(200),
    complemento NVARCHAR2(100),
    bairro NVARCHAR2(100),
    cidade NVARCHAR2(100),
    estado NVARCHAR2(100)
);

-- TB TELEFONES_COLAB
CREATE TABLE TELEFONES_COLAB (
    tel_celular NVARCHAR2(20) PRIMARY KEY,
    tel_residencial NVARCHAR2(20)
);

-- TB EMAIL_COLAB
CREATE TABLE EMAIL_COLAB (
    email_corporativo NVARCHAR2(100) PRIMARY KEY,
    email_pessoal NVARCHAR2(100)
);

