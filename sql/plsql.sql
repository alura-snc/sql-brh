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
