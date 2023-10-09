
CREATE TABLE BRH_DEPARTAMENTO 
(
    dep_sigla VARCHAR2(3) NOT NULL PRIMARY KEY,
    dep_nome VARCHAR2(150)NOT NULL,
    dep_chefe VARCHAR2(6),
    dep_superior VARCHAR2(3)            
);

CREATE TABLE BRH_COLABORADOR
(
    col_matricula VARCHAR2(6) NOT NULL PRIMARY KEY,
    col_cpf VARCHAR2(11) NOT NULL,
    col_nome VARCHAR2(60) NOT NULL,
    col_salario NUMBER(10,2) NOT NULL,
    col_departamento VARCHAR2(3) NOT NULL
);

ALTER TABLE BRH_DEPARTAMENTO
    ADD CONSTRAINT dep_chefe_fk 
        FOREIGN KEY (dep_chefe)
            REFERENCES BRH_COLABORADOR(col_matricula);

ALTER TABLE BRH_DEPARTAMENTO
    ADD CONSTRAINT dep_superior_fk 
        FOREIGN KEY (dep_superior)
            REFERENCES BRH_DEPARTAMENTO(dep_sigla);

ALTER TABLE BRH_COLABORADOR
    ADD CONSTRAINT col_departamento_fk
        FOREIGN KEY (col_departamento)
                REFERENCES BRH_DEPARTAMENTO (dep_sigla);

  
CREATE TABLE BRH_TELEFONE 
(
    tel_id INTEGER NOT NULL PRIMARY KEY,
    tel_id_colaborador VARCHAR2 (6) NOT NULL,
    tel_numero NUMBER (9) NOT NULL,
    tel_tipo VARCHAR2(1) DEFAULT 'R' NOT NULL,
    CONSTRAINT tel_id_colaborador_fk
        FOREIGN KEY (tel_id_colaborador)
            REFERENCES BRH_COLABORADOR (col_matricula),
    CONSTRAINT tel_tipo_ck
        CHECK (tel_tipo IN ('M','R','C')), -- M: MÓVEL, R: RESIDENCIAL, C: COMERCIAL
    CONSTRAINT tel_numero_uq
        UNIQUE (tel_numero)
);

CREATE TABLE BRH_ENDERECO_EMAIL
(
    end_e_id INTEGER NOT NULL PRIMARY KEY,
    end_e_id_colaborador VARCHAR2 (6) NOT NULL,
    end_e_email VARCHAR2 (60) NOT NULL,
    end_e_tipo VARCHAR2(1) DEFAULT 'P' NOT NULL,
    CONSTRAINT end_e_id_colaborador_fk
        FOREIGN KEY (end_e_id_colaborador)
            REFERENCES BRH_COLABORADOR (col_matricula),
    CONSTRAINT end_e_email_ck
        CHECK (end_e_email LIKE '%@__%.__%'),
    CONSTRAINT end_e_tipo_ck
        CHECK (end_e_tipo IN ('P','C')) -- P: PESSOAL, C: COMERCIAL
);

CREATE TABLE BRH_ENDERECO
(
    end_id INTEGER NOT NULL PRIMARY KEY,
    end_id_colaborador VARCHAR2 (6) NOT NULL,
    end_logradouro VARCHAR2 (150) NOT NULL,
    end_numero NUMBER(5) NOT NULL,
    end_complemento VARCHAR2(50),
    end_bairro VARCHAR2(50),
    end_cidade VARCHAR2(50) NOT NULL,
    end_estado VARCHAR2(2)NOT NULL,
    end_cep VARCHAR2(9)NOT NULL,
    CONSTRAINT end_id_colaborador_fk
        FOREIGN KEY (end_id_colaborador)
            REFERENCES BRH_COLABORADOR (col_matricula),
    CONSTRAINT end_estado_ck
        CHECK (end_estado IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
                              'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
                              'RS','RO','RR','SC','SP','SE','TO'
                              )) -- SIGLAS DOS ESTADOS
);

CREATE TABLE BRH_DEPENDENTE
(
    depen_cpf VARCHAR2(11) NOT NULL PRIMARY KEY,
    depen_id_colaborador VARCHAR2 (6) NOT NULL,
    depen_nome VARCHAR2(60) NOT NULL,
    depen_data_nascimento DATE NOT NULL,
    depen_parentesco VARCHAR2(10)NOT NULL,
    CONSTRAINT depen_id_colaborador_fk
        FOREIGN KEY (depen_id_colaborador)
            REFERENCES BRH_COLABORADOR (col_matricula),
    CONSTRAINT depen_parentesco_ck
        CHECK (depen_parentesco IN ('Cônjuge', 'Filho(a)', 'Pai', 'Mãe'))
);

CREATE TABLE BRH_PROJETO
(
    proj_id INTEGER NOT NULL PRIMARY KEY,
    proj_responsavel VARCHAR2 (6) NOT NULL,
    proj_nome VARCHAR2(25) NOT NULL,
    proj_data_inicio DATE NOT NULL,
    proj_data_termino DATE NOT NULL,
    CONSTRAINT proj_responsavel_fk
        FOREIGN KEY (proj_responsavel)
            REFERENCES BRH_COLABORADOR (col_matricula),
    CONSTRAINT proj_nome_uq
        UNIQUE (proj_nome)
);

CREATE TABLE BRH_PAPEL
(
    pap_id INTEGER NOT NULL PRIMARY KEY,
    pap_nome VARCHAR2(25) NOT NULL,
    CONSTRAINT pap_nome_uq
        UNIQUE (pap_nome)
);

CREATE TABLE BRH_ATRIBUICAO
(
    atr_colaborador VARCHAR2 (6) NOT NULL,
    atr_projeto INTEGER NOT NULL,
    atr_papel INTEGER NOT NULL,
    CONSTRAINT BRH_ATRIBUICAO_PK
        PRIMARY KEY (atr_colaborador, atr_projeto, atr_papel), 
    CONSTRAINT BRH_ATRIBUICAO_FK
        FOREIGN KEY (atr_colaborador)
            REFERENCES BRH_COLABORADOR (col_matricula),
        FOREIGN KEY (atr_projeto)
            REFERENCES BRH_PROJETO (proj_id),
        FOREIGN KEY (atr_papel)
            REFERENCES BRH_PAPEL (pap_id)
);