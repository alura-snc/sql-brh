alter session set "_ORACLE_SCRIPT"=true;

// Inser��o  de novo colaborador

SELECT * FROM BRH.COLABORADOR;

SELECT * FROM BRH.ENDERECO;

INSERT INTO BRH.ENDERECO
    (CEP, UF,CIDADE, BAIRRO)
VALUES
('71124-261', 'SP', 'Osasco', 'Bela Vista');


INSERT INTO BRH.COLABORADOR
(MATRICULA, CPF, NOME, SALARIO, DEPARTAMENTO, CEP, LOGRADOURO, COMPLEMENTO_ENDERECO)
VALUES
('A124', '325.358.328-58', 'Fulano de Tal', 2967, 'SEOPE', '71124-261', 'Rua do Exercicio', 'Casa 4');

SELECT * FROM BRH.DEPENDENTE;

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('556.584.487-54','Beltrana de Tal', '23/07/2022', 'Filho(a)','A124');

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('145.584.457-54','Cicrana de Tal', '13/09/2076', 'Cônjuge','A124');


SELECT * FROM BRH.EMAIL_COLABORADOR;

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano@email.com','A124', 'P');

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano.tal@brh.com','A124', 'T');

SELECT * FROM BRH.TELEFONE_COLABORADOR;

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 9 9999-9999','A124', 'C');

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 3030-4040','A124', 'R');


SELECT * FROM BRH.PAPEL;

INSERT INTO BRH.PAPEL
(ID, NOME)
VALUES
(8, 'Especialista de Neg�cios');

SELECT * FROM BRH.PROJETO;

INSERT INTO BRH.PROJETO
(ID, NOME, RESPONSAVEL, INICIO, FIM)
VALUES
(9, 'BI', 'A124', '23/09/2023','');

SELECT * FROM BRH.ATRIBUICAO;

INSERT INTO BRH.ATRIBUICAO
(COLABORADOR, PROJETO, PAPEL)
VALUES
('A124', 9, 8);

//Consulta listando sigla e nome do departamento ordenada pela ordem alfab�tica dos depsrtamentos

SELECT NOME, SIGLA FROM BRH.DEPARTAMENTO WHERE NOME >'A';

// Consulta listando: nome do colaborador; nome do dependente; data de nascimento do dependente; parentesco do dependente.
// Resultado ordenado pelo nome do colaborador e pelo nome do dependente.

SELECT BRH.COLABORADOR.NOME, BRH.DEPENDENTE.NOME, BRH.DEPENDENTE.DATA_NASCIMENTO, BRH.DEPENDENTE.PARENTESCO
FROM BRH.COLABORADOR
FULL JOIN BRH.DEPENDENTE
ON BRH.COLABORADOR.MATRICULA = BRH.DEPENDENTE.COLABORADOR
WHERE BRH.COLABORADOR.NOME >'A' AND BRH.DEPENDENTE.NOME >'A';

//EXCLUINDO REGISTROS DE DEPENDENTES DE COLABORADORES DEMITIDOS
SELECT * FROM BRH.DEPENDENTE;

DELETE  FROM BRH.DEPENDENTE WHERE BRH.DEPENDENTE.COLABORADOR = 'W123';
DELETE  FROM BRH.DEPENDENTE WHERE BRH.DEPENDENTE.COLABORADOR = 'R123';
DELETE  FROM BRH.DEPENDENTE WHERE BRH.DEPENDENTE.COLABORADOR = 'M123';
DELETE  FROM BRH.DEPENDENTE WHERE BRH.DEPENDENTE.COLABORADOR = 'H123';

//EXCLUINDO REGISTROS DE EMAIL DE COLABORADORES DEMITIDOS
DELETE  FROM BRH.EMAIL_COLABORADOR WHERE BRH.EMAIL_COLABORADOR.COLABORADOR = 'W123';
DELETE  FROM BRH.EMAIL_COLABORADOR WHERE BRH.EMAIL_COLABORADOR.COLABORADOR = 'R123';
DELETE  FROM BRH.EMAIL_COLABORADOR WHERE BRH.EMAIL_COLABORADOR.COLABORADOR = 'M123';
DELETE  FROM BRH.EMAIL_COLABORADOR WHERE BRH.EMAIL_COLABORADOR.COLABORADOR = 'H123';

//EXCLUINDO REGISTROS DE TELEFONE DE COLABORADORES DEMITIDOS
DELETE  FROM BRH.TELEFONE_COLABORADOR WHERE BRH.TELEFONE_COLABORADOR.COLABORADOR = 'W123';
DELETE  FROM BRH.TELEFONE_COLABORADOR WHERE BRH.TELEFONE_COLABORADOR.COLABORADOR = 'R123';
DELETE  FROM BRH.TELEFONE_COLABORADOR WHERE BRH.TELEFONE_COLABORADOR.COLABORADOR = 'M123';
DELETE  FROM BRH.TELEFONE_COLABORADOR WHERE BRH.TELEFONE_COLABORADOR.COLABORADOR = 'H123';

// Excluindo registros de colaboradores associados ao departamento SECAP
DELETE FROM brh.colaborador WHERE departamento = 'SECAP';

// Excluindo o departamento SECAP
DELETE FROM brh.departamento WHERE sigla = 'SECAP';

//Criando um relat�rio de contatos

SELECT brh.colaborador.nome, brh.email_colaborador.email, brh.telefone_colaborador.numero
FROM brh.colaborador
LEFT JOIN brh.email_colaborador ON brh.colaborador.matricula = brh.email_colaborador.colaborador AND brh.email_colaborador.tipo = 'T'
LEFT JOIN brh.telefone_colaborador ON brh.colaborador.matricula = brh.telefone_colaborador.colaborador AND brh.telefone_colaborador.tipo = 'C'
WHERE brh.email_colaborador.email IS NOT NULL OR brh.telefone_colaborador.numero IS NOT NULL
ORDER BY brh.colaborador.nome;

// Criando um relat�rio anal�tico da equipe
SELECT
    DEP.NOME AS Nome_Departamento,
    COL_CHEFE.NOME AS Nome_Chefe_Departamento,
    COL.NOME AS Nome_Colaborador,
    PROJ.NOME AS Nome_Projeto,
    PAPEL.NOME AS Nome_Papel,
    TELEFONE.NUMERO AS Numero_Telefone,
    DEPENDENTE.NOME AS Nome_Dependente
FROM BRH.DEPARTAMENTO DEP
JOIN BRH.COLABORADOR COL_CHEFE ON DEP.CHEFE = COL_CHEFE.MATRICULA
JOIN BRH.COLABORADOR COL ON DEP.SIGLA = COL.DEPARTAMENTO
JOIN BRH.PROJETO PROJ ON COL_CHEFE.MATRICULA = PROJ.RESPONSAVEL
JOIN BRH.ATRIBUICAO ATR ON COL.MATRICULA = ATR.COLABORADOR
JOIN BRH.PAPEL PAPEL ON ATR.PAPEL = PAPEL.ID
LEFT JOIN BRH.TELEFONE_COLABORADOR TELEFONE ON COL.MATRICULA = TELEFONE.COLABORADOR AND TELEFONE.TIPO = 'C'
LEFT JOIN BRH.DEPENDENTE DEPENDENTE ON COL.MATRICULA = DEPENDENTE.COLABORADOR
ORDER BY PROJ.NOME, COL.NOME, DEPENDENTE.NOME;

// Corre��o de inconsist�ncia de carga:
UPDATE brh.atribuicao SET projeto = 5 WHERE projeto = 1;
UPDATE brh.atribuicao SET projeto = 6 WHERE projeto = 2;
UPDATE brh.atribuicao SET projeto = 7 WHERE projeto = 3;
UPDATE brh.atribuicao SET projeto = 8 WHERE projeto = 4;

// Consultas listando os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;

SELECT *
FROM BRH.DEPENDENTE
WHERE (TO_CHAR(DATA_NASCIMENTO, 'MM') IN ('04', '05', '06')) OR (INSTR(NOME, 'h') > 0);

//Consulta listando nome e o sal�rio do colaborador com o maior sal�rio;
SELECT NOME, SALARIO
FROM BRH.COLABORADOR
WHERE SALARIO = (SELECT MAX(SALARIO) FROM BRH.COLABORADOR);

//Relat�rio de senioridade
SELECT
    MATRICULA,
    NOME,
    SALARIO,
    CASE
        WHEN SALARIO <= 3000 THEN 'J�nior'
        WHEN SALARIO <= 6000 THEN 'Pleno'
        WHEN SALARIO <= 20000 THEN 'S�nior'
        ELSE 'Corpo diretor'
    END AS SENIORIDADE
FROM BRH.COLABORADOR;


//Listar colaboradores em projetos
SELECT
    DEP.NOME AS Nome_Departamento,
    PROJ.NOME AS Nome_Projeto,
    Quantidade_Colaboradores
FROM (
    SELECT
        DEP.SIGLA,
        PROJ.ID,
        COUNT(COL.MATRICULA) AS Quantidade_Colaboradores
    FROM BRH.DEPARTAMENTO DEP
    CROSS JOIN BRH.PROJETO PROJ
    LEFT JOIN BRH.COLABORADOR COL ON DEP.SIGLA = COL.DEPARTAMENTO
    LEFT JOIN BRH.ATRIBUICAO ATR ON COL.MATRICULA = ATR.COLABORADOR AND ATR.PROJETO = PROJ.ID
    GROUP BY DEP.SIGLA, PROJ.ID
) Resultados
JOIN BRH.DEPARTAMENTO DEP ON Resultados.SIGLA = DEP.SIGLA
JOIN BRH.PROJETO PROJ ON Resultados.ID = PROJ.ID
WHERE Quantidade_Colaboradores > 0
ORDER BY DEP.NOME, PROJ.NOME;

//Lista com nome do colaborador e a sua quantidade de dependentes
SELECT
    C.NOME AS Nome_Colaborador,
    COUNT(D.COLABORADOR) AS Quantidade_Dependentes
FROM BRH.COLABORADOR C
LEFT JOIN BRH.DEPENDENTE D ON C.MATRICULA = D.COLABORADOR
GROUP BY C.NOME
HAVING COUNT(D.COLABORADOR) >= 2
ORDER BY Quantidade_Dependentes DESC, Nome_Colaborador ASC;

//Lista de faixa et�ria de dependentes
SELECT
    D.CPF AS CPF_Dependente,
    D.NOME AS Nome_Dependente,
    TO_CHAR(D.DATA_NASCIMENTO, 'DD/MM/YYYY') AS Data_Nascimento_Brasil,
    D.PARENTESCO,
    D.COLABORADOR AS Matricula_Colaborador,
    CASE
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM D.DATA_NASCIMENTO) < 18 THEN 'Menor de idade'
        ELSE 'Maior de idade'
    END AS Faixa_Etaria
FROM BRH.DEPENDENTE D
ORDER BY D.COLABORADOR, D.NOME;

//Paginar listagem de colaboradores
SELECT NOME
FROM (
    SELECT 
        NOME, 
        ROW_NUMBER() OVER (ORDER BY NOME) AS RN
    FROM BRH.COLABORADOR
)
WHERE RN > 10 AND RN <= 20;

// Relat�rio de plano de sa�de
SELECT
    COL.MATRICULA AS Matricula,
    COL.NOME AS Nome_Colaborador,
    COL.SALARIO AS Salario,
    CASE
        WHEN COL.SALARIO <= 3000 THEN 'J�nior'
        WHEN COL.SALARIO <= 6000 THEN 'Pleno'
        WHEN COL.SALARIO <= 20000 THEN 'S�nior'
        ELSE 'Corpo diretor'
    END AS Nivel_Senioridade,
    (COL.SALARIO * 
        CASE
            WHEN COL.SALARIO <= 3000 THEN 0.01
            WHEN COL.SALARIO <= 6000 THEN 0.02
            WHEN COL.SALARIO <= 20000 THEN 0.03
            ELSE 0.05
        END
    + SUM(
        CASE
            WHEN DEP.PARENTESCO = 'C�njuge' THEN 100
            WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM DEP.DATA_NASCIMENTO) >= 18 THEN 50
            WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM DEP.DATA_NASCIMENTO) < 18 THEN 25
            ELSE 0
        END
    )) AS Mensalidade_Total
FROM
    BRH.COLABORADOR COL
LEFT JOIN
    BRH.DEPENDENTE DEP ON COL.MATRICULA = DEP.COLABORADOR
GROUP BY
    COL.MATRICULA, COL.NOME, COL.SALARIO
ORDER BY
    COL.NOME;

//Colaboradores que participam de todos os projetos
SELECT DISTINCT COL.MATRICULA, COL.NOME
FROM BRH.COLABORADOR COL
WHERE NOT EXISTS (
    SELECT P.ID
    FROM BRH.PROJETO P
    WHERE NOT EXISTS (
        SELECT A.PROJETO
        FROM BRH.ATRIBUICAO A
        WHERE A.COLABORADOR = COL.MATRICULA AND A.PROJETO = P.ID
    )
);





