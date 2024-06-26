-- FILTRAR DEPENDENTE
SELECT a.nome as nome_colaborador, b.nome as nome_dependente, 
b.data_nascimento
FROM system.colaborador a
INNER JOIN system.dependente b
ON a.matricula = b.colaborador
WHERE (EXTRACT(MONTH FROM b.data_nascimento) IN (4,5,6)
AND LOWER (b.nome) LIKE '%h%')
ORDER BY a.nome, b.nome

-- LISTAR COLABORADOR COM MAIOR SALARIO
SELECT nome, salario
FROM system.colaborador
WHERE SALARIO = (SELECT MAX(salario) FROM system.colaborador)

-- RELATORIO DE SENIORIDADE
SELECT matricula, nome, salario,
CASE WHEN salario <= 3000 THEN 'Junior'
     WHEN salario > 3000 AND salario <= 6000 THEN 'Pleno' 	
     WHEN salario > 6000 AND salario <= 20000 THEN 'Senior'
     ELSE 'Corpo Diretor' END AS nivel
FROM system.colaborador
ORDER BY 4,2

-- LISTAR COLABORADOR EM PROJETOS
SELECT d.nome as nome_departamento, p.nome as nome_projeto,
COUNT (*)
FROM system.departamento d
INNER JOIN system.colaborador c
  ON d.sigla = c.departamento
INNER join system.atribuicao a
  ON c.matricula = a.colaborador
INNER join system.projeto p
  ON a.projeto = p.id
GROUP BY d.nome, p.nome

-- LISTAR COLABORAORES COM MAIS DEPENDENTES
SELECT * FROM
(SELECT a.nome as nome_colaborador,COUNT(*) AS qtd_dependente
FROM system.colaborador a
INNER JOIN system.dependente b
  ON a.matricula = b.colaborador
GROUP BY a.nome)
WHERE qtd_dependente >1

-- LISTAR FAIXA ETÁRIA DOS DEPENDENTES
SELECT cpf, nome,
to_char(data_nascimento,'dd/mm/yyyy') as Data_Nascimento,
parentesco, colaborador,
trunc (months_between(sysdate,data_nascimento)/12) as idade,
case when trunc (months_between(sysdate,data_nascimento)/12) < 18 then 'Menor de idade'
else 'Maior de idade'
end as faixa_etaria
from system.dependente
order by colaborador, nome

-- PAGINAR LISTAGEM DE COLABORADORES 

SELECT nome -- Página 1 (primeiros 10 colaboradores)
FROM system.colaborador
ORDER BY nome
OFFSET 0 ROWS
FETCH NEXT 10 ROWS only

SELECT nome -- Página 2 (próximos 10 colaboradores)
FROM system.colaborador
ORDER BY nome
OFFSET 10 ROWS
FETCH NEXT 10 ROWS only

SELECT nome -- Página 3 (últimos 6 colaboradores)
FROM system.colaborador
ORDER BY nome
OFFSET 20 ROWS
FETCH NEXT 6 ROWS only


-- RELATORIO DE PLANO DE SAUDE
SELECT nome_colaborador, (contribuicao_senioridade + COALESCE(contribuicao_dependente,0)) AS mensalidade
FROM 
(
SELECT
c.nome AS nome_colaborador, salario,
CASE
    WHEN salario <= 3000 THEN (0.01 * salario)
    WHEN salario > 3000 and salario <= 6000 THEN (0.02 * salario)
    WHEN salario < 6000 and salario <= 20000 THEN (0.03 * salario)
    ELSE (0.05 * salario) 
END AS contribuicao_senioridade, contribuicao_dependente
from system.colaborador c
LEFT JOIN(

SELECT
colaborador AS matricula, --trunc(months_between(sysdate,data_nascimento)/12) as idade, parentesco
SUM(CASE WHEN TRUNC(months_between(sysdate,data_nascimento)/12) < 18 
    and parentesco = ('Filho(a)')THEN 25
    WHEN TRUNC(months_between(sysdate,data_nascimento)/12) >= 18 
    and parentesco = ('Filho(a)') THEN 50
    ELSE 100
END) AS contribuicao_dependente
FROM system.dependente
GROUP BY colaborador

) d
on c.matricula = d.matricula
);




-- LISTA COLABORADORES QUE PARTICIPAM DE TODOS OS PROJETOS
WITH total_projetos AS (
    SELECT COUNT(*) AS total_projetos FROM system.projeto
),
colaboradores_projetos AS (
    SELECT
        matricula,
        nome AS nome_colaborador,
        COUNT(DISTINCT atrib.projeto) AS total_projetos_colaborador
    FROM
        system.colaborador
        INNER JOIN system.atribuicao atrib ON matricula = atrib.colaborador
    GROUP BY
        matricula, nome
)
SELECT
    nome_colaborador,
    matricula
FROM
    colaboradores_projetos
    CROSS JOIN total_projetos
WHERE
    total_projetos_colaborador = total_projetos
ORDER BY
    nome_colaborador;

