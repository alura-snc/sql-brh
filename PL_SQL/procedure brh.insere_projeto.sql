CREATE PROCEDURE brh_insere_projeto
   ( p_nome in  VARCHAR2, p_id in  number
)

is 
BEGIN
  INSERT INTO BRH.PROJETO (NOME, ID) VALUES (UPPER (p_nome), p_id)
  ;
end;
  