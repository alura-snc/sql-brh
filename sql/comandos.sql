--*****************************************************************************************************************************
-- 01 - Inserir novo papel -Instru��es:
SELECT * from brh.papel;
INSERT INTO brh.papel (nome) 
VALUES('Especialista de Neg�cios');
--*****************************************************************************************************************************
-- 02 INICIANTE- Inserir novo colaborador e  endere�o

SELECT * FROM brh.endereco;        
INSERT INTO brh.endereco (cep, uf, cidade, bairro)
VALUES ('08090-001', 'SP',  'Mataca',  'Ilus�o');
 
SELECT * FROM brh.colaborador;
INSERT INTO brh.colaborador (matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES('2405', '123.456.789.24', 'Fulano de Tal', '8000', 'DEPTI', '08090-001', 'Rua dos Bobos', 'N� 0');
-- 02 INTERMWDIARIO - Inserir novo colaborador e  endere�o
MERGE INTO brh.endereco e
USING (
    SELECT '08090-111' AS cep,
           'PR' AS uf,
           'Maringa' AS cidade,
           'Florecer' AS bairro
    FROM dual
) new_address
ON (e.cep = new_address.cep)
WHEN NOT MATCHED THEN
    INSERT (cep, uf, cidade, bairro)
        VALUES (new_address.cep, new_address.uf, new_address.cidade, new_address.bairro);
SELECT * FROM brh.endereco;

MERGE INTO brh.colaborador c
USING (
    SELECT '31010' AS matricula,
           '432.123.012.00' AS cpf,
           'Andreia Caldeira Luciano' AS nome,
           '5000' AS salario,
           'DEPTI' AS departamento,
           '08090-111' AS cep,
           'Alameda Brasil' AS logradouro,
           'Casa - 44' AS complemento_endereco
    FROM dual
) new_colaborador
ON (c.cep = new_colaborador.cep)
WHEN NOT MATCHED THEN
    INSERT (matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco)
    VALUES (new_colaborador.matricula, new_colaborador.cpf, new_colaborador.nome, new_colaborador.salario, 
    new_colaborador.departamento, new_colaborador.cep, new_colaborador.logradouro, new_colaborador.complemento_endereco);
SELECT * FROM brh.colaborador;

-- 03 - INICIANTE - Inserir novo 

SELECT * FROM brh.projeto;
INSERT INTO brh.projeto (id,nome,inicio,fim)
VALUES
('5','BI','22/05/2024','15/08/2024');
UPDATE brh.projeto
SET responsavel = '2405' 
WHERE nome = 'BI'; 
SELECT * FROM brh.projeto;
-- 03 - INTERMEDIARIO - Inserir novo projeto: N�o consigo fazer de uma maneira melhor

--**********************************************************************************************************************************

--04 - Informa��es sobre o colaborador

/* Possui o telefone celular (61) 9 9999-9999;
Possui o telefone residencial (61) 3030-4040;
Email pessoal � fulano@email.com;
Email de trabalho ser� � fulano.tal@brh.com;
Possui dois dependentes:
Filha Beltrana de Tal;
Esposa Cicrana de Tal.
*/
SELECT * FROM  brh.telefone_colaborador;
INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo)
VALUES ('(61)9999-9999', '2405',  'M'); 
INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo)
VALUES ('(61) 3030-4040', '2405',  'R'); 

SELECT * FROM  brh.email_colaborador;
INSERT INTO brh.email_colaborador (email, colaborador, tipo)
VALUES  ('fulano@email.com', '2405', 'P');
INSERT INTO brh.email_colaborador (email, colaborador, tipo)
VALUES   ('fulano.tal@brh.com', '2405', 'T'); 

SELECT * FROM   brh.dependente;
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('243.361.552-88', '2405', 'Beltrana de Tal', 'Filho(a)', to_date('2007-09-01', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('155.781.842-40', '2405', 'Cicrana de Tal', 'C�njuge', TO_DATE('1983-05-01', 'YYYY-MM-DD'));

ALTER TABLE brh.dependente DROP CONSTRAINT parentesco_valido;
ALTER TABLE brh.dependente ADD CONSTRAINT parentesco_valido CHECK (parentesco in ('C�njuge', 'Filho(a)', 'Pai', 'M�e'))
);

--*********************************************************************************************************
--05 - Altera��o de dados - colaborador
/* 
A colaboradora Maria se casou e precisa que seus dados sejam atualizados na base.
Informa��es sobre o colaborador
Nome de casada: Maria Mendon�a;
Email: maria.mendonca@email.com;
Tarefa
Atualize os dados da Maria;
Adicione todos os comandos utilizados no arquivo sql/comandos.sql.
*/

SELECT * FROM brh.colaborador;

UPDATE brh.colaborador
SET nome = 'Maria Mendon�a'
    WHERE nome = 'Maria';

SELECT * FROM  brh.email_colaborador;
UPDATE  brh.email_colaborador
SET  email = 'maria.mendonca@email.com'
    WHERE colaborador = 'Maria';
    
--**************************************************************************************
--6 - Relat�rio de c�njuges
/*
Crie uma consulta que liste:
matricula do colaborador;
nome do dependente;
data de nascimento do dependente.
Adicione o c�digo da consulta em sql/comandos.sql.
*/
SELECT colab.matricula AS matricula_colaborador,
       depend.nome AS nome_dependente,
       depend.data_nascimento AS data_nascimento_dependente
FROM brh.colaborador colab
JOIN brh.dependente depend ON colab.matricula = depend.colaborador;

   
--**************************************************************************************
-- 7 - Relat�rio de contatos telef�nicos
/*
Crie uma consulta que liste:
matricula do colaborador;
n�mero de telefone.
Adicione o c�digo da consulta em sql/comandos.sql.
*/
SELECT 
    colab.matricula AS matricula_colaborador,
    tel.numero AS numero_telefone
FROM brh.colaborador colab
JOIN brh.telefone_colaborador tel ON colab.matricula = tel.colaborador;

  
--**************************************************************************************
-- 8 - Excluir departamento SECAP
/*
Contexto
O departamento SECAP n�o � mais parte da nossa organiza��o,
e todos os colaboradores ser�o dispensados (somente para fins did�ticos).
Tarefa
Remova o departamento SECAP da base de dados;
Adicione os comandos em sql/comandos.sql;
*/
SELECT * FROM brh.dependente;

DELETE FROM brh.dependente
WHERE colaborador IN (SELECT matricula FROM brh.colaborador WHERE departamento = 'SECAP');

DELETE FROM brh.atribuicao
WHERE colaborador IN (SELECT matricula FROM brh.colaborador WHERE departamento = 'SECAP');

DELETE FROM brh.departamento
WHERE sigla = 'SECAP';
SELECT * FROM brh.departamento;

DELETE FROM brh.colaborador
WHERE departamento = 'SECAP';

--**************************************************************************************
-- 9 - Relat�rio de Departamentos
/*
Tarefa
Crie uma consulta que liste a sigla e o nome do departamento;
Adicione o c�digo da consulta em sql/comandos.sql.
Regras de aceita��o
A consulta deve listar somente os colaboradores que:
morem no CEP 71777-700;
trabalhem nos departamentos SECAP ou SESEG.
O resultado da consulta deve ser ordenado pelo nome do departamento.
*/
SELECT * FROM brh.departamento;
--Alterando o nomes do Departamentos
UPDATE brh.departamento
SET nome = 
    CASE 
        WHEN sigla = 'DEPTI' THEN 'Tecnologia da Informa��o'
        WHEN sigla = 'SEDES' THEN 'Desenvolvimento de Solu��o'
        WHEN sigla = 'SEOPE' THEN 'Opera��es e Monitoramento'
        WHEN sigla = 'SESEG' THEN 'Seguran�a da Informa��o'
        WHEN sigla = 'DEREH' THEN 'Recursos Humanos'
        WHEN sigla = 'SEFOL' THEN 'Folha de Pagamento'
        WHEN sigla = 'SECAP' THEN 'Capacita��o Continuada'
    END
WHERE sigla IN ('DEPTI', 'SEDES', 'SEOPE', 'SESEG', 'DEREH', 'SEFOL', 'SECAP');


--Antes do fim do departamento SECAP

SELECT depart.sigla, depart.nome
FROM brh.departamento depart
JOIN brh.colaborador colab ON depart.sigla = colab.departamento
WHERE colab.cep = '71777-700'
AND colab.departamento IN ('SECAP', 'SESEG')
ORDER BY depart.nome;

  
--**************************************************************************************
-- 10 - Relat�rio de dependentes menores de idade
/*
Tarefa
Crie uma consulta que liste:
a matr�cula do colaborador;
o nome do dependente;
e a idade do dependente (n�o a data de nascimento)
Adicione o c�digo da consulta em sql/comandos.sql.
Regras de aceita��o
A consulta deve listar somente os colaboradores que s�o menores de idade em rela��o � data atual.
Para esta tarefa voc� precisar� usar a fun��o que pega a data e hora atual do Oracle: SYSDATE.
*/
SELECT c.matricula AS matricula_colaborador,
       d.nome AS nome_dependente,
       TRUNC(MONTHS_BETWEEN(SYSDATE, d.data_nascimento) / 12) AS idade_dependente
FROM brh.colaborador c
JOIN brh.dependente d ON c.matricula = d.colaborador
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, d.data_nascimento) / 12) < 18;


















