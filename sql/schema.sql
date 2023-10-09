-- Departamento
create table Departamento (
idDepartamento integer,
idColaboradorChefe integer,
sigla char(3),
nome varchar2(15)
);
alter table Departamento add constraint pk_Departamento
primary key (idDepartamento);

--Colaborador
create table Colaborador (
idColaborador integer,
idDepartamento integer,
matricula char(6),
cpf char(11),
nome varchar2(50),
salario numeric(10,2)
);
alter table Colaborador add constraint pk_Colaborador
primary key (idColaborador);

--Departamento Colaborador FKs
alter table Departamento add constraint fk_Departamento_Colaborador
foreign key (idColaboradorChefe)
references Colaborador (idColaborador);

alter table Colaborador add constraint fk_Colaborador_Departamento
foreign key (idDepartamento)
references Departamento(idDepartamento);

--ContatoEmail
create table ContatoEmail(
idContatoEmail integer,
idColaborador integer,
tipoEmail varchar2(15),
email varchar2(30)
);
alter table ContatoEmail add constraint pk_ContatoEmail
primary key (idContatoEmail);
alter table ContatoEmail add constraint fk_ContatoEmail_Colaborador
foreign key (idColaborador)
references Colaborador (idColaborador);

--ContatoTelefonico
create table ContatoTelefonico(
idContatoTelefonico integer,
idColaborador integer,
tipoTelefone varchar2(15),
numero varchar2(11)
);
alter table ContatoTelefonico add constraint pk_ContatoTelefonico
primary key (idContatoTelefonico);
alter table ContatoTelefonico add constraint fk_ContatoTelefonico_Colaborador
foreign key (idColaborador)
references Colaborador (idColaborador);

--Dependente
create table Dependente(
idDependente integer,
idColaborador integer,
cpf char(11),
nome varchar2(50),
dataNascimento Date,
parentesco varchar2(15)
);
alter table Dependente add constraint pk_Dependente 
primary key (idDependente );
alter table Dependente  add constraint fk_Dependente_Colaborador
foreign key (idColaborador)
references Colaborador (idColaborador);

--Endereco
create table Endereco(
idEndereco integer,
idColaborador integer,
tipoEmail varchar2(15),
cep char(8),
tipoLogradouro varchar2(10),
logradouro varchar2(30),
numero varchar2(6),
complemento varchar2(10),
bairro varchar2(15),
cidade varchar2(30),
estado char(2)
);
alter table Endereco add constraint pk_Endereco
primary key (idEndereco);
alter table Endereco add constraint fk_Endereco_Colaborador
foreign key (idColaborador)
references Colaborador (idColaborador);

--Projeto 
create table Projeto (
idProjeto integer,
idColaboradorResponsavel integer,
nome varchar2(30),
inicio date,
fim date,
status char(1)
);
alter table Projeto add constraint pk_Projeto
primary key (idProjeto);
alter table Projeto add constraint fk_Projeto_Colaborador
foreign key (idColaboradorResponsavel)
references Colaborador (idColaborador);

--Papel
create table Papel (
idPapel integer,
nome varchar2(30)
);
alter table Papel add constraint pk_Papel
primary key (idPapel);

--Atribuicao
create table Atribuicao (
idAtribuicao integer,
idColaborador integer,
idProjeto integer,
idPapel integer
);
alter table Atribuicao add constraint pk_Atribuicao
primary key (idAtribuicao);
alter table Atribuicao add constraint fk_Atribuicao_Colaborador
foreign key (idColaborador)
references Colaborador (idColaborador);
alter table Atribuicao add constraint fk_Atribuicao_Papel
foreign key (idPapel)
references Papel (idPapel);
alter table Atribuicao add constraint fk_Atribuicao_Projeto
foreign key (idProjeto)
references Projeto(idProjeto);




