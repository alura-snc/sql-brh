/* RK_Lógico_RH_V_1_0: */

CREATE TABLE tb_colaborador (
    id_matricula decimal NOT NULL PRIMARY KEY UNIQUE,
    nm_colaborador varchar2(60) NOT NULL,
    email varchar2(30),
    salario DECIMAL NOT NULL
);

CREATE TABLE tb_departamentos (
    id_dept integer NOT NULL PRIMARY KEY UNIQUE,
    ds_sigla varchar2(10) NOT NULL
);

CREATE TABLE tb_projetos (
    id_projeto integer NOT NULL PRIMARY KEY UNIQUE,
    ds_projeto varchar2(60) NOT NULL,
    dt_inicio date NOT NULL,
    dt_fim date
);

CREATE TABLE tb_papeis_projetos (
    id_papel integer NOT NULL PRIMARY KEY UNIQUE,
    ds_papel varchar2(60) NOT NULL
);

CREATE TABLE tb_papeis_colaborador (
    fk_Colaborador_id_matricula decimal NOT NULL,
    fk_Projetos_id_projeto integer NOT NULL,
    fk_Papel_id_papel integer NOT NULL,
    PRIMARY KEY (fk_Projetos_id_projeto, fk_Colaborador_id_matricula, fk_Papel_id_papel)
);

CREATE TABLE tb_fones (
    id_fone integer NOT NULL UNIQUE,
    fk_Colaborador_id_matricula decimal NOT NULL,
    nr_pais varchar2(4),
    nr_ddd varchar2(3) NOT NULL,
    nr_fone varchar2(11) NOT NULL
);
 
ALTER TABLE tb_fones ADD CONSTRAINT pk_tb_fones PRIMARY KEY (id_fone);

CREATE TABLE tb_dependentes (
    id_dependente integer NOT NULL PRIMARY KEY UNIQUE,
    fk_Colaborador_id_matricula decimal NOT NULL,
    nm_dependente varchar2(30) NOT NULL,
    fk_Parentesco_id_parentesco integer NOT NULL
);

CREATE TABLE tb_endereco (
    id_endereco integer NOT NULL PRIMARY KEY UNIQUE,
    fk_Colaborador_id_matricula decimal NOT NULL,
    ds_endereco varchar(60) NOT NULL,
    ds_bairro varchar2(60) NOT NULL,
    sg_estado varchar2(2) NOT NULL,
    cd_cep varchar2(10) NOT NULL
);

CREATE TABLE tb_alocacao (
    fk_Departamento_id_dept integer NOT NULL,
    fk_Colaborador_id_matricula decimal NOT NULL,
    PRIMARY KEY (fk_Departamento_id_dept, fk_Colaborador_id_matricula)
);

CREATE TABLE tb_chefia (
    fk_Colaborador_id_matricula decimal NOT NULL,
    fk_Departamento_id_dept integer NOT NULL,
    PRIMARY KEY (fk_Colaborador_id_matricula, fk_Departamento_id_dept)
);

CREATE TABLE tb_lider_projeto (
    fk_Colaborador_id_matricula decimal NOT NULL,
    fk_Projetos_id_projeto integer NOT NULL
);
 
ALTER TABLE tb_lider_projeto ADD CONSTRAINT pk_tb_lider_projeto PRIMARY KEY (fk_Colaborador_id_matricula, fk_Projetos_id_projeto);

CREATE TABLE tb_parentesco (
    id_parentesco integer NOT NULL PRIMARY KEY UNIQUE,
    ds_parentesco varchar2(30) NOT NULL
);
 
ALTER TABLE tb_papeis_colaborador ADD CONSTRAINT FK_tb_papeis_colaborador_2
    FOREIGN KEY (fk_Papel_id_papel)
    REFERENCES tb_papeis_projetos (id_papel);
 
ALTER TABLE tb_papeis_colaborador ADD CONSTRAINT FK_tb_papeis_colaborador_3
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula);
 
ALTER TABLE tb_papeis_colaborador ADD CONSTRAINT FK_tb_papeis_colaborador_4
    FOREIGN KEY (fk_Projetos_id_projeto)
    REFERENCES tb_projetos (id_projeto);
 
ALTER TABLE tb_fones ADD CONSTRAINT FK_tb_fones_2
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula);
 
ALTER TABLE tb_dependentes ADD CONSTRAINT FK_tb_dependentes_2
    FOREIGN KEY (fk_Parentesco_id_parentesco)
    REFERENCES tb_parentesco (id_parentesco);
 
ALTER TABLE tb_dependentes ADD CONSTRAINT FK_tb_dependentes_3
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula);
 
ALTER TABLE tb_endereco ADD CONSTRAINT FK_tb_endereco_2
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula);
 
ALTER TABLE tb_alocacao ADD CONSTRAINT FK_tb_alocacao_1
    FOREIGN KEY (fk_Departamento_id_dept)
    REFERENCES tb_departamentos (id_dept)
    ON DELETE RESTRICT;
 
ALTER TABLE tb_alocacao ADD CONSTRAINT FK_tb_alocacao_2
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula)
    ON DELETE RESTRICT;
 
ALTER TABLE tb_chefia ADD CONSTRAINT FK_tb_chefia_1
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula)
    ON DELETE RESTRICT;
 
ALTER TABLE tb_chefia ADD CONSTRAINT FK_tb_chefia_2
    FOREIGN KEY (fk_Departamento_id_dept)
    REFERENCES tb_departamentos (id_dept)
    ON DELETE SET NULL;
 
ALTER TABLE tb_lider_projeto ADD CONSTRAINT FK_tb_lider_projeto_1
    FOREIGN KEY (fk_Colaborador_id_matricula)
    REFERENCES tb_colaborador (id_matricula)
    ON DELETE RESTRICT;
 
ALTER TABLE tb_lider_projeto ADD CONSTRAINT FK_tb_lider_projeto_2
    FOREIGN KEY (fk_Projetos_id_projeto)
    REFERENCES tb_projetos (id_projeto)
    ON DELETE SET NULL;