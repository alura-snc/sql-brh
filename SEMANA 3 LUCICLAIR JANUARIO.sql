Semana 3 
Filtrar dependentes
Tarefa:
select c.nome as nome_ colaborador, d.nome as nome_dependente, 
 extract (month from data_nascimento), data_nascimento
from brh.colaborador c
brh.dependente d
 on  c.matricula = d.colaborador
where data_nascimento  =  ‘A123’
Where extract (month from data_nascimento) in (4,5,6)
or 
d.nome like ‘%h’
 lower (d.nome) like ‘%h%’
ou 
-- Upper (d.nome) like ‘%H%’
Order by c.nome, d. nome

Listar colaborador com maior salário
Tarefa:
select * from brh.colaborador

select max (salario), min (salario), sum(salario), avg (salario)
from brh.colaborador
select *
from brh.colaborador
Where salario = 49944 
OU
where salario = (select max(salario) from brh.colaborador)
OU
select nome, salario
from brh.colaborador
where salrio = (select max(salario), brh.colaborador

Relatório de senioridade
Tarefa:
select nome, salario, 
case when salario <= 3000 then ‘Junior’ 
            when salario > 3000 and salario <= 6000 ‘Pleno’
            when salario > 6000 and salario <= 20000 ‘Senior’
            else ‘ Corpo Diretor’
end as nivel
from brh.colaborador
order by 3,1

Listar colaboradores em projetos
Tarefa:
select *
d.nome as nome_departamento, 
OU
d.nome as nome_departamento, p.nome as nome_projeto,, count(*)
--- Count (*)
--c.nome as nome _colaboarador
from brh.departamento d
inner Join brh.colaborador c
on d.sigla = c.departamento
inner Join brh.atribuicao a 
on c.matricula = a.colaborador 
group by d.nome
inner join brh.projeto p
on a.projeto = p.id

