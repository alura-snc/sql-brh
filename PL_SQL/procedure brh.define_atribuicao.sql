
CREATE OR REPLACE PROCEDURE brh.define_atribuicao (
    p_nome_colaborador IN VARCHAR2,
    p_nome_projeto IN VARCHAR2,
    p_nome_papel IN VARCHAR2
)
IS
    v_colaborador_count NUMBER;
    v_projeto_count NUMBER;
    v_papel_count NUMBER;
BEGIN
    -- Verifica se o colaborador existe
    SELECT COUNT(*) INTO v_colaborador_count
    FROM COLABORADOR
    WHERE nome = p_nome_colaborador;

    IF v_colaborador_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Colaborador inexistente: ' || p_nome_colaborador);
    END IF;

    -- Verifica se o projeto existe
    SELECT COUNT(*) INTO v_projeto_count
    FROM PROJETO
    WHERE nome = p_nome_projeto;

    IF v_projeto_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Projeto inexistente: ' || p_nome_projeto);
    END IF;

    -- Verifica se o papel existe
    SELECT COUNT(*) INTO v_papel_count
    FROM PAPEL
    WHERE nome = p_nome_papel;

    IF v_papel_count = 0 THEN
        -- Se o papel não existe, cadastra um novo papel com o nome recebido
        INSERT INTO PAPEL (nome) VALUES (p_nome_papel);
    END IF;

    -- Insere a atribuição
    INSERT INTO ATRIBUICAO (colaborador, projeto, papel)
    VALUES (p_nome_colaborador, p_nome_projeto, p_nome_papel);
END;

-----



BEGIN
    brh.define_atribuicao('Atiel', 'PSQL', 'DBA');
    COMMIT; -- Efetivar a transação aqui
END;
