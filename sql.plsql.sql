--- Criar procedure Insere_projeto

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
  p_nome IN brh.projeto.nome%type,
  p_responsavel IN brh.projeto.responsavel%type
)
IS
BEGIN
 INSERT INTO brh.projeto (nome, responsavel, inicio)
 VALUES (p_nome, p_responsavel, SYSDATE);
END;

-- testar
EXECUTE brh.insere_projeto ('GOOGLE', 'U123')

-- Criar função calcula idade

CREATE OR REPLACE FUNCTION brh.calcula_idade (
p_data_nascimento in DATE
)
RETURN NUMBER
IS
  v_idade NUMBER;
BEGIN
  v_idade := MONTHS_BETWEEN (SYSDATE, p_data_nascimento) /12;
  v_idade := FLOOR (v_idade);
  RETURN v_idade;
END;

-- testar
SELECT brh.calcula_idade (TO_DATE('1987-07-20', 'YYYY-MM-DD')) from dual;

SELECT nome, data_nascimento, brh.calcula_idade (data_nascimento) as idade
from brh.dependente;

select * from brh.dependente;

--- Criar função finaliza projeto

CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
p_id_projeto IN brh.projeto.id%type
)
RETURN DATE
IS
  v_data_fim DATE;
BEGIN
   v_data_fim := SYSDATE;
   UPDATE brh.projeto
   SET fim = v_data_fim 
   WHERE id = p_id_projeto;
   
   RETURN v_data_fim;
END;

DECLARE
    v_id_projeto NUMBER := 11;
    v_data_fim DATE;
BEGIN
    v_data_fim := brh.finaliza_projeto (v_id_projeto);
    DBMS_OUTPUT.PUT_LINE ('A data de término é : ' || v_data_fim);
END
;

--- testar (visualizar projeto ID 11 com a data do dia)
SELECT * FROM brh.projeto;

--- Validar novo projeto

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
p_nome IN brh.projeto.nome%type,
p_responsavel IN brh.projeto.responsavel%type
)
IS
BEGIN
   IF LENGTH (p_nome) < 2 OR p_nome IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001,'Nome do projeto inválido! Deve ter dois ou mais carceteres');
   ELSE
       INSERT INTO brh.projeto (nome, responsavel, inicio)
       VALUES (p_nome, p_responsavel, SYSDATE);
    END IF;
END;

--- testar 
EXECUTE brh.insere_projeto ('M', 'G123');



