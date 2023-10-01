select
co.matricula, co.nome, co.salario,
(case when co.salario <= 3000 then 'Junior'
      when co.salario >= 3001 and co.salario <=6000 then 'Pleno'
      when co.salario >= 6001 and co.salario <=20000 then 'Senior'
      when co.salario > 20000 then 'Corpo diretor' end) as senioridade
from 
brh.colaborador co
order by senioridade, co.nome;