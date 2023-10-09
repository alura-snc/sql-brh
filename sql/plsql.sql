
show user;
grant alter user to brh;
ALTER USER BRH QUOTA UNLIMITED ON USERS;
GRANT connect, resource TO brh;
alter user brh account lock;

SELECT * FROM BRH.PROJETO;
-- insere projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME BRH.PROJETO.NOME%type
,p_RESPONSAVEL BRH.PROJETO.RESPONSAVEL%type)
IS
BEGIN
    INSERT INTO BRH.PROJETO(NOME,RESPONSAVEL,INICIO)
    VALUES(p_NOME, p_RESPONSAVEL,sysdate);
    COMMIT;
END;
EXECUTE brh.insere_projeto('NOV2', 'T123');

-- idade

CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    SELECT TRUNC(months_between(sysdate, p_data_nascimento) / 12)
    INTO v_idade
    FROM DUAL;

    RETURN v_idade;
END;

SELECT brh.calcula_idade(TO_DATE('10-12-1970', 'DD-MM-YYYY')) AS IDADE FROM DUAL;

SELECT * FROM BRH.PROJETO;

-- finaliza projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto(p_id_projeto brh.projeto.id%type)
RETURN brh.projeto.fim%type
IS
    v_data_fim brh.projeto.fim%type;
BEGIN
    UPDATE brh.projeto
    SET brh.projeto.fim = SYSDATE
    WHERE id = p_id_projeto AND brh.projeto.fim IS NULL;
    v_data_fim := SYSDATE;
    COMMIT;
    RETURN v_data_fim;
END;
BEGIN
brh.finaliza_projeto(47);
END;

-- alterar insere projetos

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME BRH.PROJETO.NOME%type
,p_RESPONSAVEL BRH.PROJETO.RESPONSAVEL%type)
IS

BEGIN
    
    IF LENGTH(p_NOME) <= 2 THEN
        DBMS_OUTPUT.PUT_LINE('O nome do projeto deve ter mais de 2 caracteres.');
    ELSE
    
        INSERT INTO BRH.PROJETO(NOME, RESPONSAVEL, INICIO)
        VALUES (p_NOME, p_RESPONSAVEL, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Projeto cadastrado com sucesso.');
    END IF;
    
END;

EXECUTE brh.insere_projeto('t', 'T123');


-- alterar a calcula idade

CREATE OR REPLACE FUNCTION brh.calcula_idade(p_data_nascimento DATE)
RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    IF (p_data_nascimento > SYSDATE) THEN
        DBMS_OUTPUT.PUT_LINE('Impossivel calcular, data inválida.' || TO_CHAR(p_data_nascimento, 'DD-MM-YYYY'));
    ELSE
        SELECT TRUNC(months_between(sysdate, p_data_nascimento) / 12)
        INTO v_idade
        FROM DUAL;
        RETURN v_idade;
   
END;

SELECT brh.calcula_idade(TO_DATE('10-12-2070', 'DD-MM-YYYY')) AS IDADE FROM DUAL;


-- atribuir colaborador

SELECT * FROM BRH.ATRIBUICAO;

CREATE OR REPLACE PROCEDURE brh.define_atribuicao (
    p_colaborador_matricula brh.colaborador.matricula%type,
    p_projeto_id brh.projeto.id%type,
    p_papel_id brh.papel.id%type
)
IS
    v_colaborador_matricula brh.colaborador.matricula%type;
    v_projeto_id brh.projeto.id%type;
    v_papel_id brh.papel.id%type;
BEGIN
    
    SELECT nome INTO v_colaborador_matricula FROM brh.colaborador WHERE brh.colaborador.matricula = p_colaborador_matricula;
    SELECT nome INTO v_projeto_id FROM brh.projeto WHERE brh.projeto.id = p_projeto_id;
    SELECT nome INTO v_papel_id FROM brh.papel WHERE brh.papel.id = p_papel_id;

   
    INSERT INTO brh.atribuicao (colaborador, projeto, papel)
    VALUES (p_colaborador_matricula, p_projeto_id, p_papel_id);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Atribuição cadastrada com sucesso:');
    DBMS_OUTPUT.PUT_LINE('Colaborador: ' || v_colaborador_matricula);
    DBMS_OUTPUT.PUT_LINE('Projeto: ' || v_projeto_id);
    DBMS_OUTPUT.PUT_LINE('Papel: ' || v_papel_id);
EXCEPTION
   
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Não foi possível cadastrar a atribuição. Um ou mais registros não existem:');
        DBMS_OUTPUT.PUT_LINE('Colaborador: ' || p_colaborador_matricula);
        DBMS_OUTPUT.PUT_LINE('Projeto: ' || p_projeto_id);
        DBMS_OUTPUT.PUT_LINE('Papel: ' || p_papel_id);
END;

SELECT * FROM BRH.ATRIBUICAO;

   EXECUTE define_atribuicao('A124',7, 2);




