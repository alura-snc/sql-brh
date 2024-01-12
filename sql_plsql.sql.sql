--Crie a procedure brh.insere_projeto para cadastrar um novo projeto na base de dados:
--Par�metros da procedure:
--Nome do projeto: varchar com nome do novo projeto.
--Respos�vel do projeto: varchar com a matr�cula do colaborador respons�vel.

--Regras de aceita��o
--Deve inserir um novo registro na tabela brh.projeto;
--N�o deve fazer commit em seu c�digo. A efetiva��o da transa��o deve ser feita por quem invoca a procedure.

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(NOME IN VARCHAR2, RESPONSAVEL IN VARCHAR2)
IS
BEGIN
    INSERT INTO  brh.projeto (NOME, RESPONSAVEL) VALUES (NOME, (RESPONSAVEL));
    COMMIT;
END;

--Crie a function brh.calcula_idade, que informa a idade a partir de uma data:
--Par�metros da function:
--Data: date com a data de refer�ncia para calcular a idade.
--Retorno da function:
--Deve retornar um n�mero inteiro com a idade

CREATE OR REPLACE FUNCTION  brh.calcula_idade(in_codigo IN DATE) 
   RETURN NUMBER 
   IS 
        v_idade NUMBER(11);
   BEGIN 
        
        SELECT trunc((months_between(sysdate, to_date(DATA_NASCIMENTO,'dd/mm/yyyy')))/12) 
        INTO v_idade
        FROM DEPENDENTE D
        WHERE D.DATA_NASCIMENTO = in_codigo;
        RETURN(v_idade); 
 
    END;

--Crie a function brh.finaliza_projeto para registrar o t�rmino da execu��o de um projeto:
--Par�metros da function:
--ID do projeto: number com identificador do projeto a ser finalizado.
--Retorno da function:
--Deve retornar a data de finaliza��o atribu�da ao projeto.

CREATE OR REPLACE FUNCTION  brh.finaliza_projeto (ID_do_projeto IN date) 
   RETURN NUMBER
   IS 
        v_PROJETO_INICIO NUMBER(11);
   BEGIN 
        
        SELECT trunc((months_between(sysdate, to_date(FIM,'dd/mm/yyyy')))/12) 
        INTO v_PROJETO_INICIO
        FROM PROJETO P
        WHERE P.FIM = ID_do_projeto;
        RETURN(v_PROJETO_INICIO); 
 
    END;
    
    
    
--  Altere a procedure brh.insere_projeto para n�o permitir cadastrar projetos inv�lidos;
--Crit�rios de aceita��o
-- O nome do novo do projeto deve ter duas ou mais letras:
--Se tiver menos caracteres, ou for null, lance uma exce��o com a mensagem 
--"Nome de projeto inv�lido! Deve ter dois ou mais caracteres.".



SELECT*FROM BRH.PROJETO;

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME BRH.PROJETO.NOME%type
,p_RESPONSAVEL BRH.PROJETO.RESPONSAVEL%type)
IS
BEGIN

    IF LENGTH(p_NOME) <= 2 THEN

        DBMS_OUTPUT.PUT_LINE('Nome de projeto inv�lido! Deve ter dois ou mais caracteres');
    ELSE

        INSERT INTO BRH.PROJETO(NOME, RESPONSAVEL, INICIO)
        VALUES (p_NOME, p_RESPONSAVEL, SYSDATE);
        COMMIT;
        
    END IF;

END;




COMMIT;