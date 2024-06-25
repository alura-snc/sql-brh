CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_projeto IN VARCHAR2,
    p_responsavel IN VARCHAR2
) IS
BEGIN
    INSERT INTO brh.projeto (id_projeto, nome_projeto, responsavel)
    VALUES (brh.seq_projeto.NEXTVAL, p_nome_projeto, p_responsavel);

    -- Não faça commit aqui. A transação deve ser gerenciada por quem chama a procedure.
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;


-- Criar função calcula_idade
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data_nascimento IN DATE
) RETURN NUMBER IS
    v_idade NUMBER;
BEGIN
    -- Calculate the age in years using MONTHS_BETWEEN
    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_nascimento) / 12);
    RETURN v_idade;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;

-- Criar função finaliza_projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
    p_id_projeto IN NUMBER
) RETURN DATE IS
    v_data_fim DATE;
BEGIN
    -- Atualiza a data de finalização do projeto
    v_data_fim := SYSDATE;
    UPDATE brh.projeto
    SET data_fim = v_data_fim
    WHERE id_projeto = p_id_projeto;

    -- Retorna a data de finalização
    RETURN v_data_fim;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;

-- Criar função finaliza_projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
    p_id_projeto IN NUMBER
) RETURN DATE IS
    v_data_fim DATE;
BEGIN
    -- Atualiza a data de finalização do projeto
    v_data_fim := SYSDATE;
    UPDATE brh.projeto
    SET data_fim = v_data_fim
    WHERE id_projeto = p_id_projeto;

    -- Retorna a data de finalização
    RETURN v_data_fim;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;

-- Validar novo projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_projeto IN VARCHAR2,
    p_responsavel IN VARCHAR2
) IS
BEGIN
    
    IF p_nome_projeto IS NULL OR LENGTH(p_nome_projeto) < 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    END IF;

    INSERT INTO brh.projeto (id_projeto, nome_projeto, responsavel)
    VALUES (brh.seq_projeto.NEXTVAL, p_nome_projeto, p_responsavel);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;






