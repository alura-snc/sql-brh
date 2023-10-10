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

-- Validar novo projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    id_projeto NUMBER,
    nome_projeto VARCHAR2,
    responsavel_projeto VARCHAR2
) AS
BEGIN    
    IF LENGTH(nome_projeto) < 2 OR nome_projeto IS NULL THEN        
        RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    ELSE        
        INSERT INTO brh.projeto (id, nome, responsavel, inicio)
        VALUES (id_projeto, nome_projeto, responsavel_projeto, SYSDATE);
    END IF;
END insere_projeto;

-- Validar cálculo de idade
CREATE OR REPLACE FUNCTION calcula_idade (
    data_nascimento IN DATE
) RETURN NUMBER IS
    idade NUMBER;
BEGIN
    IF data_nascimento IS NULL OR data_nascimento >= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossível calcular idade! Data inválida: ' || TO_CHAR(data_nascimento, 'DD-MON-YYYY'));
    ELSE
        idade := TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12);
        RETURN idade;
    END IF;
END calcula_idade;

-- Criar procedure define_atribuicao
CREATE OR REPLACE PROCEDURE define_atribuicao (
    p_nome_colaborador VARCHAR2,
    p_nome_projeto VARCHAR2,
    p_nome_papel VARCHAR2
) AS
    v_colaborador_id brh.colaborador.matricula%TYPE;
    v_projeto_id brh.projeto.id%TYPE;
    v_papel_id brh.papel.id%TYPE;
BEGIN
    -- Verificar se o colaborador existe
    SELECT matricula INTO v_colaborador_id
    FROM brh.colaborador
    WHERE nome = p_nome_colaborador;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Colaborador inexistente: ' || p_nome_colaborador);
    
    -- Verificar se o projeto existe
    SELECT id INTO v_projeto_id
    FROM brh.projeto
    WHERE nome = p_nome_projeto;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Projeto inexistente: ' || p_nome_projeto);
    
    -- Verificar se o papel existe ou criar um novo papel
    BEGIN
        SELECT id INTO v_papel_id
        FROM brh.papel
        WHERE nome = p_nome_papel;
        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Criar novo papel
            INSERT INTO brh.papel (nome)
            VALUES (p_nome_papel)
            RETURNING id INTO v_papel_id;
    END;

    -- Inserir atribuição
    INSERT INTO brh.atribuicao (colaborador, projeto, papel)
    VALUES (v_colaborador_id, v_projeto_id, v_papel_id);
END define_atribuicao;

