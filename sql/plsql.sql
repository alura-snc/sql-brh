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




