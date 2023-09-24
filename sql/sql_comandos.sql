-- inserir novo colaborador
insert into brh.papel (id, nome) values (8, 'Especialista de Negocios');
insert into brh.endereco (cep, uf, cidade, bairro) values ('85296-037', 'SP', 'Valinhos', 'Vila Nazare');
insert into brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco)
    values ('A124', 'Fulano de Tal', '001.543.876-08', '4123', 'SEDES', '85296-037', 'Rua Caio da Silveira', 'Casa 1');    
insert into brh.telefone_colaborador (colaborador, numero, tipo) values ('A124', '(19) 95896-4289', 'M');
insert into brh.telefone_colaborador (colaborador, numero, tipo) values ('A124', '(19) 3965-8542', 'R');
insert into brh.email_colaborador (colaborador, email, tipo) values ('A124', 'fulano@email.com', 'P');
insert into brh.email_colaborador (colaborador, email, tipo) values ('A124', 'fulano.tal@brh.com', 'T');
insert into brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) values ('452.637.981-65', 'A124', 'Beltrana de Tal', 'Filho(a)', to_date('2014-05-27', 'yyyy-mm-dd'));
insert into brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) values ('069.854.574-52', 'A124', 'Cicrana de Tal', 'CÃ´njuge', to_date('1976-04-16', 'yyyy-mm-dd'));
insert into brh.projeto (nome, responsavel, inicio, fim) values ('BI', 'A123', to_date('2023-09-01', 'yyyy-mm-dd'), null);
insert into brh.atribuicao (projeto, colaborador, papel) values (9, 'A124', 8);

commit;

-- Relatório de departamentos
select sigla, nome from brh.departamento order by (nome);

commit;

--Relatório de dependentes
select brh.colaborador.nome, brh.dependente.nome, brh.dependente.data_nascimento, brh.dependente.parentesco
    from brh.colaborador inner join brh.dependente on brh.colaborador.matricula = brh.dependente.colaborador;
    
commit;

--Excluir departamento SECAP
select * from brh.colaborador where departamento = 'SECAP';
delete from brh.dependente where colaborador = 'H123' or colaborador = 'M123' or colaborador = 'R123' or colaborador ='W123';
delete from brh.email_colaborador where colaborador = 'H123' or colaborador = 'M123' or colaborador = 'R123' or colaborador ='W123';
delete from brh.telefone_colaborador where colaborador = 'H123' or colaborador = 'M123' or colaborador = 'R123' or colaborador ='W123';
delete from brh.colaborador where departamento = 'SECAP';
delete from brh.departamento where sigla = 'SECAP';

commit;

-- Relatório de contatos
select brh.colaborador.nome, brh.email_colaborador.email, brh.telefone_colaborador.numero
    from brh.colaborador inner join brh.email_colaborador on brh.colaborador.matricula = brh.email_colaborador.colaborador
        inner join brh.telefone_colaborador on brh.colaborador.matricula = brh.telefone_colaborador.colaborador
            where brh.email_colaborador.tipo = 'T' and brh.telefone_colaborador.tipo = 'M'
                order by (brh.colaborador.nome);
            
commit;
  
-- Relatório analítio de equipes
-- Corrindo erro de carga de ID dos projetos
update brh.atribuicao set projeto = 5 where projeto = 1; 
update brh.atribuicao set projeto = 6 where projeto = 2; 
update brh.atribuicao set projeto = 7 where projeto = 3; 
update brh.atribuicao set projeto = 8 where projeto = 4; 

select brh.departamento.nome as "DEPARTAMENTO", brh.departamento.chefe, brh.colaborador.nome as "COLABORADOR", brh.atribuicao.projeto as "ID PROJETO", brh.projeto.nome as "NOME PROJETO",
    brh.atribuicao.papel as "ID PAPEL", brh.papel.nome as "NOME DO PAPEL", brh.telefone_colaborador.numero as "TELEFONE", brh.dependente.nome as "DEPENDENTE"
        from brh.departamento inner join brh.colaborador on brh.departamento.sigla = brh.colaborador.departamento
            inner join brh.atribuicao on brh.atribuicao.colaborador = brh.colaborador.matricula
                inner join brh.projeto on brh.projeto.id = brh.atribuicao.projeto
                    inner join brh.papel on brh.papel.id = brh.atribuicao.papel
                        inner join brh.telefone_colaborador on brh.telefone_colaborador.colaborador = colaborador.matricula
                            inner join brh.dependente on brh.dependente.colaborador = colaborador.matricula
                                order by (brh.departamento.nome), (brh.projeto.nome), (brh.colaborador.nome);

commit;
