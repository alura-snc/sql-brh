-- Tarefa 1 --

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    nome_projeto VARCHAR2,
    responsavel_projeto VARCHAR2
)
AS
BEGIN
    INSERT INTO brh.projeto (nome_projeto, responsavel_projeto)
    VALUES (nome_projeto, responsavel_projeto);
    COMMIT;
END;

-- Tarefa 2 --

CREATE OR REPLACE FUNCTION brh.calcula_idade(data DATE)
RETURN NUMBER IS idade NUMBER;
BEGIN
    SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, p_data) / 12)
    INTO idade
    FROM dual;
    RETURN idade;
END;

