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

-- Criar função finaliza_projeto
CREATE OR REPLACE FUNCTION finaliza_projeto(
    p_id_projeto IN NUMBER
) 
RETURN DATE
IS
    v_data_finalizacao DATE;
BEGIN
    v_data_finalizacao := SYSDATE;
    UPDATE brh.projeto
    SET fim = v_data_finalizacao
    WHERE id = p_id_projeto;    
    RETURN v_data_finalizacao;
END finaliza_projeto;

DECLARE -- Testar Função
    v_projeto_id NUMBER := 5; 
    v_data_final DATE;
BEGIN    
    v_data_final := finaliza_projeto(v_projeto_id);    
    DBMS_OUTPUT.PUT_LINE('Data de finalização do projeto: ' || TO_CHAR(v_data_final, 'DD/MM/YYYY HH24:MI:SS'));
END;
