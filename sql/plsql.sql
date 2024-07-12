
--Tarefa
--Crie o arquivo sql/plsql.sql;
--Crie a procedure brh.insere_projeto para cadastrar um novo projeto na base de dados:
--Parâmetros da procedure:
--Nome do projeto: varchar com nome do novo projeto.
--Responsável do projeto: varchar com a matrícula do colaborador responsável.
--Faça commit do arquivo.
--Regras de aceitação

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(
    p_NOME IN brh.projeto.nome%type,
    p_RESPONSAVEL IN brh.projeto.responsavel%type   
)

IS

BEGIN
    INSERT INTO brh.projeto (NOME, RESPONSAVEL, INICIO) VALUES (p_NOME, UPPER(p_RESPONSAVEL), SYSDATE);
    
    COMMIT; --NECESSARIO NO PL SQL

END;

--Tarefa
--Crie a function brh.calcula_idade, que informa a idade a partir de uma data:
--Parâmetros da function:
--Data: date com a data de referência para calcular a idade.
--Retorno da function:
--Deve retornar um número inteiro com a idade.
--Adicione o código no arquivo sql/plsql.sql;
--Faça commit do arquivo.

CREATE OR REPLACE FUNCTION brh.calcula_idade
(p_DATA IN VARCHAR2)
RETURN INTEGER
IS 
v_IDADE INTEGER;
BEGIN
    v_IDADE := TRUNC(MONTHS_BETWEEN(SYSDATE, to_date(p_data,'dd/mm/yyyy')) / 12);
    RETURN v_IDADE;
END;

VARIABLE g_IDADE INTEGER;
EXECUTE :g_IDADE:=brh.calcula_idade('01/02/1987');
print g_IDADE;



--Tarefa
--Crie a function brh.finaliza_projeto para registrar o término da execução de um projeto:
--Parâmetros da function:
--ID do projeto: number com identificador do projeto a ser finalizado.
--Retorno da function:
--Deve retornar a data de finalização atribuída ao projeto.
--Adicione o código no arquivo sql/plsql.sql;
--Faça commit do arquivo.

SELECT * FROM brh.projeto;

CREATE OR REPLACE FUNCTION brh.finaliza_projeto
(p_ID IN brh.projeto.ID%type)
RETURN DATE
IS 
v_DATA_FINAL DATE;
BEGIN
    v_DATA_FINAL := SYSDATE;
    UPDATE brh.projeto SET FIM = v_DATA_FINAL WHERE ID = p_ID;
    RETURN v_DATA_FINAL;
END;




--Tarefa
--Altere a procedure brh.insere_projeto para não permitir cadastrar projetos inválidos;
--Adicione o código no arquivo sql/plsql.sql;
--Faça commit do arquivo.
--Critérios de aceitação
--O nome do novo do projeto deve ter duas ou mais letras:
--Se tiver menos caracteres, ou for null, lance uma exceção com a mensagem "Nome de projeto inválido! Deve ter dois ou mais caracteres.".

SELECT * FROM brh.projeto;

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(
    p_NOME IN brh.projeto.nome%type,
    p_RESPONSAVEL IN brh.projeto.responsavel%type   
)

IS

BEGIN
    IF LENGTH(p_NOME) < 2 OR p_NOME = NULL THEN
        RAISE_APPLICATION_ERROR(-20001, '"Nome de projeto inválido! Deve ter dois ou mais caracteres.".');
    END IF;
    
    INSERT INTO brh.projeto (NOME, RESPONSAVEL, INICIO) VALUES (p_NOME, UPPER(p_RESPONSAVEL), SYSDATE);
    
    COMMIT; --NECESSARIO NO PL SQL

END;

EXECUTE brh.insere_projeto('S', 'G123');
