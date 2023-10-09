--SPRINT#4
--Criar procedure Insere_projeto

create or replace procedure sp_inserirProjeto(
p_nomeProjeto in projeto.nome%type,
p_responsavelProjeto in projeto.responsavel%type,
p_inicioProjeto in projeto.inicio%type)
is
begin
insert into projeto(nome,responsavel,inicio)
values (p_nomeProjeto,p_responsavelProjeto,p_inicioProjeto);
end;

execute sp_inserirProjeto('Saúde PMSP','11122',to_date('07/11/2023','DD/MM/YYYY'));
commit;

--Criar função calcula_idade

create or replace function fc_calcularIdade(p_data in date)
return numeric
is
v_idade integer;
begin
select TRUNC(months_between(SYSDATE, p_data)/12,0) into v_idade from dual;
return v_idade;
end;

select fc_calcularidade(to_date('9/10/1979','DD/MM/YYYY')) as "IDADE" from dual;

--Criar função finaliza_projeto 
create or replace function fc_finalizarProjeto(p_idProjeto in projeto.id%type)
return projeto.fim%type
is
v_dataFinalizacao projeto.fim%type;
begin
v_dataFinalizacao:=sysdate;
update projeto
set fim=v_datafinalizacao
where id=p_idProjeto;
return v_datafinalizacao;
end;

set serveroutput on
declare
v_dataEncerramentoProjeto varchar2(16);
begin
v_dataEncerramentoProjeto:= to_char(fc_finalizarProjeto(27),'DD/MM/YYYY HH:MI');
dbms_output.put_line(v_dataencerramentoprojeto);
commit;
end;



