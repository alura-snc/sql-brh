--Inserir novo colaborador
select * from papel 
insert into PAPEL (id,nome)
values (8,'Especialista de Negócios');

select * from endereco
insert into colaborador 
(matricula, cpf,nome,salario,departamento,cep,logradouro,complemento_endereco)
values
('11122','11122233344','Fulano de Tal',8000.00,'DEPTI','71777-700','Rua das Margaridas',
'122 ap13');

insert into projeto (id,nome,responsavel,inicio,fim)
values (1,'BI','11122','20/10/2023','20/11/2023');

insert into telefone_colaborador(numero,colaborador,tipo)
values ('61999999999','11122','C');
insert into telefone_colaborador(numero,colaborador,tipo)
values ('6130304040','11122','R');

insert into email_colaborador(email,colaborador,tipo)
values ('fulano@email.com','11122','P');
insert into email_colaborador(email,colaborador,tipo)
values ('fulano.tal@brh.com','11122','T');

insert into dependente (cpf,nome,data_nascimento,parentesco, colaborador)
values('22233344455','Beltrana de Tal','01/01/2010','Filho(a)','11122');
insert into dependente (cpf,nome,data_nascimento,parentesco, colaborador)
values('33333344455','Cicrana de Tal','23/07/1970','CÃ´njuge','11122');

insert into atribuicao (colaborador,projeto,papel)
values ('11122',1,8);

--Relatorio de Departamentos
select sigla, nome from departamento

--Relatorio de Dependentes
select 
Colaborador.nome,
Dependente.nome,
Dependente.data_nascimento,
Dependente.parentesco
from colaborador
inner join
dependente
on Colaborador.matricula = Dependente.colaborador
order by Colaborador.nome, Dependente.nome 

--Remoção do Departamento SECAP
delete from departamento where sigla='SECAP'

--Relatório de Contatos
select 
colaborador.nome,
email_colaborador.email as "E-mail profissional",
telefone_colaborador.numero as "Celular"
from colaborador
inner join email_colaborador
on colaborador.matricula = email_colaborador.colaborador
inner join telefone_colaborador
on colaborador.matricula=telefone_colaborador.colaborador
where email_colaborador.tipo = 'T' and telefone_colaborador.tipo='M'
order by Colaborador.nome
