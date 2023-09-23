--------------------------------------------------------
--  Arquivo criado - sábado-setembro-23-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TB_ATRIBUICAO
--------------------------------------------------------

  CREATE TABLE "TB_ATRIBUICAO" 
   (	"COLABORADOR" VARCHAR2(50), 
	"PROJETO" VARCHAR2(40), 
	"PAPEL" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_COLABORADOR
--------------------------------------------------------

  CREATE TABLE "TB_COLABORADOR" 
   (	"MATRICULA" VARCHAR2(5), 
	"CPF" VARCHAR2(11), 
	"NOME" VARCHAR2(50), 
	"SALARIO" FLOAT(126), 
	"RUA" VARCHAR2(90), 
	"NUMERO" VARCHAR2(10), 
	"COMPLEMENTO" VARCHAR2(50), 
	"BAIRRO" VARCHAR2(50), 
	"CEP" VARCHAR2(12), 
	"DEPARTAMENTO" VARCHAR2(50), 
	"CIDADE" VARCHAR2(40), 
	"ESTADO" VARCHAR2(2)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_DEPARTAMENTO
--------------------------------------------------------

  CREATE TABLE "TB_DEPARTAMENTO" 
   (	"SIGLA" VARCHAR2(5), 
	"NOME" VARCHAR2(5), 
	"CHEFE" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_DEPARTAMENTO_SUP
--------------------------------------------------------

  CREATE TABLE "TB_DEPARTAMENTO_SUP" 
   (	"SIGLA" VARCHAR2(5), 
	"NOME" VARCHAR2(5)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_DEPENDENTE
--------------------------------------------------------

  CREATE TABLE "TB_DEPENDENTE" 
   (	"CPF" VARCHAR2(11), 
	"COLABORADOR" VARCHAR2(50), 
	"NOME" VARCHAR2(50), 
	"DATA_NASCIMENTO" DATE, 
	"PARENTESCO" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_EMAIL_COLABORADOR
--------------------------------------------------------

  CREATE TABLE "TB_EMAIL_COLABORADOR" 
   (	"EMAIL_PESSOAL" VARCHAR2(80), 
	"EMAIL_CORPORATIVO" VARCHAR2(80), 
	"EMAIL_ALTERNATIVO" VARCHAR2(80)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_PAPEL
--------------------------------------------------------

  CREATE TABLE "TB_PAPEL" 
   (	"ID" VARCHAR2(5), 
	"NOME" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table TB_PROJETO
--------------------------------------------------------

  CREATE TABLE "TB_PROJETO" 
   (	"ID" VARCHAR2(5), 
	"NOME" VARCHAR2(50), 
	"REPONSÁVEL" VARCHAR2(60), 
	"INICIO" DATE, 
	"FIM" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TB_TELEFONE_COLABORADOR
--------------------------------------------------------

  CREATE TABLE "TB_TELEFONE_COLABORADOR" 
   (	"TEL_RESIDENCIAL" VARCHAR2(20), 
	"TEL_COMERCIAL" VARCHAR2(20), 
	"TEL_CELULAT" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for Index PK_TB_COLABORADOR
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_COLABORADOR" ON "TB_COLABORADOR" ("MATRICULA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TB_DEPARTAMENTO
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_DEPARTAMENTO" ON "TB_DEPARTAMENTO" ("SIGLA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TB_DEPARTAMENTO_SUP
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_DEPARTAMENTO_SUP" ON "TB_DEPARTAMENTO_SUP" ("SIGLA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TB_DEPENDENTE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_DEPENDENTE" ON "TB_DEPENDENTE" ("CPF") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TB_PAPEL
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_PAPEL" ON "TB_PAPEL" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TB_PROJETO
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TB_PROJETO" ON "TB_PROJETO" ("ID") 
  ;
--------------------------------------------------------
--  Constraints for Table TB_ATRIBUICAO
--------------------------------------------------------

  ALTER TABLE "TB_ATRIBUICAO" MODIFY ("COLABORADOR" NOT NULL ENABLE);
  ALTER TABLE "TB_ATRIBUICAO" MODIFY ("PROJETO" NOT NULL ENABLE);
  ALTER TABLE "TB_ATRIBUICAO" MODIFY ("PAPEL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TB_COLABORADOR
--------------------------------------------------------

  ALTER TABLE "TB_COLABORADOR" ADD CONSTRAINT "PK_TB_COLABORADOR" PRIMARY KEY ("MATRICULA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table TB_DEPARTAMENTO
--------------------------------------------------------

  ALTER TABLE "TB_DEPARTAMENTO" ADD CONSTRAINT "PK_TB_DEPARTAMENTO" PRIMARY KEY ("SIGLA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table TB_DEPARTAMENTO_SUP
--------------------------------------------------------

  ALTER TABLE "TB_DEPARTAMENTO_SUP" ADD CONSTRAINT "PK_TB_DEPARTAMENTO_SUP" PRIMARY KEY ("SIGLA")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table TB_DEPENDENTE
--------------------------------------------------------

  ALTER TABLE "TB_DEPENDENTE" ADD CONSTRAINT "PK_TB_DEPENDENTE" PRIMARY KEY ("CPF")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table TB_PAPEL
--------------------------------------------------------

  ALTER TABLE "TB_PAPEL" ADD CONSTRAINT "PK_TB_PAPEL" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table TB_PROJETO
--------------------------------------------------------

  ALTER TABLE "TB_PROJETO" ADD CONSTRAINT "PK_TB_PROJETO" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
