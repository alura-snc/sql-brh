
---- TABELA ATRIBUIÇÃO
CREATE TABLE brh_atribuicao
(
colaborador VARCHAR2(20) not NULL,
projeto integer not NULL,
papel integer not null
)


---- TABELA COLABORADOR 
CREATE TABLE brh_colaborador
(
matricula VARCHAR2(20) not NULL,
cpf CHAR(14) not NULL,
nome VARCHAR2(200)not null,
salario decimal(10,2) not null,
departamento VARCHAR2(10) not null,
cep varchar2(10) not null,
logradouro varchar2(200) not null,
complemento varchar2(100) not null
)

---- TABELA DEPARTAMENTO
CREATE TABLE brh_departamento
(
sigla VARCHAR2(10) not NULL,
nome VARCHAR2(200)not null,
chefe varchar2(20) not null
)

---- TABELA DEPENDENTE
CREATE TABLE brh_dependente
(
cpf CHAR(14) not NULL,
colaborador VARCHAR2(20)not null,
nome VARCHAR2(200) not null,
data_nascimento DATE not NULL,
parentesco VARCHAR2(10) not null
)

---- TABELA PAPEL
CREATE TABLE brh_papel
(
id VARCHAR2(20) not NULL,
nome VARCHAR2(100) not null
)

----TABELA PROJETO
CREATE TABLE brh_projeto
(
id VARCHAR2(20) not NULL,
nome CHAR(14) not NULL,
responsavel VARCHAR2(20)not null,
inicio DATE not null,
fim DATE not null
)


----TABELA ENDEREÇO
CREATE TABLE brh_endereco
(
cep VARCHAR2(10) not NULL,
uf VARCHAR2(2)not null,
cidade varchar2(200) not null,
bairro varchar2 (100) not null
)


---- TABELA TELEFONE
CREATE TABLE brh_telefone
(
numero varchar2(20) not null,
colaborador varchar2(20) not null,
tipo char(1) default 'R' NOT NULL
)


---- TABELA EMAIL

CREATE TABLE brh_email
(
email varchar2(20) not null,
colaborador varchar2(20) not null
)

