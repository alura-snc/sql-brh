alter session set "_ORACLE_SCRIPT"=true;

SELECT * FROM BRH.PROJETO;

//CRIANDO A PROCEDURE

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_projeto VARCHAR2,
    p_responsavel_projeto VARCHAR2
) AS
BEGIN
    INSERT INTO brh.projeto (nome, responsavel, inicio)
    VALUES (p_nome_projeto, p_responsavel_projeto, SYSDATE);
END;
/

//INVOCANDO A PROCEDURE
BEGIN
    brh.insere_projeto('Novo Projeto 1', 'B123');
    COMMIT; 
    END;
/
