/* modelo-lo?gico-desnormalizado: */

CREATE TABLE DEPARTAMENTO (
    sigla VARCHAR PRIMARY KEY,
    nome VARCHAR,
    chefe VARCHAR,
    departamento_superior VARCHAR
);

CREATE TABLE COLABORADOR (
    matricula INTEGER,
    cpf INTEGER,
    nome VARCHAR,
    telefone1 VARCHAR,
    telefone2 VARCHAR,
    email_pessoal VARCHAR,
    email_corporativo VARCHAR,
    salario DECIMAL,
    estado VARCHAR,
    cidade VARCHAR,
    bairro VARCHAR,
    logradouro VARCHAR,
    complemento VARCHAR,
    cep VARCHAR,
    sigla_dep_departamento VARCHAR,
    PRIMARY KEY (matricula, sigla_dep_departamento)
);

CREATE TABLE DEPENDENTE (
    cpf INTEGER PRIMARY KEY,
    matricula_colab_colaborador INTEGER,
    nome VARCHAR,
    data_nascimento DATE,
    parentesco VARCHAR
);

CREATE TABLE PROJETO (
    id INTEGER PRIMARY KEY,
    nome VARCHAR,
    matricula_colab_responsavel INTEGER,
    inicio DATE,
    fim DATE
);

CREATE TABLE ATRIBUICAO (
    matricula_colab_colaborador INTEGER,
    id_proj_projeto INTEGER,
    id_pap_papel INTEGER,
    PRIMARY KEY (id_proj_projeto, matricula_colab_colaborador, id_pap_papel)
);

CREATE TABLE PAPEL (
    id INTEGER PRIMARY KEY,
    nome VARCHAR
);
 
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT FK_DEPARTAMENTO_2
    FOREIGN KEY (departamento_superior)
    REFERENCES DEPARTAMENTO (sigla);
 
ALTER TABLE COLABORADOR ADD CONSTRAINT FK_COLABORADOR_2
    FOREIGN KEY (sigla_dep_departamento)
    REFERENCES DEPARTAMENTO (sigla);
 
ALTER TABLE DEPENDENTE ADD CONSTRAINT FK_DEPENDENTE_2
    FOREIGN KEY (matricula_colab_colaborador, Campo???)
    REFERENCES COLABORADOR (matricula, ???);
 
ALTER TABLE PROJETO ADD CONSTRAINT FK_PROJETO_1
    FOREIGN KEY (matricula_colab_responsavel, ???)
    REFERENCES COLABORADOR (matricula, ???);
 
ALTER TABLE ATRIBUICAO ADD CONSTRAINT FK_ATRIBUICAO_2
    FOREIGN KEY (matricula_colab_colaborador, ???)
    REFERENCES COLABORADOR (matricula, ???);
 
ALTER TABLE ATRIBUICAO ADD CONSTRAINT FK_ATRIBUICAO_3
    FOREIGN KEY (id_proj_projeto)
    REFERENCES PROJETO (id);
 
ALTER TABLE ATRIBUICAO ADD CONSTRAINT FK_ATRIBUICAO_4
    FOREIGN KEY (id_pap_papel)
    REFERENCES PAPEL (id);