---1 - insert
INSERT INTO  papel (id, nome) VALUES (8, 'Especialista de Negócios');
select * from papel;

 ------2 - insert -------
INSERT INTO  projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'BI', 'D123', to_date('2024-01-01', 'yyyy-mm-dd'), to_date('2024-12-31', 'yyyy-mm-dd'));
select * from projeto;
  
 ------3 - insert ------- ok
 INSERT INTO  endereco (cep, uf, cidade, bairro) VALUES ('82222-200', 'GO', 'GOIAS', 'Águas Limpa');
 select * from endereco;
  
 ------4 departamento - insert ------- 
INSERT INTO  colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('A124', 'Fulano de Tal', '487.685.380-97', '58666', 'DEPDT', '82222-200', 'Avenida das Oliveiras', 'Casa 1');
select * from colaborador where matricula='A124';
------5 - insert -------  
INSERT INTO  departamento (sigla, nome, chefe, departamento_superior) VALUES ('DEPDT', 'Departamento de Desenvolvimento Tecnologico', 'A124', 'DIR');
select * from departamento where sigla='DEPDT'
 ------6 - insert ------- 
INSERT INTO  email_colaborador (colaborador, email, tipo) VALUES ('A124', 'fulano.tal@brh.com', 'T');
INSERT INTO  email_colaborador (colaborador, email, tipo) VALUES ('A124', 'fulano@email.com', 'P');
select * from email_colaborador where colaborador='A124';
------7 - insert ------- 
INSERT INTO  telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 99999-9999', 'M');
INSERT INTO  telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 3030-4040', 'R');
select * from telefone_colaborador where colaborador='A124';

------8 - insert ------- 
INSERT INTO  dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('154.472.662-78', 'A124', 'Filha Beltrana de Tal', 'Filho(a)', to_date('2006-10-27', 'yyyy-mm-dd'));
INSERT INTO  dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('065.372.562-78', 'A124', 'Esposa Cicrana de Tal', 'Cônjuge', to_date('1980-10-27', 'yyyy-mm-dd'));
select * from dependente where colaborador='A124'
------8 - insert ------- 

commit 


---relatórios--Departamentos--

select sigla, nome from departamento  order by nome

---relatórios--Dependentes--

select c.nome as Colaborador, d.nome as Dependente, d.data_nascimento as Data_Nascimento, d.parentesco from colaborador c
inner join dependente d on c.matricula=d.colaborador
order by d.nome

---Excluir--Departamento SECAP--

select c.departamento,c.nome as Colaborador, d.nome as Dependente, d.data_nascimento as Data_Nascimento, d.parentesco from colaborador c
inner join dependente d on c.matricula=d.colaborador
where c.departamento='SECAP'
order by d.nome

--select matricula from colaborador where departamento='SECAP'

select * from dependente where colaborador in (select matricula from colaborador where departamento='SECAP')


---Excluir Dependente do Colaborador
delete dependente where colaborador in (select matricula from colaborador where departamento='SECAP')


-------Excluir Telefone e email do Colaborador

--select * from telefone_colaborador where colaborador in (select matricula from colaborador where departamento='SECAP')
delete telefone_colaborador where colaborador in (select matricula from colaborador where departamento='SECAP')

--select * from email_colaborador where colaborador in (select matricula from colaborador where departamento='SECAP')
delete email_colaborador where colaborador in (select matricula from colaborador where departamento='SECAP')

-----deletar colaborador----
--select * from  colaborador where departamento='SECAP'

delete  colaborador where departamento='SECAP'

------deletar departamento---------
select * from departamento where sigla='SECAP'
delete from departamento where sigla='SECAP'

commit

------relatório colaborador e contatos

select c.nome NOME, tc.numero TELEFONE,ec.email EMAIL
 from colaborador c 
 inner join telefone_colaborador tc on c.matricula=tc.colaborador
 inner join email_colaborador ec on c.matricula=ec.colaborador
order by c.nome


------Relatório Desafio --------------


SELECT 
p.nome NOME_PROJETO,
pe.nome NOME_PAPEL,
c.nome NOME_COLABORADOR,
de.nome NOME_DEPENDENTE,
d.nome NOME_DEPARTAMENTO,
d.chefe CHEFE_DEPARTAMENTO,
tc.numero TELEFONE_COLABORADOR

FROM atribuicao a 
inner join colaborador c on a.colaborador=c.matricula
inner join departamento d on c.matricula=d.chefe
inner join telefone_colaborador tc on c.matricula=tc.colaborador
inner join dependente de on c.matricula=de.colaborador
inner join projeto p on a.projeto=p.id 
inner join papel pe on a.papel=pe.id
order by p.nome ,c.nome ,de.nome 
