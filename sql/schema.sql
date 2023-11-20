CREATE TABLE colaborador (
    matricula INTEGER NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    salario FLOAT NOT NULL,
    id_departamento INTEGER NOT NULL,
    PRIMARY KEY (matricula)
);

CREATE TABLE telefone (
id_telefone INTEGER NOT NULL,
numero VARCHAR(14) NOT NULL,
tipo_telefone VARCHAR(1) NOT NULL,
matricula_colaborador INTEGER NOT NULL,
PRIMARY KEY (id_telefone),
FOREIGN KEY(matricula_colaborador) REFERENCES colaborador(matricula)
);

CREATE TABLE email (
    id_email INTEGER NOT NULL,
    matricula_colaborador INTEGER NOT NULL, 
    nome_email VARCHAR(50) NOT NULL,
    tipo_email VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_email),
    FOREIGN KEY (matricula_colaborador) REFERENCES colaborador(matricula)
);

CREATE TABLE endereco (
    cep VARCHAR(9) NOT NULL,
    matricula_colaborador INTEGER NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    complemento VARCHAR(20) NOT NULL,
    PRIMARY KEY (cep),
    FOREIGN KEY (matricula_colaborador) REFERENCES colaborador (matricula)
);



CREATE TABLE papel (
    id_papel INTEGER NOT NULL, 
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_papel)
);

CREATE TABLE projeto (
    id_projeto INTEGER NOT NULL,
    responsavel INTEGER NOT NULL, 
    nome VARCHAR(50) NOT NULL,
    data_inicio DATE,
    data_final DATE,
    PRIMARY KEY (id_projeto),
    FOREIGN KEY (responsavel) REFERENCES colaborador(matricula)
);

CREATE TABLE atribuicao (
    matricula_colaborador INTEGER NOT NULL, 
    id_projeto INTEGER NOT NULL,
    id_papel INTEGER NOT NULL,
    FOREIGN KEY (matricula_colaborador) REFERENCES colaborador(matricula),
    FOREIGN KEY (id_projeto) REFERENCES projeto (id_projeto),
    FOREIGN KEY (id_papel) REFERENCES papel (id_papel)
);

CREATE TABLE departamento (
    id_departamento INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    chefe INTEGER NOT NULL,
    departamento_superior INTEGER,
    PRIMARY KEY (id_departamento),
    FOREIGN KEY (chefe) REFERENCES colaborador (matricula),
    FOREIGN KEY (departamento_superior) REFERENCES departamento (id_departamento)    
);


CREATE TABLE dependente (
    id_dependente INTEGER NOT NULL,
    matricula_colaborador INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL,
    data_nascimento DATE,
    parentesco VARCHAR(30),
    PRIMARY KEY (id_dependente),
    FOREIGN KEY (matricula_colaborador) REFERENCES colaborador (matricula)
);
