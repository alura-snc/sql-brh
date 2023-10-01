UPDATE brh.atribuicao SET projeto = 5 WHERE projeto = 1;
UPDATE brh.atribuicao SET projeto = 6 WHERE projeto = 2;
UPDATE brh.atribuicao SET projeto = 7 WHERE projeto = 3;
UPDATE brh.atribuicao SET projeto = 8 WHERE projeto = 4;

COMMIT;
select * from brh.atribuicao;
select * from brh.projeto;
select * from brh.departamento;

select at.projeto, count(*) as "total" 
from brh.atribuicao at
group by projeto;

select distinct
 pj.nome, sum(at.projeto) as "total"
from
brh.atribuicao at
inner join
brh.projeto pj
on
pj.id = at.projeto
group by pj.nome
;