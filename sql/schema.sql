CREATE TABLE TB_ATRIBUICAO
(COLABORADOR NUMBER(11),
    PROJETO VARCHAR2(50),
    PAPEL VARCHAR2(50)
    )

ALTER TABLE TB_ATRIBUICAO ADD CONSTRAINT PK_TB_ATRIBUICAO PRIMARY KEY (COLABORADOR);


CREATE TABLE TB_COLABORADOR
(
    COLABORADOR NUMBER(11),
    SIGLA_DEP VARCHAR2(100),
    CPF VARCHAR2(150),
    NOME VARCHAR2(150),
    SALARIO NUMBER(10,2)
)
ALTER TABLE TB_COLABORADOR ADD CONSTRAINT PK_TB_COLABORADOR PRIMARY KEY (COLABORADOR);


CREATE TABLE TB_DEPARTAMENTO
(
    SIGLA_DEP VARCHAR2(11),
    NOME_DEP VARCHAR2(100),
    CHEFE VARCHAR2(11),
    DEPARTAMENTO_SUPERIOR VARCHAR2(100)
)

ALTER TABLE TB_DEPARTAMENTO ADD CONSTRAINT PK_TB_DEPARTAMENTO PRIMARY KEY (SIGLA_DEP);

CREATE TABLE TB_DEPENDENTE
(
    CPF VARCHAR2(11),
    COLABORADOR VARCHAR2(100),
    NOME VARCHAR2(100),
    DATA_NASCIMENTO DATE,
    PARENTESCO VARCHAR2(30)
    )

CREATE TABLE TB_PAPEL
(
    ID_PAPEL VARCHAR2(11),
    NOME_PAPEL VARCHAR2(100))


CREATE TABLE TB_PROJETO
(
    ID_PROJETO VARCHAR2(11),
    NOME_PROJETO VARCHAR2(100),
    RESPONSAVEL VARCHAR2(11),
    INICIO DATE,
    FIM DATE
)

CREATE TABLE TB_CONTATO
(
    CPF VARCHAR2(11),
    NOME VARCHAR2(100),
    ENDERECO1 VARCHAR2(150),
    ENDERECO2 VARCHAR2(150),
    BAIRRO VARCHAR2(50),
    CIDADE VARCHAR2(50),
    ESTADO VARCHAR2(2),
    CEP VARCHAR2(8),
    DATA_NASCIMENTO DATE,
    IDADE INTEGER,
    SEXO VARCHAR2(1),
    LIMITE_CREDITO NUMBER(15,2),
    VOLUME_COMPRA NUMBER,
    PRIMEIRA_COMPRA NUMBER(1)
)

CREATE TABLE TB_ENDERECO
(
    CPF VARCHAR2(11),
    NOME VARCHAR2(100),
    ENDERECO1 VARCHAR2(150),
    ENDERECO2 VARCHAR2(150),
    BAIRRO VARCHAR2(50),
    CIDADE VARCHAR2(50),
    ESTADO VARCHAR2(2),
    CEP VARCHAR2(8),
    DATA_NASCIMENTO DATE,
    IDADE INTEGER,
    SEXO VARCHAR2(1),
    LIMITE_CREDITO NUMBER(15,2),
    VOLUME_COMPRA NUMBER,
    PRIMEIRA_COMPRA NUMBER(1)
)