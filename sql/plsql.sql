CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    nome_projeto IN VARCHAR2,
    responsavel_projeto IN VARCHAR2
) AS
BEGIN
    INSERT INTO brh.projeto (nome, responsavel, inicio)
    VALUES (nome_projeto, responsavel_projeto, SYSDATE);
END;
/
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    data_nascimento IN DATE
) RETURN NUMBER IS
    idade NUMBER;
BEGIN
    -- Calcula a diferença em meses entre a data atual e a data de nascimento
    idade := FLOOR(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12);
    RETURN idade;
END;
/CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    nome_projeto IN VARCHAR2,
    responsavel_projeto IN VARCHAR2
) AS
BEGIN
    -- Verifica se o nome do projeto é válido
    IF nome_projeto IS NULL OR LENGTH(nome_projeto) < 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    END IF;

    INSERT INTO brh.projeto (nome, responsavel, inicio)
    VALUES (nome_projeto, responsavel_projeto, SYSDATE);
END;
/

-- Tentativa de inserir um projeto com nome inválido (menos de 2 caracteres)
BEGIN
    brh.insere_projeto('A', '08754');
END;
/

-- Tentativa de inserir um projeto com nome válido
BEGIN
    brh.insere_projeto('Novo Projeto', '08754');
END;
/
