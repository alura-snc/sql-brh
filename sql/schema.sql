create table brh.papel (
	id integer NOT NULL,
	nome varchar2(255) not null,
	constraint pk_papel primary key (id),
	constraint papel_unico unique (nome)
);

create table brh.departamento (
	sigla varchar2(6) not null,
	nome varchar2(255) not null,
	chefe varchar2(10) not null,
	departamento_superior varchar2(6),
	constraint pk_departamento primary key (sigla),
	constraint fk_departamento_superior
		foreign key (departamento_superior)
		references departamento (sigla)
);

create table brh.endereco (
	cep varchar2(10) not null,
	uf char(2) not null,
	cidade varchar2(255) not null,
	bairro varchar2(255) not null,
	constraint pk_endereco primary key (cep)
);

create table brh.colaborador (
	matricula varchar2(10) not null,
	cpf char(14) not null,
	nome varchar2(255) not null,
	salario decimal(10,2) not null,
	departamento varchar2(6) NOT NULL,
	cep varchar2(10) not null,
	logradouro varchar2(255) not null,
	complemento_endereco varchar(255),
	constraint pk_colaborador primary key (matricula),
	constraint fk_departamento_colaborador
		foreign key (departamento)
		references brh.departamento (sigla),
	constraint fk_endereco_colaborador 
		foreign key (cep)
		references brh.endereco (cep)
);

create table brh.telefone_colaborador(
	numero varchar2(20) not null,
	colaborador varchar2(10) not null,
	tipo char(1) default 'R' NOT null,
	constraint pk_telefone primary key (colaborador, numero),
	constraint fk_telefone_colaborador
		foreign key (colaborador)
		references brh.colaborador (matricula),
	constraint tipo_telefone_valido check (tipo in ('M', 'R', 'C')) -- M: M�VEL, R: RESIDENCIAL, C: COMERCIAL
);

create table brh.email_colaborador(
	email varchar2(255) not null,
	colaborador varchar2(10) not null,
	tipo char(1) default 'R' NOT null,
	constraint pk_email primary key (colaborador, email),
	constraint fk_email_colaborador
		foreign key (colaborador)
		references brh.colaborador (matricula),
	constraint tipo_email_valido check (tipo in ('P', 'T')) -- P: PESSOAL, T: TRABALHO
);

create table brh.dependente(
	cpf char(14) not null,
	nome varchar2(255) not null,
	data_nascimento date not null,
	parentesco varchar2(20) not null,
	colaborador varchar2(10) not null,
	constraint pk_dependente primary key (cpf),
	constraint fk_dependente_colaborador
		foreign key (colaborador)
		references brh.colaborador (matricula),
	constraint parentesco_valido check (parentesco in ('C�njuge', 'Filho(a)', 'Pai', 'M�e'))
);

create table brh.projeto (
	id integer NOT NULL,
	nome varchar2(255) not null,
	responsavel varchar2(10),
	inicio date not null,
	fim date,
	constraint pk_projeto primary key (id),
	constraint fk_colaborador_projeto
		foreign key (responsavel)
		references brh.colaborador (matricula),
	constraint projeto_unico unique (nome)
);

create table brh.atribuicao (
	colaborador varchar2(10) not null,
	projeto integer not null,
	papel integer not null,
	constraint pk_atribuicao primary key (colaborador, projeto, papel)
);

alter table brh.departamento 
	add constraint fk_chefe_departamento
	foreign key (chefe) 
	references brh.colaborador (matricula);
	

