group by co.nome;

select
cpf, nome, to_char(data_nascimento, 'dd/mm/yyy') as "Data_nascimento", parentesco, colaborador, trunc(months_between(sysdate,data_nascimento)/12) as "idade",
(case when months_between(sysdate,data_nascimento)/12 < 18 then 'Menor de idade'
      when months_between(sysdate,data_nascimento)/12 >=18  then 'Maior de idade' end) as Faixa_etaria
from
brh.dependente;

