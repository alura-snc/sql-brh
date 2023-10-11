INSERT INTO brh.COLABORADOR
(MATRICULA, CPF, NOME, SALARIO, DEPARTAMENTO, CEP, LOGRADOURO, COMPLEMENTO_ENDERECO)
VALUES
('A234', '852.258.258-88', 'Fulano de Tal',  4582, 'SEFOL', '71222-200', 'Quatro Rios', 'Casa 9');

INSERT INTO BRH.PROJETO
(ID, NOME, RESPONSAVEL, INICIO, FIM)
VALUES
('9','BI','A234',TO_DATE('05/04/2023','DD/MM/YYYY'),NULL);

INSERT INTO BRH.PAPEL
(ID, NOME)
VALUES
(8,'Especialista de Neg�cios');

INSERT INTO BRH.ATRIBUICAO
(COLABORADOR, PROJETO, PAPEL)
VALUES
('A234','9','8');

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 9 9999-9999','A234','C');

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 3030-4040','A234','R');

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano@email.com','A234','P');

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano.tal@brh.com','A234','T');

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('003.334.345-77', 'Beltrana de Tal', TO_DATE('01/04/2020','DD/MM/YYYY'),'Filho(a)', 'A234');

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('123.374.375-45', 'Cilana de Tal', TO_DATE('11/09/2020','DD/MM/YYYY'),'Filho(a)', 'A234');

SELECT SIGLA, NOME
FROM BRH.DEPARTAMENTO
ORDER BY NOME


SELECT B.NOME AS NOME_COLABORADOR, A.NOME AS NOME_DEPENDENTE, A.DATA_NASCIMENTO
FROM BRH.DEPENDENTE A INNER JOIN BRH.COLABORADOR B
ON A.COLABORADOR = B.MATRICULA
WHERE EXTRACT(Month FROM A.DATA_NASCIMENTO) IN (4,5,6) AND (A.NOME LIKE '%H%' OR A.NOME LIKE '%h%')
ORDER BY NOME_COLABORADOR, NOME_DEPENDENTE;

DELETE FROM BRH.DEPARTAMENTO WHERE SIGLA = 'SECAP';


--Filtrar dependentes
SELECT B.NOME AS NOME_COLABORADOR, A.NOME AS NOME_DEPENDENTE, A.DATA_NASCIMENTO
FROM BRH.DEPENDENTE A INNER JOIN BRH.COLABORADOR B
ON A.COLABORADOR = B.MATRICULA
WHERE EXTRACT(Month FROM A.DATA_NASCIMENTO) IN (4,5,6) AND (A.NOME LIKE '%H%' OR A.NOME LIKE '%h%')
ORDER BY NOME_COLABORADOR, NOME_DEPENDENTE;

--Listar colaborador com maior salário
SELECT NOME, SALARIO
FROM BRH.COLABORADOR
WHERE SALARIO IN 
(SELECT MAX(SALARIO)
FROM BRH.COLABORADOR)

--Relatório de senioridade
SELECT MATRICULA, NOME, SALARIO,
(CASE
    WHEN SALARIO <= 3000 THEN 'JÚNIOR'
    WHEN SALARIO > 3000 AND SALARIO <= 6000 THEN 'PLENO'
    WHEN SALARIO > 6000 AND SALARIO <= 20000 THEN 'SÊNIOR' 
    ELSE 'CORPO DIRETOR'
END) AS SENIORIDADE
FROM BRH.COLABORADOR
ORDER BY SENIORIDADE, NOME

--Listar colaboradores em projetos
-- O RESULTADO NÃO FICOU IGUAL AO DA IMAGEM DO TRELLO.
CREATE VIEW VW_DEPTO_COLABORADOR AS
SELECT DEP.NOME AS NOME_DEPTO, DEP.SIGLA AS SIGLA, COLAB.MATRICULA AS MATRICULA_COLABORADOR
FROM BRH.DEPARTAMENTO DEP INNER JOIN BRH.COLABORADOR COLAB
ON DEP.SIGLA = COLAB.DEPARTAMENTO

SELECT VW.NOME_DEPTO, PROJ.NOME AS NOME_PROJETO, COUNT(VW.MATRICULA_COLABORADOR)
FROM BRH.PROJETO PROJ INNER JOIN VW_DEPTO_COLABORADOR VW
ON PROJ.RESPONSAVEL = VW.MATRICULA_COLABORADOR
GROUP BY VW.NOME_DEPTO, PROJ.NOME

--Listar colaboradores com mais dependentes
SELECT  COLAB.NOME, COUNT(DEP.CPF)
FROM BRH.COLABORADOR COLAB INNER JOIN BRH.DEPENDENTE DEP
ON COLAB.MATRICULA = DEP.COLABORADOR
GROUP BY COLAB.NOME
HAVING COUNT(DEP.CPF) >= 2
ORDER BY COUNT(DEP.CPF) DESC, COLAB.NOME

--Listar faixa etária dos dependentes
SELECT CPF, NOME, TO_DATE(DATA_NASCIMENTO,'DD/MM/YYYY') AS DATA_NASCIMENTO, PARENTESCO, COLABORADOR,   
        TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) AS IDADE,
(CASE
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) < 18 THEN 'MENOR DE IDADE'
    ELSE 'MAIOR DE IDADE'
END) AS FAIXA_ETARIA
FROM BRH.DEPENDENTE 
ORDER BY COLABORADOR, NOME

--Crie a procedure brh.insere_projeto para cadastrar um novo projeto na base de dados:
--Parâmetros da procedure:
--Nome do projeto: varchar com nome do novo projeto.
--Resposável do projeto: varchar com a matrícula do colaborador responsável.
CREATE OR REPLACE PROCEDURE brh.insere_projeto
(p_NOME IN BRH.PROJETO.NOME%type, p_RESPONSAVEL IN BRH.PROJETO.RESPONSAVEL%type)
IS
BEGIN
    INSERT INTO BRH.PROJETO (NOME, RESPONSAVEL, INICIO) VALUES (p_NOME, p_RESPONSAVEL, SYSDATE);
END;

--Criar função calcula_idade
--Crie a function brh.calcula_idade, que informa a idade a partir de uma data:
--Parâmetros da function:
--Data: date com a data de referência para calcular a idade.
--Retorno da function:
--Deve retornar um número inteiro com a idade.
--Utilize a função MONTHS_BETWEEN para calcular a idade.
CREATE OR REPLACE FUNCTION brh.calcula_idade
(p_DATA DATE)
RETURN INT
IS
v_IDADE INT;
BEGIN
    v_IDADE := TRUNC(MONTHS_BETWEEN(SYSDATE, p_DATA) / 12);
    RETURN v_IDADE;
END;

SELECT brh.calcula_idade('26/04/1986') FROM DUAL
