INSERT INTO BRH.ENDERECO (cep, uf, cidade, bairro)
VALUES
('02401-200','SP','SÃ£o Paulo','Santana');

INSERT INTO BRH.COLABORADOR (matricula, cpf, nome, salario, departamento, cep,
logradouro, complemento_endereco) 
VALUES 
('A124','335.578.528.06','fulano de tal',580.55,'DEPTI','02401-200','Rua VoluntÃ¡rios da PÃ¡tria','Senac');

INSERT INTO BRH.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES
('(61) 9 9999-9999','A124','M');

INSERT INTO BRH.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES
('(61) 3030-4040','A124','R');

INSERT INTO BRH.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES
('fulano@email.com','A124','P');

INSERT INTO BRH.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES
('fulano.tal@brh.com','A124','T');

INSERT INTO BRH.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES
('236.254.875-55','Beltrana de Tal','02/02/2022','Filho(a)','A124');

INSERT INTO BRH.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES
('005.275.852-98','Cicrana de Tal','01/08/1785','CÃƒÂ´njuge','A124');

INSERT INTO BRH.PROJETO (nome,responsavel, inicio, fim) --ID GERADO AUTOMÃ?TICAMENTE
VALUES
('BI','B123','01/09/2023','12/12/2023');

INSERT INTO BRH.PAPEL (nome) --ID GERADO AUTOMÃ?TICAMENTE
VALUES
('Especialista de NegÃ³cios');

INSERT INTO BRH.ATRIBUICAO (colaborador, projeto,papel)
VALUES
('A124',9,8);

--Consulta da sigla e nome do departamento ordernando por nome do departamento

SELECT sigla, nome as "NOME DO DEPARTAMENTO" FROM BRH.DEPARTAMENTO ORDER BY (nome);

--Consulta do nome do colaborador, nome do dependente do colaborador, data de nacimento do dependente e parentesco

SELECT C.nome AS "NOME DO COLABORADOR", D.nome AS "NOME DO DEPENDENTE",
D.data_nascimento AS "DATA DE NASCIMENTO DO DEPENDENTE", D.parentesco  
FROM BRH.COLABORADOR C JOIN BRH.DEPENDENTE D ON  D.COLABORADOR = C.MATRICULA
order by c.nome, d.nome;

--Removendo registro das tabelas Colaboradores e Departamentos e relacionamentos

DELETE (SELECT * FROM BRH.DEPENDENTE D JOIN BRH.COLABORADOR C 
ON D.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP'); 

DELETE (SELECT * FROM BRH.EMAIL_COLABORADOR E JOIN BRH.COLABORADOR C 
ON E.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP');

DELETE (SELECT * FROM BRH.TELEFONE_COLABORADOR T JOIN BRH.COLABORADOR C 
ON T.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP');

DELETE FROM BRH.COLABORADOR WHERE departamento = 'SECAP';  
    
DELETE FROM BRH.DEPARTAMENTO WHERE SIGLA = 'SECAP';

--Criando uma consulta que liste o nome do Colaborador, email de trabalho do Colaborador e telefone celular do Colaborador, e ordenado pelo nome do colaborador.

SELECT C.nome AS "NOME DO COLABORADOR", E.Email AS "EMAIL COORPORATIVO", T.numero
AS "CELULAR" FROM BRH.COLABORADOR C 
JOIN BRH.EMAIL_COLABORADOR E ON  E.COLABORADOR = C.MATRICULA AND E.TIPO = 'T'
JOIN BRH.TELEFONE_COLABORADOR T ON T.COLABORADOR = C.MATRICULA AND T.TIPO = 'M'
ORDER BY (C.NOME);

-- Crie uma consulta que liste:
    --O nome do Departamento;
    --O nome do chefe do Departamento;
    --O nome do Colaborador;
    --O nome do Projeto que ele está alocado;
    --O nome do papel desempenhado por ele;
    --O número de telefone do Colaborador;
    --O nome do Dependente do Colaborador.
    --ordenado pelo nome do nome do projeto, nome do colaborador e nome do dependente.

SELECT 
    D.NOME AS DEPARTAMENTO, 
    CF.NOME AS "CHEFE DO DEPARTAMENTO", 
    C.NOME AS COLABORADOR,
    P.NOME AS "NOME DO PROJETO",
    PL.NOME AS "PAPEL DO COLABORADOR",
    T.NUMERO AS "TELEFONE DO COLABORADOR",
    DC.NOME AS "DEPENDENTE DO COLABORADOR"
FROM BRH.DEPARTAMENTO D
INNER JOIN
    BRH.COLABORADOR C ON C.DEPARTAMENTO = D.SIGLA
INNER JOIN
    BRH.COLABORADOR CF ON CF.MATRICULA = D.CHEFE  AND CF.DEPARTAMENTO = D.SIGLA
INNER JOIN
    BRH.ATRIBUICAO A ON A.COLABORADOR = C.MATRICULA
INNER JOIN
    BRH.PROJETO P ON P.ID = A.PROJETO
INNER JOIN
    BRH.PAPEL PL ON PL.ID = A.PAPEL
INNER JOIN
    BRH.TELEFONE_COLABORADOR T ON T.COLABORADOR = C.MATRICULA
INNER JOIN
    BRH.DEPENDENTE DC ON DC.COLABORADOR = C.MATRICULA
WHERE
    T.TIPO ='M'
ORDER BY P.NOME,C.NOME,DC.NOME;

-- ============================================================================================================

-- CODIGOS 3ª SEMANA


-- Criando consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome. 
-- Ordenando pelo nome do colaborador, depois pelo nome do dependente

SELECT 
    C.NOME AS COLABORADOR, 
    D.NOME AS DEPENDETE,
    D.DATA_NASCIMENTO AS "DATA DE NASCIMENTO"
FROM BRH.DEPENDENTE D
    INNER JOIN 
        BRH.COLABORADOR C ON C.MATRICULA = D.COLABORADOR       
WHERE
   (LOWER (D.NOME)) LIKE '%h%' OR
   EXTRACT(MONTH from D.DATA_NASCIMENTO) BETWEEN 4 and 6
ORDER BY C.NOME, D.NOME;


--___________________________________________________________________________________________________________


-- Criando consulta que liste nome e o salário do colaborador com o maior salário.

SELECT
    NOME AS COLABORADOR,
    SALARIO
FROM
    BRH.COLABORADOR
WHERE
    SAlARIO = (SELECT MAX(SALARIO) FROM BRH.COLABORADOR);

--___________________________________________________________________________________________________________

-- Criando uma consulta que liste a matrícula, nome, salário, e nível de senioridade do colaborador.
-- Ordenando a listagem por senioridade e por nome.

SELECT
    MATRICULA,
    NOME AS COLABORADOR,
    SALARIO AS SALÁRIO,
    CASE 
        WHEN SALARIO <= 3000 THEN 'JUNIOR'
        WHEN SALARIO BETWEEN 3000.01 AND 6000 THEN 'PLENO'
        WHEN SALARIO BETWEEN 6000.01 AND 20000 THEN 'SÊNIOR'
        ELSE 'CORPO DIRETOR'
    END AS SENIORIDADE  
FROM
    BRH.COLABORADOR
ORDER BY SENIORIDADE, NOME;


--___________________________________________________________________________________________________________


-- Criando consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto
-- Ordenando a consulta pelo nome do departamento e nome do projeto

SELECT
    D.NOME AS DEPARTAMENTO,
    P.NOME AS PROJETO,
    COUNT(*) AS "QUANTIDADE DE COLABORADORES"
FROM
    BRH.DEPARTAMENTO D
INNER JOIN
    BRH.COLABORADOR C ON C.DEPARTAMENTO = D.SIGLA
INNER JOIN
    BRH.ATRIBUICAO A ON A.COLABORADOR = C.MATRICULA
INNER JOIN
    BRH.PROJETO P ON P.ID = A.PROJETO
GROUP BY 
    D.NOME, P.NOME
ORDER BY 
    D.NOME, P.NOME;
    

--___________________________________________________________________________________________________________
    
-- Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui;
-- No relatório deve ter somente colaboradores com 2 ou mais dependentes.
-- Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente

SELECT 
    C.NOME,
    COUNT(*) AS "QUANTIDADE DE DEPENDENTES"
FROM
    BRH.DEPENDENTE D
INNER JOIN
    BRH.COLABORADOR C ON D.COLABORADOR = C.MATRICULA
GROUP BY 
    C.NOME
HAVING (COUNT(*)) >= 2
ORDER BY
   "QUANTIDADE DE DEPENDENTES" DESC, C.NOME;


    







