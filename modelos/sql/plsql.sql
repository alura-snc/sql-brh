--Procedure insere_projeto
create procedure brh.insere_projeto(
p_nome in brh.projeto.nome %type,
p_responsavel in brh.projeto.responsavel %type)
is
begin insert into brh.projeto(nome, responsavel, inicio)
values (p_nome, p_responsavel, sysdate);
end;

execute brh.insere_projeto('Projeto Senac', 'U123')
commit

--function calcula_idade
create or replace function brh.calcula_idade
(p_data IN DATE)
return number
is
    v_idade NUMBER;
begin
    v_idade := trunc(months_between(sysdate, p_data) / 12);
    return v_idade;
end;
-----
select nome, brh.calcula_idade(data_nascimento) as idade
from brh.dependente;
