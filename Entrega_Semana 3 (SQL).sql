--1. Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;
SELECT *
FROM
    brh.colaborador 

INNER JOIN
    brh.dependente 

ON
    d.colaborador = c.matricula
WHERE
    to_char(d.data_nascimento, 'MM') IN ( '04', '05', '06' )
    OR d.nome LIKE '%h%'
ORDER BY 
    c.nome, d.nome;
    
--2. Criar consulta que liste nome e o salário do colaborador com o maior salário;
SELECT
    c.nome, c.salario
FROM
    brh.colaborador 
WHERE
    c.salario IN ( SELECT MAX(c.salario) FROM brh.colaborador  );

    
--3. Criar uma consulta que liste a matrícula, nome, salário, e nível de senioridade do colaborador;
SELECT c.matricula, c.nome, c.salario, 

(CASE WHEN c.salario <= 3000 THEN 'JUNIOR'
    
      WHEN c.salario >3000 AND c.salario <=6000 THEN 'PLENO'
      WHEN c.salario >6000 AND c.salario <=20000 THEN 'SÊNIOR'
    
      ELSE 'CORPO DIRETOR' END) AS "SENIORIDADE"

FROM brh.colaborador 
ORDER BY SENIORIDADE, c.nome;


--4. Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto;
SELECT
    d.nome AS nome_departamento, p.nome AS nome_projeto, COUNT(c.matricula) AS quantidade_colaborador
    
FROM brh.departamento 
    INNER JOIN brh.colaborador  ON d.sigla = c.departamento
    INNER JOIN brh.atribuicao  ON c.matricula = a.colaborador
    INNER JOIN brh.projeto ON a.projeto = p.id

GROUP BY
    d.nome,
    p.nome

ORDER BY
   nome_departamento,
   nome_projeto;


--5. Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui;
SELECT 
    c.nome AS "Nome Colaborador", COUNT(d.cpf) AS "Quantidade de Dependente"

FROM brh.colaborador 
INNER JOIN brh.dependente 
ON c.matricula = d.colaborador

GROUP BY c.nome
HAVING COUNT(d.cpf) >= 2
ORDER BY COUNT(d.cpf) DESC, c.nome;
