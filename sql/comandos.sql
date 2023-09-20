--Inserir novo colaborador
insert into papel (id,nome)
values (1,'Especialista de Negócios');

insert into departamento (sigla, nome)
values ('01.TI','Tecnologia da Informação');

insert into colaborador 
(matricula, cpf,nome,salario,departamento,cep,logradouro,complemento_endereco)
values
('11122','11122233344',8000.00,'01.TI','11075777','Rua das Margaridas',
'122 ap13');

insert into endereco (cep,uf,cidade,bairro)
values ('11075777','SP','Santos','Ponta da Praia');

insert into projeto (id,nome,responsavel,inicio,fim)
values (1,'BI','11122','20/10/2023','20/11/2023');

insert into telefone_colaborador(numero,colaborador,tipo)
values ('61999999999','11122','celular');
insert into telefone_colaborador(numero,colaborador,tipo)
values ('6130304040','11122','residencial');

insert into email_colaborador(email,colaborador,tipo)
values ('fulano@email.com','11122','pessoal');
insert into email_colaborador(email,colaborador,tipo)
values ('fulano.tal@brh.com','11122','trabalho');

insert into dependente (cpf,nome,data_nascimento,parentesco, colaborador)
values('22233344455','Beltrana de Tal','01/01/2010','filha','11122');
insert into dependente (cpf,nome,data_nascimento,parentesco, colaborador)
values('33333344455','Cicrana de Tal','23/07/1970','esposa','11122');
