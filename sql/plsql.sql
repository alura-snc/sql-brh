  --- nome       : brh.insere_projeto
  --- objetivo   : cadastrar um novo projeto na base de dados
  --- historico  :
  ---
  --- data           autor           detalhamento
  --- ---------- --------------- -----------------------------------
  --- 03/10/2023   Kaplan          Construcao da procedure
create or replace procedure insere_projeto(p_nome in varchar,
                                                 p_responsavel in varchar,
                                                 p_retorno out varchar) is
  -- variaveis 
  v_data_atual   date := sysdate;

begin
  -------------------------------
  -- valida parametros de entrada
  -------------------------------
    if p_nome is null or length(p_nome) < 2  then
      p_retorno := 'Nome de projeto inválido! Deve ter dois ou mais caracteres.';
    else
        if p_responsavel is null then
           p_retorno := 'Responsável do Projeto Inválido';
		else  -- parametros validos, pode fazer o insert
               ---------------------------------------
               -- insert propriamente dito
               ---------------------------------------  
           Insert into BRH.PROJETO (NOME,RESPONSAVEL,INICIO,FIM) values (p_nome,p_responsavel,to_date(v_data_atual,'DD/MM/RR'),null);		
           p_retorno := 'Ok';
        end if;	
    end if;		

  -- log de execucao
  dbms_output.put_line(' Projeto Inserido: Nome: ' || p_nome || ' Responsavel: ' || p_responsavel || ' Inicio : ' || to_date(v_data_atual,'DD/MM/RR'));
  dbms_output.put_line(' Finalizado com sucesso');
exception
  when others then
    dbms_output.put_line(sqlerrm); -- Testes
    p_retorno := 'Falha';
end insere_projeto;
/
  --- nome       : brh.calcula_idade
  --- objetivo   : calcular a idade a partir de uma data de nascimento fornecida
  --- historico  :
  ---
  --- data           autor           detalhamento
  --- ---------- --------------- -----------------------------------
  --- 04/10/2023   Kaplan          Construcao da function

create or replace function calcula_idade ( 
p_data_nasc date) 
return number is 

  -- variaveis 
  v_retorna_idade number; 
  v_data_atual   date := sysdate;
  
begin 

  ----------------------------------------
  -- calcula idade a partir da p_data_nasc
  ----------------------------------------
select trunc(months_between(to_date(v_data_atual,'DD/MM/YYYY'),to_date(p_data_nasc,'DD/MM/YYYY'))/12,0) 
into  v_retorna_idade    		
from dual;

return v_retorna_idade; 
end calcula_idade;
/
  --- nome       : brh.finaliza_projeto
  --- objetivo   : finalizar projeto com a data corrente
  --- historico  :
  ---
  --- data           autor           detalhamento
  --- ---------- --------------- -----------------------------------
  --- 05/10/2023   Kaplan          Construcao da function
create or replace function brh.finaliza_projeto ( 
p_id_projeto number) 
return date is 

  -- variaveis 
  v_data_atual   date := sysdate;

begin 

  ----------------------------------------
  -- finaliza projeto com a data corrente
  ----------------------------------------
update projeto set fim = v_data_atual where id = p_id_projeto;

return v_data_atual; 
end finaliza_projeto;
