-- 1. Criar procedure Insere_projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_do_projeto        IN VARCHAR2,
    p_responsavel_do_projeto IN VARCHAR2
) IS
BEGIN
    INSERT INTO brh.projeto (
        nome,
        responsavel,
        inicio
    ) VALUES (
        p_nome_do_projeto,
        p_responsavel_do_projeto,
        sysdate
    );

END;

EXECUTE brh.insere_projeto('Procedure','B123');

COMMIT;

-- 2. Criar função calcula_idade

CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data IN DATE
) RETURN NUMBER IS
    v_idade NUMBER;
BEGIN
    v_idade := trunc(months_between(sysdate, p_data) / 12);
    RETURN v_idade;
END;

SELECT
    nome,
    data_nascimento,
    brh.calcula_idade(data_nascimento)
FROM
    brh.dependente;

COMMIT;


-- 3. Criar função finaliza_projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
    p_id IN brh.projeto.id%TYPE
) RETURN DATE IS
    v_fim DATE;
BEGIN
    v_fim := sysdate;
    UPDATE brh.projeto
    SET
        fim = v_fim
    WHERE
        id = p_id;

    RETURN v_fim;
END;

DECLARE
    v_fim DATE;
BEGIN
    v_fim := brh.finaliza_projeto(26);
END;

COMMIT;

-- 4. Validar novo projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_do_projeto        IN VARCHAR2,
    p_responsavel_do_projeto IN VARCHAR2
) IS
BEGIN
    IF length(p_nome_do_projeto) < 2 OR p_nome_do_projeto IS NULL THEN
        raise_application_error(-20001, '"Nome de projeto inválido! Deve ter dois ou mais caracteres.".');
    ELSE
        INSERT INTO brh.projeto (
            nome,
            responsavel,
            inicio
        ) VALUES (
            p_nome_do_projeto,
            p_responsavel_do_projeto,
            sysdate
        );

    END IF;
END;

EXECUTE brh.insere_projeto('AA','B123');

COMMIT;

-- 5. Validar cálculo de idade
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data IN DATE
) RETURN NUMBER IS
    v_idade NUMBER;
BEGIN
    IF p_data >= sysdate THEN
        raise_application_error(-20001, '"Impossível calcular idade! Data inválida:'
                                        || p_data
                                        || '>.".');
    ELSE
        v_idade := trunc(months_between(sysdate, p_data) / 12);
        RETURN v_idade;
    END IF;
END;

COMMIT;

UPDATE brh.dependente
SET
    data_nascimento = '01/01/2024'
WHERE
    nome = 'Cicrana de Tal';

SELECT
    nome,
    data_nascimento,
    brh.calcula_idade(data_nascimento)
FROM
    brh.dependente;

ROLLBACK;

COMMIT;
