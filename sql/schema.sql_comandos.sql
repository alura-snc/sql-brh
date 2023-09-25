
brh_Departamento 

CREATE TABLE BRH_DEPARTAMENTO (
    ID_DEPARTAMENTO INT PRIMARY KEY,
    ID_COLABORADOR INT,
    NOME_DEPARTAMENTO VARCHAR(255),
    SUPERIOR_DP INT,
    FOREIGN KEY (SUPERIOR_DP) REFERENCES BRH_DEPARTAMENTO(ID_DEPARTAMENTO)
);

CREATE TABLE BRH_COLABORADOR (
    ID_MATRICULA_COLABORADOR INT NOT NULL,
    CPF CHAR(11),
    ID_DEPARTAMENTO INT,
    NOME VARCHAR(255),
    SALARIO DECIMAL(10, 2),
    ESTADO VARCHAR(255),
    CIDADE VARCHAR(255),
    BAIRRO VARCHAR(255),
    LOGRADOURO VARCHAR(255),
    CEP CHAR(8),
    COMPLEMENTO VARCHAR(255),
    PRIMARY KEY (ID_MATRICULA_COLABORADOR)
);

BRH_PROJETO
CREATE TABLE BRH_PROJETO (
    ID_PROJETO INT PRIMARY KEY,
    ID_MATRICULA_COLABORADOR INT
);

BRH_DEPENDENTE
CREATE TABLE BRH_DEPENDENTE (
    ID_DEPENDENTE INT PRIMARY KEY,
    ID_MATRICULA_COLABORADOR INT,
    NOME VARCHAR(255),
    DATA_NASCIMENTO DATE,
    PARENTESCO VARCHAR(255),
    CPF_DEPENDENTE CHAR(11)
);

BRH_CONTATO
CREATE TABLE BRH_CONTATO (
    ID_CONTATO INT PRIMARY KEY,
    ID_MATRICULA_COLABORADOR INT,
    NOME VARCHAR(255),
    EMAIL VARCHAR(255),
    TELEFONE VARCHAR(20)
);

BRH_ATRIBUICAO
CREATE TABLE BRH_ATRIBUICAO (
    ID_ATRIBUICAO_PROJETO INT PRIMARY KEY,
    ID_PROJETO INT,
    ID_PAPEL INT
);

BRH_INFORMACAO_PROJETO
CREATE TABLE BRH_INFORMACAO_PROJETO (
    ID_PROJETO INT,
    NOME_PROJETO VARCHAR(255),
    INICIO DATE,
    FIM DATE,
    FOREIGN KEY (ID_PROJETO) REFERENCES BRH_PROJETO(ID_PROJETO)
);


BRH_PAPEL
CREATE TABLE BRH_PAPEL (
    ID_PAPEL_DEFINIDO INT PRIMARY KEY,
    ID_ATRIBUICAO_PROJETO INT,
    FOREIGN KEY (ID_ATRIBUICAO_PROJETO) REFERENCES BRH_ATRIBUICAO(ID_ATRIBUICAO_PROJETO)
);

OBS.:

ALGUMAS CHAVES ESTRANGEIRAS FORAM ACESCENTADAS VIA ASSISTENTE DE CRIAÇÃO DE YTABELA DO OCRACLE
