
CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    -- Verifica se a data de nascimento � maior do que a data atual (ou seja, a pessoa j� nasceu)
    IF p_data_nascimento >= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data de nascimento inv�lida! A data deve ser anterior � data atual.');
    END IF;

    -- Calcula a idade usando MONTHS_BETWEEN e armazena o resultado em v_idade
    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE, p_data_nascimento) / 12);

    -- Retorna a idade
    RETURN v_idade;
EXCEPTION
    WHEN OTHERS THEN
        -- Trate exce��es, se necess�rio
        RAISE;
END;
