Semana 4 continuaçao
Tarefas:
Criar procedure Insere_projeto
Criar função calcula_idade
Criar função finaliza_projeto
Validar novo projeto
Validar cálculo de idade
Criar procedure define_atribuicao
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
WHEN ORTHERS THEN
RAISE_APPLICATION_ERROR (-20002, ‘Erro ao finalizar o projeto.’ || SQLERRM);
END;

DECLARE
v_id_projeto NUMBER := 34;
v_ data_fim DATE;
BEGIN
v_data_fim :- brh.finaliza_projeto (v_id_projeto);
--DBMS_OUTPUT.PUT-LINE (‘A data de término é: ‘ || v_data_fim);
DBMS_OUTPUT.PUT-LINE (‘A data de término é: ‘ || TO_CHAR (v_data_fim, ‘YYYY-MM-DD HH24:MI:SS’));
END;
SELECT * FROM BRH.PROJETO
select id, NOME, TO_CHAR (fim. ‘YYYY-MM-DD HH24:MI:SS’) from brh.projeto

CREATE OR REPLACE FUNCTION brh.num_dependente
(p_matricula IN brh.colaborador.matricula%type
RETURN NUMBER 
IS
v _qtd_dependente NUMBER;
v_count INTEGER;
BEGIN
SELECT COUNT(*)
ONTO v_count
FROM brh.colaborador
WHERE matricula – p_matricula;
IF v_count – 0 THEN
RAISE_APPLICATION_ERROR (-20001, ‘Matricula não encontrada.’);
END IF;
SELECT COUNT (*)
 INTO v_qtd_dependente
FROM brh.dependente
WHERE colaborador = p_matricula;
RETURN v_qtd_dependente;
RAISE_APPLICATION_ERROR (-20002, ‘Erro ao calcular o numero de dependentes.’ || SQLERRM);
END;
Select nome, brh.num_dependente (matricula)
From brh.colaborador

CREATE OR REPLACE FUNCTION brh.fgts (
p_matricula IN brh.colaborador.matricula%type)
RETURN NUMBER
IS
v_fgts NUMBER;
SELECT (0.08* SALARIO)
INT v_fgts
FROM brh.colaborador
WHERE matricula – p_matricula;
RETURN v_fgts;
END;
Select nome, salario, brh.fgts(matricula) as valor_fgts
From brh.colaborador;
CREATE OR REPLACE VIEW brh.vw_rh AS
SELECT c.nome_departamento,
d.nome as nome_departamento,
brh.num_dependente (c.matricula) as qtd_dependentes,
brh.fgts (c.matricula) as valor_fgts

FROM brh.colaborador c
INNER JOIN brh.departamento d
On c.departameto – d.sigla
OU WHERE d.nome –‘Seção de Folha de Pagamento’
Select * from brh.vw_rh
END;
