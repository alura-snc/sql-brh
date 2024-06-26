-- Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;
-- Ordene primeiramente pelo nome do colaborador, depois pelo nome do dependente.

select
col.nome as nome_colaborador, dp.nome as nome_dependente, extract(month from dp.data_nascimento)as mes_nascimento 
from
brh.dependente dp
inner join
brh.colaborador col
on col.matricula = dp.colaborador
where
extract(month from dp.data_nascimento) in ('4', '5', '6') or instr(dp.nome,'h') <> 0
order by col.nome, dp.nome;

-- Criar consulta que liste nome e o salário do colaborador com o maior salário;
-- A consulta deve ser flexível para continuar funcionando caso surja algum funcionário com salário maior que o do Zico.

select nome, max(salario) as salario_maximo 
from brh.colaborador
group by nome
having max(salario)>=
(
select max(salario) as salario_maximo 
from brh.colaborador
);

-- Criar uma consulta que liste a matrícula, nome, salário, e nível de senioridade do colaborador;
-- A senioridade dos colaboradores é determinada a faixa salarial:
-- Júnior: até R$ 3.000,00;
-- Pleno: R$ 3.000,01 a R$ 6.000,00;
-- Sênior: R$ 6.000,01 a R$ 20.000,00;
-- Corpo diretor: acima de R$ 20.000,00.
-- Ordene a listagem por senioridade e por nome.

select matricula, nome, salario, (case when salario > 20000 then 'Corpo Diretor' when salario > 6000 then 'Sênior'
                                    when salario > 3000 then 'Pleno' else 'Júnior' end) as senioridade
from brh.colaborador
order by salario desc, nome;

-- Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto;
-- Ordene a consulta pelo nome do departamento e nome do projeto.

select distinct
dp.nome as nome_dpto, prj.nome as nome_proj, count(col.nome) as qtde_colab
from 
brh.departamento dp
inner join
brh.colaborador col
on dp.sigla = col.departamento
inner join
brh.atribuicao at
on col.matricula = at.colaborador
inner join
brh.projeto prj
on prj.id = at.projeto
group by dp.nome, prj.nome;


