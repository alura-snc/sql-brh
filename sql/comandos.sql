--1 Inserir novo colaborador
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

--2 Relatorio de Departamentos
select sigla, nome from departamento

--3 Relatorio de Dependentes
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

--4 Remoção do Departamento SECAP
delete from departamento where sigla='SECAP'

--5 Relatório de Contatos
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


--6 Relatório Analítico de Equipes
select
Departamento.nome,
Departamento.chefe,
Colaborador.nome,
Projeto.nome,
Papel.nome,
telefone_colaborador.numero,
Depentende.nome
from Departamento inner join
Colaborador
on Departamento.chefe = Colaborador.matricula

--7 DESAFIO Relatório analítico de equipes

--Função para Retornar nome do Chefe do Departamento
create or replace function RetornarNomeChefeDepto(siglaDepto in varchar2)
return varchar2 
as 
    nomeChefe varchar2(255);
begin
    select
    Colaborador.nome into nomeChefe
    from Departamento inner join
    Colaborador
    on Departamento.chefe=Colaborador.matricula
    where Departamento.sigla=siglaDepto;
    return nomeChefe;
end;

-- Teste da Função para Retornar nome do Chefe do Departamento
select RetornarNomeChefeDepto('DEREH') from DUAL;

-- Relatório analítico de equipes
select 
Projeto.nome as "Nome do Projeto",
Colaborador.nome as "Nome Colaborador",
Dependente.nome as "Dependentes",
Departamento.nome as "Nome Departamento",
RetornarNomeChefeDepto(Departamento.sigla) as "Chefe do Departamento",
Papel.nome as "Papel desempenhado",
(select telefone_colaborador.numero from telefone_colaborador where tipo='R' and telefone_colaborador.colaborador = colaborador.matricula) as "Tel Residencial",
(select telefone_colaborador.numero from telefone_colaborador where tipo='C' and telefone_colaborador.colaborador = colaborador.matricula) as "Tel Comercial",
(select telefone_colaborador.numero from telefone_colaborador where tipo='M' and telefone_colaborador.colaborador = colaborador.matricula) as "Cel"
from Colaborador inner join
Departamento
on Colaborador.Departamento = Departamento.sigla 
inner join 
Atribuicao
on Colaborador.matricula = Atribuicao.colaborador
inner join 
Projeto
on Atribuicao.projeto=Projeto.id
inner join 
Papel
on Atribuicao.papel = Papel.id
inner join 
Dependente 
on Colaborador.matricula=Dependente.Colaborador
order by projeto.nome, colaborador.nome, dependente.nome






