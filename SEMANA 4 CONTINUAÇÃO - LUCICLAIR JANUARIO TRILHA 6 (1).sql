Semana 4
Tarefas:
Criar procedure Insere_projeto
Criar função calcula_idade
Criar função finaliza_projeto
Validar novo projeto
Validar cálculo de idade
Criar procedure define_atribuicao
CREATE OR REPLACE PROCEDURE brh.insere_projeto ( 
P_nome IN brh.projeto.nome%type,
P_responsavel IN brh.projeto.responsavel%type
)
IS
BEGIN
IF LENGTH (p_nome) < 2 THEN
RAISE APPLICATION_ERROR (-20001), ‘Nome do projeto inválido! Deve ter dois ou mais caracteres.’);
ELSE p_nome IS NULL THEN 
RAISE APPLICATION_ERROR (-20002), ‘Nome do projeto inválido! Nome não poder ser nulo.’);
ELSE
INSERT INTO brh.projeto (nome, responsagel, inicico)
VALUES (p_nome, p_responsavel, SYSDATE); OU INITCAP OU UPPER

END IF;
END;
SELEC * FROM BRH.PROJETO 
OU
SELECT NOME, INITCAP (NOME) FROM BRH.PROJETO
EXECUTE breh.insere_projeto (NULL, ‘U123’) OU  alura OU f123
COMMIT;
BEGIN
Brh.insere_projeto (‘Projeto Sena 4’, ‘H123’);
Commit; ---Efetua o commit após a chamada da procedure, se necessário
SELECT LENGTH (NOME), FROM BRH.COLABORADOR
Insert INTO
Select * from brh.projeto

CREATE OR REPLACE FUNCTION brh.calcula_idade (
P_data_nascimento IN DATE
)
RETURN NUMBER
IS
V_idade NUMBER;
BEGIN
IF p_data_nascimento >= SYSDATE THEN
RAISE APPLICATION_ERROR (-20002), ‘Impossível calcular idade! Data maior que data atual: ‘ // TO CHAR (p_data-nascimento, ‘DD-MM-YYYY’) //’.’);
ELSIF p_data-nascimento IS NULL THEN 
RAISE_APPLICATION_ERRO (-20003, ‘Impossível calcular idade! Data nula’);
ELSE
v_idade := TRUNC (MONTHS_BETWEEN (SYSDATE p_data-nascimento) / 12);
END IF;
RETURN v_idade;
END; 
Select brh.calcula_idade (TO_DATE (‘1988-04-25’. ‘YYYY-MM-DD’)) from dual
Select nome-data-nascimento, brh.calcula_idade(data_nacimento) as idade 
From brh.dependente 

SELECT * FROM BRH. PROJETO
CREATE OR REPLACE FUNCTION brh.finalizar_ projeto (
P_id_projeto IN brh.projeto.id%type)
RETURN DATE 
IS
V_data_fim DATE;
V_count INTEGER;
BEGIN
SELECT COUNT (*) 
INTO v_count
FROM BRH.PROJETO
 WHERE UD = p_id-projeto;
IF v_count = 0 THEN 
RAISE_APPLICATION_ERROR (-20001, ‘Projeto não encontrado.’);
END IF;
v_data_fim : = SYSDATE;
UPDATE brh.projeto
SET fim = v_data_fim
WHERE ID = p_id-projeto;
RETURN v_data_fim;
EXCEPTION
AULA DIA 28/06/2024
PAREI NO HORÁRIO 45H06
END;

