--  Criar procedure Insere_Projeto
--  Criando procedure para cadastrar um novo projeto na base de dados:

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(
    p_NOME          BRH.PROJETO.NOME%TYPE,
    p_RESPONSAVEL   BRH.PROJETO.RESPONSAVEL%TYPE,
    p_INICIO        BRH.PROJETO.INICIO%TYPE   
)  
IS
BEGIN
    INSERT INTO BRH.PROJETO
    (NOME, RESPONSAVEL, INICIO)
    VALUES
    (p_NOME, p_RESPONSAVEL, p_INICIO); 
END;


--_______________________________________________________________________________________

--  Criar função calcula_idade
--  Criando uma função que informa a idade a partir de uma data.

CREATE OR REPLACE FUNCTION  brh.calcula_idade
(
    p_DATA_NASCIMENTO IN  DATE
)
RETURN NUMBER
IS
    v_IDADE NUMBER;
BEGIN
    v_IDADE := TRUNC(MONTHS_BETWEEN (SYSDATE, p_DATA_NASCIMENTO)/12);
    return v_IDADE;
END;


--_______________________________________________________________________________________

--  Criar função finaliza_projeto
--  Criando uma função para registrar o término da execução de um projeto

CREATE OR REPLACE FUNCTION  brh.finaliza_projeto
(
    p_ID IN BRH.PROJETO.ID%TYPE
)
RETURN DATE
IS
    v_FIM DATE;
BEGIN
    v_FIM := TO_DATE(SYSDATE, 'DD/MM/YYYY');
    UPDATE BRH.PROJETO SET FIM = v_FIM WHERE ID = p_ID;
    RETURN v_FIM;
END;


--_______________________________________________________________________________________

--  Validar novo projeto
--  Alterando a procedure brh.insere_projeto para não permitir cadastrar projetos inválidos:
--  O nome do novo do projeto deve ter duas ou mais letras.
--  Se tiver menos caracteres, ou for null, lance uma exceção com a mensagem "Nome de projeto inválido! Deve ter dois ou mais caracteres.".

CREATE OR REPLACE PROCEDURE brh.insere_projeto
(
    p_NOME          BRH.PROJETO.NOME%TYPE,
    p_RESPONSAVEL   BRH.PROJETO.RESPONSAVEL%TYPE,
    p_INICIO        BRH.PROJETO.INICIO%TYPE   
)  
IS
BEGIN
    IF LENGTH(p_NOME) < 2 OR p_NOME IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    ELSE
        INSERT INTO BRH.PROJETO
        (NOME, RESPONSAVEL, INICIO)
        VALUES
        (p_NOME, p_RESPONSAVEL, p_INICIO);
    END IF;
END;


--_______________________________________________________________________________________

--  Validar cálculo de idade
--  Alterando a função brh.calcula_idade para não permitir datas inválidas;

CREATE OR REPLACE FUNCTION  brh.calcula_idade
(
    p_DATA_NASCIMENTO IN  DATE
)
RETURN NUMBER
IS
    v_IDADE NUMBER;
BEGIN
    IF p_DATA_NASCIMENTO >= SYSDATE OR p_DATA_NASCIMENTO IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossível calcular idade! Data inválida: '|| p_DATA_NASCIMENTO);
    ELSE    
        v_IDADE := TRUNC(MONTHS_BETWEEN (SYSDATE, p_DATA_NASCIMENTO)/12);
        return v_IDADE;
    END IF;
END;


--_______________________________________________________________________________________

--  Criar procedure define_atribuicao
--  Criando uma procedure para inserir um colaborador num projeto em um determinado papel

CREATE OR REPLACE PROCEDURE brh.define_atribuicao
(
    p_NOME_COLABORADOR  IN BRH.COLABORADOR.NOME%TYPE,
    p_NOME_PROJETO      IN BRH.PROJETO.NOME%TYPE,
    p_PAPEL             IN BRH.PAPEL.NOME%TYPE
)
IS
    v_EXISTE_COLABORADOR NUMBER;
    v_EXISTE_PROJETO NUMBER;
    v_EXISTE_PAPEL NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_EXISTE_COLABORADOR FROM BRH.COLABORADOR WHERE NOME = p_NOME_COLABORADOR;
    SELECT COUNT(*) INTO v_EXISTE_PROJETO FROM BRH.PROJETO WHERE NOME = p_NOME_PROJETO;
    SELECT COUNT(*) INTO v_EXISTE_PAPEL FROM BRH.PAPEL WHERE NOME = p_PAPEL;
    
    IF v_EXISTE_COLABORADOR = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Colaborador inexistente: ' || p_NOME_COLABORADOR);
    ELSIF v_EXISTE_PROJETO = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Projeto inexistente: ' || p_NOME_PROJETO);
    ELSIF v_EXISTE_PAPEL = 0 THEN
        INSERT INTO BRH.PAPEL (NOME) VALUES (p_PAPEL);
        INSERT INTO BRH.ATRIBUICAO VALUES 
        (
            (SELECT MATRICULA   FROM BRH.COLABORADOR WHERE NOME = p_NOME_COLABORADOR),
            (SELECT ID          FROM BRH.PROJETO     WHERE NOME = p_NOME_PROJETO),
            (SELECT ID          FROM BRH.PAPEL       WHERE NOME = p_PAPEL)
        );     
    ELSE
        INSERT INTO BRH.ATRIBUICAO VALUES 
        (
            (SELECT MATRICULA   FROM BRH.COLABORADOR WHERE NOME = p_NOME_COLABORADOR),
            (SELECT ID          FROM BRH.PROJETO     WHERE NOME = p_NOME_PROJETO),
            (SELECT ID          FROM BRH.PAPEL       WHERE NOME = p_PAPEL)
        );
    END IF;        
END;
