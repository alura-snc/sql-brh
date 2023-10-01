group by pj.nome
;

select co.nome, count(dp.nome) as "quantidade_dependentes"
from 
brh.colaborador co
inner join