/*Inserir novo colaborador
Cadastrar o novo colaborador Fulano de Tal no novo projeto BI para exercer o papel de Especialista de Negócios.

Informações sobre o colaborador
Possui o telefone celular (61) 9 9999-9999;
Possui o telefone residencial (61) 3030-4040;
Email pessoal é fulano@email.com;
Email de trabalho será é fulano.tal@brh.com;
Possui dois dependentes:
Filha Beltrana de Tal;
Esposa Cicrana de Tal.
Atenção
Você deve escolher os valores dos demais campos para o colaborador, dependentes e projeto;
Atenção à ordem em que os registros devem ser inseridos.*/

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

/*Atualizar cadastro de colaborador
A colaboradora Maria se casou e precisa que seus dados sejam atualizados na base.

Informações sobre o colaborador
Nome de casada: Maria Mendonça;
Email: maria.mendonca@email.com;*/

UPDATE BRH.COLABORADOR SET NOME = 'Maria Mendonça'
WHERE MATRICULA = 'M123';

UPDATE BRH.EMAIL_COLABORADOR SET EMAIL = 'maria.mendonca@email.com'
WHERE COLABORADOR = 'M123' AND TIPO = 'P';

/*Relatório de cônjuges
Crie uma consulta que liste:
matricula do colaborador;
nome do dependente;
data de nascimento do dependente.*/

SELECT COLABORADOR, NOME AS "NOME-DEPENDENTE", DATA_NASCIMENTO
FROM BRH.DEPENDENTE;

/*Relatório de contatos telefônicos
Crie uma consulta que liste:
matricula do colaborador;
número de telefone.
A consulta deve listar somente telefones móveis ou comerciais;
O resultado deve ser ordenado pela matrícula do colaborador e pelo número do telefone.*/

SELECT COLABORADOR AS "MATRICULA-COLABORADOR", NUMERO, TIPO
FROM BRH.TELEFONE_COLABORADOR
WHERE TIPO IN ('M','C')
ORDER BY "MATRICULA-COLABORADOR", NUMERO;

/*Excluir departamento SECAP
O departamento SECAP não é mais parte da nossa organização, e todos os colaboradores serão dispensados (somente para fins didáticos).
Remova o departamento SECAP da base de dados;*/
DELETE FROM BRH.DEPARTAMENTO WHERE SIGLA = 'SECAP';

/*Relatório de departamentos
Crie uma consulta que liste a sigla e o nome do departamento;
A consulta deve listar somente os colaboradores que:
morem no CEP 71777-700;
trabalhem nos departamentos SECAP ou SESEG.
O resultado da consulta deve ser ordenado pelo nome do departamento.*/
SELECT A.SIGLA, A.NOME
FROM BRH.DEPARTAMENTO A INNER JOIN BRH.COLABORADOR B
ON A.SIGLA = B.DEPARTAMENTO
WHERE (B.CEP = '71777-700') AND (B.DEPARTAMENTO IN ('SECAP','SESEG'))
ORDER BY A.NOME;

/*DESAFIO
Relatório de dependentes menores de idade
Crie uma consulta que liste:
a matrícula do colaborador;
o nome do dependente;
e a idade do dependente (não a data de nascimento)
A consulta deve listar somente os colaboradores que são menores de idade em relação à data atual. */

SELECT COLABORADOR AS "MATRICULA-COLABORADOR", NOME, TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) AS IDADE
FROM BRH.DEPENDENTE
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) < 18


/*SEMANA 3
Filtrar dependentes
Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;
Ordene primeiramente pelo nome do colaborador, depois pelo nome do dependente. */

SELECT B.NOME AS NOME_COLABORADOR, A.NOME AS NOME_DEPENDENTE, A.DATA_NASCIMENTO
FROM BRH.DEPENDENTE A INNER JOIN BRH.COLABORADOR B
ON A.COLABORADOR = B.MATRICULA
WHERE EXTRACT(Month FROM A.DATA_NASCIMENTO) IN (4,5,6) AND (A.NOME LIKE '%H%' OR A.NOME LIKE '%h%')
ORDER BY NOME_COLABORADOR, NOME_DEPENDENTE;

/*Listar colaborador com maior salário
Criar consulta que liste nome e o salário do colaborador com o maior salário;
OBS.: A consulta deve ser flexível para continuar funcionando caso surja algum funcionário com salário maior que o do Zico.*/
SELECT NOME, SALARIO
FROM BRH.COLABORADOR
WHERE SALARIO IN 
(SELECT MAX(SALARIO)
FROM BRH.COLABORADOR)

/*Relatório de senioridade
A senioridade dos colaboradores é determinada pela faixa salarial:

Júnior: até R$ 3.000,00;
Pleno: R$ 3.000,01 a R$ 6.000,00;
Sênior: R$ 6.000,01 a R$ 20.000,00;
Corpo diretor: acima de R$ 20.000,00.
Criar uma consulta que liste a matrícula, nome, salário, e nível de senioridade do colaborador;
Ordene a listagem por senioridade e por nome. */
SELECT MATRICULA, NOME, SALARIO,
(CASE
    WHEN SALARIO <= 3000 THEN 'JÚNIOR'
    WHEN SALARIO > 3000 AND SALARIO <= 6000 THEN 'PLENO'
    WHEN SALARIO > 6000 AND SALARIO <= 20000 THEN 'SÊNIOR' 
    ELSE 'CORPO DIRETOR'
END) AS SENIORIDADE
FROM BRH.COLABORADOR
ORDER BY SENIORIDADE, NOME

/*Listar quantidade de colaboradores em projetos
Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto;
Ordene a consulta pelo nome do departamento e nome do projeto. */
SELECT A.NOME AS DEPTO, C.NOME AS PROJETO, COUNT(B.MATRICULA)
FROM BRH.DEPARTAMENTO A INNER JOIN BRH.COLABORADOR B
ON A.SIGLA = B.DEPARTAMENTO INNER JOIN BRH.PROJETO C
ON C.RESPONSAVEL = B.MATRICULA
GROUP BY A.NOME, C.NOME

/*Listar colaboradores com mais dependentes
Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui;
No relatório deve ter somente colaboradores com 2 ou mais dependentes.
Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente. */
SELECT  COLAB.NOME, COUNT(DEP.CPF)
FROM BRH.COLABORADOR COLAB INNER JOIN BRH.DEPENDENTE DEP
ON COLAB.MATRICULA = DEP.COLABORADOR
GROUP BY COLAB.NOME
HAVING COUNT(DEP.CPF) >= 2
ORDER BY COUNT(DEP.CPF) DESC, COLAB.NOME

/*Listar faixa etária dos dependentes
Criar consulta que liste o CPF do dependente, o nome do dependente, a data de nascimento (formato brasileiro), 
parentesco, matrícula do colaborador, a idade do dependente e sua faixa etária;
Se o dependente tiver menos de 18 anos, informar a faixa etária Menor de idade;
Se o dependente tiver 18 anos ou mais, informar faixa etária Maior de idade;
Ordenar consulta por matrícula do colaborador e nome do dependente.*/
SELECT CPF, NOME, TO_DATE(DATA_NASCIMENTO,'DD/MM/YYYY') AS DATA_NASCIMENTO, PARENTESCO, COLABORADOR,   
        TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) AS IDADE,
(CASE
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) < 18 THEN 'MENOR DE IDADE'
    ELSE 'MAIOR DE IDADE'
END) AS FAIXA_ETARIA
FROM BRH.DEPENDENTE 
ORDER BY COLABORADOR, NOME
