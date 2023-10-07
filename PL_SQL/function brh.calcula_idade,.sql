
-- Criação da função
CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    -- Calcula a idade usando MONTHS_BETWEEN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, p_data_nascimento) / 12) INTO v_idade FROM DUAL;
    
    -- Retorna a idade
    RETURN v_idade;
END;