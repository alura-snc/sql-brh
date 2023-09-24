create table tb_departamento
(
	sigla varchar2(10) not null,
	nome varchar2(50) not null,
	chefe varchar2(10) not null,
	departamento_superior varchar2(6),
	constraint pk_departamento primary key (sigla),
	constraint fk_departamento_superior foreign key (departamento_superior) references tb_departamento (sigla)
);

create table tb_endereco
(
	cod_endereco varchar(10) not null,
    estado varchar2(20) not null,
	cidade varchar(30) not null,
	bairro varchar2(30) not null,
	logradouro varchar2(50) not null,
    complemento varchar2(30),
	constraint pk_endereco primary key (cod_endereco)
);

create table tb_colaborador
(
	matricula varchar2(10) not null,
	cpf char(14) not null,
	nome varchar2(50) not null,
	salario decimal(*,2) not null,
	departamento varchar2(10) not null,
	endereco varchar2(10) not null,
	constraint pk_colaborador primary key (matricula),
	constraint fk_departamento foreign key (departamento) references tb_departamento (sigla),
	constraint fk_endereco foreign key (endereco) references tb_endereco (cod_endereco)
);

alter table tb_departamento add constraint fk_chefe_departamento foreign key (chefe) references tb_colaborador (matricula);
    
create table tb_telefone
(
    numero varchar2(16) not null,
    tipo varchar2(11) not null,
    colaborador varchar2(10) not null,
    constraint pk_telefone primary key (colaborador, numero),
	constraint fk_telefone foreign key (colaborador)references tb_colaborador (matricula),
    constraint tipo_telefone_valido check (tipo in ('CELULAR', 'RESIDENCIAL', 'COMERCIAL'))
);

create table tb_email
(
	email varchar2(50) not null,
	tipo varchar2(11) not null,
    colaborador varchar2(10) not null,
	constraint pk_email primary key (colaborador, email),
	constraint fk_email	foreign key (colaborador) references tb_colaborador (matricula),
	constraint tipo_email_valido check (tipo in ('PESSOAL', 'CORPORATIVO'))
);

create table tb_dependente
(
    cpf varchar2 (14) not null,
    nome varchar2 (50) not null,
    data_nascimento date not null,
    parentesco varchar2 (20) not null,
    colaborador varchar2 (10) not null,
    constraint pk_dependente primary key (colaborador, cpf),
    constraint fk_dependente foreign key (colaborador) references tb_colaborador (matricula)
);

create table tb_projeto
(
    id varchar2 (10) not null,
    nome varchar2 (50) not null,
    inicio date not null,
    fim date not null,
    responsavel varchar2 (10) not null,
    constraint pk_projeto primary key (id)
);

create table tb_papel
(
    id varchar2(10) not null,
    nome varchar2 (50)not null,
    constraint pk_papel primary key (id)
);

create table tb_atribuicao
(
	colaborador varchar2(10) not null,
	projeto varchar2(50) not null,
	papel varchar2 (50) not null,
	constraint pk_atribuicao primary key (colaborador, projeto, papel),
    constraint fk_atribuicao_colaborador foreign key (colaborador) references tb_colaborador (matricula),
    constraint fk_atribuicao_projeto foreign key (projeto) references tb_projeto (id),
    constraint fk_atribuicao_papel foreign key (papel) references tb_papel(id)
);