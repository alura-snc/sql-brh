--filtrar dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome
SELECT A.nome as nome_colaborador, B.nome as nome_dependente, B.data_nascimento, extract (month from B.data_nascimento) 
from brh.colaborador A
inner join brh.dependente B
on A.matricula = B.colaborador
where (extract(month from B.data_nascimento) in (4,5,6)
or lower (b.nome) like '%h%');

COMMIT

-- listar colaborador com maior sal�rio
SELECT nome, salario FROM brh.colaborador 
WHERE salario = (SELECT MAX(salario) from brh.colaborador);

COMMIT

-- relat�rio de senioridade
SELECT matricula, nome, salario,
(CASE WHEN salario <= 3000 then 'J�nior'
     WHEN salario <=6000 then 'Pleno'
     WHEN salario > 6000 and salario <=20000 then 'Senior'
     else 'Corpo Diretivo' end) as nivel
FROM brh.colaborador ORDER BY 4,2;

COMMIT

--listar colaboradores em projetos
SELECT* FROM brh.departamento;
SELECT* FROM brh.colaborador;
SELECT* FROM brh.atribuicao;
SELECT* FROM brh.projeto;

select d.nome as nome_departamento, p.nome as nome_projeto, 
count (*) 
from brh.departamento d
inner join brh.colaborador c
 on d.sigla = c.departamento
inner join brh.atribuicao a
 on c.matricula = a.colaborador
inner join brh.projeto p
 on a.projeto = p.id
group by d.nome, p.nome

COMMIT

--Listar colaboradores com mais dependentes
SELECT* FROM brh.colaborador;
SELECT* FROM brh.dependente;

select a.nome as nome_colaborador, count (*) as qtd_dependente
FROM brh.colaborador a
INNER JOIN brh.dependente b
ON A.MATRICULA = B.COLABORADOR
group by a.nome
having count (*) >1
order by count (*) desc, a.nome

COMMIT

--Listar faixa et�ria dos dependentes

SELECT* FROM brh.dependente;

select cpf, nome,
to_char (data_nascimento,'dd/mm/yyyy') as data_de_nascimento, 
parentesco, colaborador, 
trunc (months_between (sysdate,data_nascimento)/12) as idade,
case when trunc(months_between(sysdate,data_nascimento)/12) < 18 then 'Menor de idade'
    else 'Maior de idade'
end as faixa_etaria
from brh.dependente
order by 5,2

COMMIT


