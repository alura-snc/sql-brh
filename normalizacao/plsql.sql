alter session set "_ORACLE_SCRIPT"=true;

SELECT * FROM BRH.PROJETO;

//CRIANDO A PROCEDURE

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_projeto VARCHAR2,
    p_responsavel_projeto VARCHAR2
) AS
BEGIN
    INSERT INTO brh.projeto (nome, responsavel, inicio)
    VALUES (p_nome_projeto, p_responsavel_projeto, SYSDATE);
END;
/

//INVOCANDO A PROCEDURE
BEGIN
    brh.insere_projeto('Novo Projeto 1', 'B123');
    COMMIT; 
    END;
/

//CRIAR FUNÇÃO CALCULA_IDADE
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data_referencia DATE
) RETURN NUMBER IS
    v_idade NUMBER;
BEGIN
    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_referencia) / 12);
    RETURN v_idade;
END;
/

//TESTANDO A FUNÇÃO
SELECT brh.calcula_idade(DATE '1982-09-03') FROM DUAL;

