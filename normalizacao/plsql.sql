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

//CRIAR FUNÇÃO CALCULA_IDADE
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data_referencia DATE
) RETURN NUMBER IS
    v_idade NUMBER;
BEGIN
    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_referencia) / 12);
    RETURN v_idade;
END;
/

//TESTANDO A FUNÇÃO
SELECT brh.calcula_idade(DATE '1982-09-03') FROM DUAL;

//CRIAR FUNÇÃO FINALIZA_PROJETO
CREATE OR REPLACE FUNCTION brh.finaliza_projeto(
    p_projeto_id NUMBER)
RETURN DATE
IS
  v_data_finalizacao DATE;
BEGIN
  -- Define a data de finalização como a data e hora atuais
  v_data_finalizacao := SYSDATE;

  -- Atualiza a tabela de projetos com a data de finalização
  UPDATE brh.projeto
  SET fim = v_data_finalizacao
  WHERE id = p_projeto_id;

  -- Retorna a data de finalização atribuída ao projeto
  RETURN v_data_finalizacao;
END;
/

//TESTANDO A FUNÇÃO
DECLARE

  v_data_finalizacao DATE;
BEGIN
   v_data_finalizacao := brh.finaliza_projeto(8); 
   DBMS_OUTPUT.PUT_LINE('Data de Finalização: ' || TO_CHAR(v_data_finalizacao, 'DD-MON-YYYY HH24:MI:SS'));
    -- COMMIT;
END;
/

//VALIDAR NOVO PROJETO
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome_projeto VARCHAR2,
    p_responsavel_projeto VARCHAR2
) IS
BEGIN
  -- Verifica se o nome do projeto é válido (pelo menos duas letras)
  IF LENGTH(p_nome_projeto) < 2 OR p_nome_projeto IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
  END IF;

  -- Insere o projeto na tabela de projetos
  INSERT INTO brh.projeto (nome, responsavel, inicio)
  VALUES (p_nome_projeto, p_responsavel_projeto, SYSDATE);

  -- Exibe uma mensagem de sucesso
  DBMS_OUTPUT.PUT_LINE('Projeto inserido com sucesso!');
EXCEPTION
  WHEN OTHERS THEN
    -- Exibe a mensagem de erro
    DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

-- Testando a procedure brh.insere_projeto com um nome de projeto válido
BEGIN
  brh.insere_projeto('TESTE2', 'F123');
 END;
/
-- Testando a procedure brh.insere_projeto com um nome de projeto inválido
BEGIN
  brh.insere_projeto('T', 'F123');
 END;
/

//VALIDAR CÁLCULO DE IDADE
CREATE OR REPLACE FUNCTION brh.calcula_idade (
    p_data_referencia DATE
) RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    -- Verifica se a data de referência é válida (menor que a data atual)
    IF p_data_referencia IS NULL OR p_data_referencia >= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossível calcular idade! Data inválida: ' || TO_CHAR(p_data_referencia, 'DD-MON-YYYY') || '.');
    END IF;

    v_idade := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_referencia) / 12);
    RETURN v_idade;
END;
/


