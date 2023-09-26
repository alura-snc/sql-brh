
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




