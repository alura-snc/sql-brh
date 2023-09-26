-- Tabela Departamento
CREATE TABLE Departamento (
    sigla VARCHAR2(5) PRIMARY KEY,
    nome VARCHAR2(260),
    chefe INTEGER, 
    departamento_superior VARCHAR(5), 
    FOREIGN KEY (chefe) REFERENCES Colaborador(matricula),
    FOREIGN KEY (departamento_superior) REFERENCES Departamento(sigla)
);

-- Tabela Colaborador
CREATE TABLE Colaborador (
    matricula INTEGER PRIMARY KEY,
    cpf VARCHAR2(11),
    nome VARCHAR2(260),
    salario DECIMAL(10, 2),
    departamento VARCHAR2(10),
    FOREIGN KEY (departamento) REFERENCES Departamento(sigla)
);

-- Tabela Contato
CREATE TABLE Contato (
    tipo VARCHAR2(20),
    telefone VARCHAR2(20),
    email VARCHAR2(260),
    matricula INTEGER,
    PRIMARY KEY (tipo, matricula),
    FOREIGN KEY (matricula) REFERENCES Colaborador(matricula)
);

-- Tabela Endereço
CREATE TABLE Endereco (
    tipo VARCHAR2(20),
    rua VARCHAR2(260),
    endereco VARCHAR2(260),
    numero VARCHAR2(10),
    complemento VARCHAR2(260),
    bairro VARCHAR2(260),
    cidade VARCHAR2(260),
    estado VARCHAR2(260),
    cep VARCHAR2(8),
    matricula INTEGER, 
    PRIMARY KEY (tipo, matricula),
    FOREIGN KEY (matricula) REFERENCES Colaborador(matricula)
);

-- Tabela Dependente
CREATE TABLE Dependente (
    cpf VARCHAR(11) PRIMARY KEY,
    colaborador INTEGER, 
    nome VARCHAR(260),
    data_nascimento DATE,
    parentesco VARCHAR2(50),
    FOREIGN KEY (colaborador) REFERENCES Colaborador(matricula)
);

-- Tabela Projeto
CREATE TABLE Projeto (
    id INTEGER PRIMARY KEY,
    nome VARCHAR2(260),
    responsavel INTEGER, 
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (responsavel) REFERENCES Colaborador(matricula)
);

-- Tabela Atribuição
CREATE TABLE Atribuicao (
    colaborador INTEGER, 
    projeto INTEGER, 
    papel INTEGER, 
    PRIMARY KEY (colaborador, projeto, papel),
    FOREIGN KEY (colaborador) REFERENCES Colaborador(matricula),
    FOREIGN KEY (projeto) REFERENCES Projeto(id),
    FOREIGN KEY (papel) REFERENCES Papel(id)
);

-- Tabela Papel
CREATE TABLE Papel (
    id INTEGER PRIMARY KEY,
    nome VARCHAR2(50)
);
