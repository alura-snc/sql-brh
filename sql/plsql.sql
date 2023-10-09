-- Semana 4
-- Criar procedure Insere_projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto(
    p_id_projeto IN INTEGER,
    p_nome_projeto IN VARCHAR2,
    p_responsavel_projeto IN VARCHAR2
)
IS
BEGIN
    INSERT INTO brh.projeto(id, nome, responsavel, inicio, fim)
    VALUES (p_id_projeto, p_nome_projeto, p_responsavel_projeto, SYSDATE, NULL);
END;

-- Criar função calcula_idade
CREATE OR REPLACE FUNCTION calcula_idade(
    p_data_referencia IN DATE
) 
RETURN INTEGER
IS
    v_idade INTEGER;
BEGIN
    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE, p_data_referencia) / 12);
    RETURN v_idade;
END calcula_idade;

SELECT calcula_idade(TO_DATE('18-02-1993', 'DD-MM-YYYY')) AS idade FROM DUAL; -- Testar Função







    