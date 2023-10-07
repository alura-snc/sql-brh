
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
