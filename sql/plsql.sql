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








    