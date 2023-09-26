
select nome, data_nascimento, to_char(data_nascimento,' month') from brh.dependente
where(extract(month from data_nascimento)>=4 and extract(month from data_nascimento)<=6 )or( nome like '%h%' or nome like 'H%');

select nome, salario from brh.colaborador
order by salario desc;



select
co.matricula, co.nome, co.salario,
(case when co.salario <= 3000 then 'Junior'
      when co.salario >= 3001 and co.salario <=6000 then 'Pleno'
      when co.salario >= 6001 and co.salario <=20000 then 'Senior'
      when co.salario > 20000 then 'Corpo diretor' end) as senioridade
from 
brh.colaborador co
order by senioridade, co.nome;


-- precisa atualizar a tabela pois os indices estão diferentes
-- atribuica de 1 a 5 e projeto de 6 a 9


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

select co.nome, count(dp.nome) as "quantidade_dependentes"
from 
brh.colaborador co
inner join
brh.dependente dp
on co.matricula = dp.colaborador
group by co.nome;


select
cpf, nome, to_char(data_nascimento, 'dd/mm/yyy') as "Data_nascimento", parentesco, colaborador, trunc(months_between(sysdate,data_nascimento)/12) as "idade",
(case when months_between(sysdate,data_nascimento)/12 < 18 then 'Menor de idade'
      when months_between(sysdate,data_nascimento)/12 >=18  then 'Maior de idade' end) as Faixa_etaria
from
brh.dependente;




















