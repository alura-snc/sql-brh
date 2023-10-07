CREATE PROCEDURE brh_insere_projeto
   ( p_nome in  VARCHAR2, p_id in  number
)

is 
BEGIN
  INSERT INTO BRH.PROJETO (NOME, ID) VALUES (UPPER (p_nome), p_id)
  ;
end;
  
  
-- Inserção de um novo registro na tabela BRH_PROJETO
INSERT INTO BRH.PROJETO (NOME, RESPONSAVEL, INICIO, FIM)
VALUES ('PSQL', 'E123', TO_DATE('2023-10-06', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

COMMIT;



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




----------------------------------------------

CREATE OR REPLACE FUNCTION brh.finaliza_projeto(p_id NUMBER)
RETURN DATE
IS
    v_data_finalizacao DATE;
BEGIN
    -- Obtém a data e hora atuais
    v_data_finalizacao := SYSDATE;
    
    -- Atualiza a data de finalização do projeto
    UPDATE brh.projeto
    SET fim = v_data_finalizacao
    WHERE id = p_id;
    
    -- Retorna a data de finalização atribuída ao projeto
    RETURN v_data_finalizacao;
EXCEPTION
    WHEN OTHERS THEN
        -- Trate exceções, se necessário
        -- Faça um ROLLBACK em caso de erro
        ROLLBACK;
END;



DECLARE
    v_data_finalizacao DATE;
BEGIN
    v_data_finalizacao := brh.finaliza_projeto(27); -- Substitua 27 pelo ID do projeto que deseja finalizar.
    DBMS_OUTPUT.PUT_LINE('Data de Finalização: ' || TO_CHAR(v_data_finalizacao, 'YYYY-MM-DD HH24:MI:SS'));
END;



DECLARE
    v_finalizacao DATE;
BEGIN
    v_finalizacao := brh.finaliza_projeto(27); -- Substitua 1 pelo ID do projeto desejado
    DBMS_OUTPUT.PUT_LINE('Data de finalização do projeto: ' || TO_CHAR(v_finalizacao, 'DD-MM-YYYY HH24:MI:SS'));
    COMMIT; -- Confirmar as alterações
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        ROLLBACK;
END;




------------------------

--ALTERA A PROCEDURE INSERI PROJETO
CREATE OR REPLACE PROCEDURE brh_insere_projeto
   (p_nome IN VARCHAR2, p_id IN NUMBER)
IS 
BEGIN
  -- Verifica se o ID do projeto é maior que zero (válido)
  IF p_id <= 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'O ID do projeto deve ser maior que zero.');
  END IF;
  
  -- Verifica se o nome do projeto tem dois ou mais caracteres
  IF LENGTH(p_nome) < 2 OR p_nome IS NULL THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
  END IF;

  -- Insere o projeto na tabela BRH.PROJETO
  INSERT INTO BRH.PROJETO (NOME, ID) VALUES (UPPER(p_nome), p_id);
  
  -- Comita a transação para salvar as alterações no banco de dados.
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    -- Em caso de erro, faz um ROLLBACK da transação
    ROLLBACK;
    -- Propaga a exceção
    RAISE;
END;


  
-- Inserção de um novo registro na tabela BRH.PROJETO
INSERT INTO BRH.PROJETO (NOME, RESPONSAVEL, INICIO, FIM)
VALUES ('NOVO_PROJETO', 'E123', TO_DATE('2023-10-06', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

SELECT * FROM BRH.PROJETO;


COMMIT;

---------------------------

CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    -- Verifica se a data de nascimento é maior do que a data atual (ou seja, a pessoa já nasceu)
    IF p_data_nascimento >= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data de nascimento inválida! A data deve ser anterior à data atual.');
    END IF;

    -- Calcula a idade usando MONTHS_BETWEEN e armazena o resultado em v_idade
    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE, p_data_nascimento) / 12);

    -- Retorna a idade
    RETURN v_idade;
EXCEPTION
    WHEN OTHERS THEN
        -- Trate exceções, se necessário
        RAISE;
END;
-----------------------


CREATE OR REPLACE PROCEDURE brh.define_atribuicao (
    p_nome_colaborador IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_nome_papel IN VARCHAR2
)
IS
    v_colaborador_id NUMBER;
    v_id NUMBER;
    v_papel_id NUMBER;
BEGIN
    -- Verifica se o colaborador existe
    SELECT id INTO v_colaborador_id
    FROM COLABORADOR
    WHERE nome = p_nome_colaborador;

    -- Verifica se o projeto existe
    SELECT id INTO v_id
    FROM PROJETO
    WHERE nome = p_nome;

    -- Verifica se o papel existe
    BEGIN
        SELECT id INTO v_papel_id
        FROM PAPEL
        WHERE nome = p_nome_papel;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Se o papel não existe, cadastra um novo papel com o nome recebido
            INSERT INTO PAPEL (nome) VALUES (p_nome_papel);
            
            -- Recupera o ID do novo papel
            SELECT id INTO v_papel_id
            FROM PAPEL
            WHERE nome = p_nome_papel;
    END;

    -- Insere a atribuição
    INSERT INTO ATRIBUICAO (colaborador, projeto, papel)
    VALUES (v_colaborador_id, v_id, v_papel_id);
END;

BEGIN
    BEGIN
        brh.define_atribuicao('Eli', 'PSQL', 'DBA');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
    END;
END;



-------------






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

