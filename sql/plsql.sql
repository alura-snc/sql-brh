
show user;
grant alter user to brh;
ALTER USER BRH QUOTA UNLIMITED ON USERS;
GRANT connect, resource TO brh;
alter user brh account lock;

SELECT * FROM BRH.PROJETO;
-- insere projeto
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

-- idade

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

SELECT * FROM BRH.PROJETO;

-- finaliza projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto(p_id_projeto brh.projeto.id%type)
RETURN brh.projeto.fim%type
IS
    v_data_fim brh.projeto.fim%type;
BEGIN
    UPDATE brh.projeto
    SET brh.projeto.fim = SYSDATE
    WHERE id = p_id_projeto AND brh.projeto.fim IS NULL;
    v_data_fim := SYSDATE;
    COMMIT;
    RETURN v_data_fim;
END;
BEGIN
brh.finaliza_projeto(47);
END;



CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME BRH.PROJETO.NOME%type
,p_RESPONSAVEL BRH.PROJETO.RESPONSAVEL%type)
IS
BEGIN
    
    IF LENGTH(p_NOME) <= 2 THEN
    
        DBMS_OUTPUT.PUT_LINE('O nome do projeto deve ter mais de 2 caracteres.');
    ELSE
    
        INSERT INTO BRH.PROJETO(NOME, RESPONSAVEL, INICIO)
        VALUES (p_NOME, p_RESPONSAVEL, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Projeto cadastrado com sucesso.');
    END IF;
    
END;

EXECUTE brh.insere_projeto('teste', 'T123');






