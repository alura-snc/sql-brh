
show user;
grant alter user to brh;
ALTER USER BRH QUOTA UNLIMITED ON USERS;
GRANT connect, resource TO brh;
alter user brh account lock;

SELECT * FROM BRH.PROJETO;

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME BRH.PROJETO.NOME%type
,p_RESPONSAVEL BRH.PROJETO.RESPONSAVEL%type)
IS
BEGIN
    INSERT INTO BRH.PROJETO(NOME,RESPONSAVEL,INICIO)
    VALUES(p_NOME, p_RESPONSAVEL,sysdate);
    COMMIT;
END;
EXECUTE brh.insere_projeto('NOV2', 'T123');



CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    SELECT TRUNC(months_between(sysdate, p_data_nascimento) / 12)
    INTO v_idade
    FROM DUAL;

    RETURN v_idade;
END;

SELECT brh.calcula_idade(TO_DATE('10-12-1970', 'DD-MM-YYYY')) AS IDADE FROM DUAL;




