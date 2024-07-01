/* *********************    Semana 4  **************************************   */


/* 1 Crie a procedure brh.insere_projeto para cadastrar um novo projeto na base de dados:
Parâmetros da procedure:
Nome do projeto: varchar com nome do novo projeto.
Responsável do projeto: varchar com a matrícula do colaborador responsável.*/

create or replace procedure brh.insere_projeto(
p_nome IN brh.projeto.nome%type,
p_responsavel IN brh.projeto.responsavel%type)
IS
BEGIN
    IF LENGTH(P_NOME)<2 THEN
        RAISE_APPLICATION_ERROR(-20001,'Nome do projeto inválido !!!! DEVE TER 2 OU MAIS CARACTERES');
    ELSIF p_nome IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002,'Nome do projeto NÃO PODE ESTAR VAZIO');
    ELSE
     INSERT INTO brh.projeto (nome,responsavel,inicio)
     VALUES(INITCAP(p_nome),UPPER(p_responsavel), SYSDATE);
    END IF;
END;
EXECUTE brh.insere_projeto('SENAC','D123');

SELECT * FROM brh.projeto;

commit;


SELECT * FROM brh.COLABORADOR;

EXECUTE brh.insere_projejto('NASA','A123');
EXECUTE brh.insere_projeto('A','U23');




/* 2  
Crie a function brh.calcula_idade, que informa a idade a partir de uma data:
Parâmetros da function:
Data: date com a data de referência para calcular a idade.
Retorno da function:
Deve retornar um número inteiro com a idade.
Adicione o código no arquivo sql/plsql.sql;
Faça commit do arquivo.

*/



CREATE OR REPLACE FUNCTION brh.calcula_idade
( p_data_nascimento IN DATE )
RETURN  NUMBER
IS 
    v_idade NUMBER;
BEGIN
    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE,p_data_nascimento)/12);
    RETURN v_idade;
END;

SELECT brh.calcula_idade(TO_DATE('1984-04-25','YYYY-MM-DD')) from dual;


SELECT nome, data_nascimento ,brh.calcula_idade(data_nascimento)
from brh.dependente;

SELECT brh.calcula_idade(data_nascimento)
from brh.dependente
where colaborador = 'A123';

commit;


/*3
Crie a function brh.finaliza_projeto para registrar o término da execução de um projeto:
Parâmetros da function:
ID do projeto: number com identificador do projeto a ser finalizado.
Retorno da function:
Deve retornar a data de finalização atribuída ao projeto.
Adicione o código no arquivo sql/plsql.sql;
Faça commit do arquivo.


Critérios de aceitação
A data fim do projeto deve ser a data e hora atual;
Não deve fazer commit em seu código (a efetivação da transação deve ser feita por quem invoca a function).
*/

CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
    p_id_projeto NUMBER
) RETURN DATE IS
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





/* 4
Tarefa
Altere a procedure brh.insere_projeto para não permitir cadastrar projetos inválidos;
Adicione o código no arquivo sql/plsql.sql;
Faça commit do arquivo.
Critérios de aceitação
O nome do novo do projeto deve ter duas ou mais letras:
Se tiver menos caracteres, ou for null, lance uma exceção com a mensagem "Nome de projeto inválido! Deve ter dois ou mais caracteres.".
Dicas
Use a função LENGTH para descobrir o tamanho do texto.*/


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