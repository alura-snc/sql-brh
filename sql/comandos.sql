-- Aluno: Richard Kaplan
--
--Cadastrar o novo colaborador Fulano de Tal no novo projeto BI para exercer o papel de Especialista de Negócios.
--Informações sobre o colaborador
--Possui o telefone celular (61) 9 9999-9999;
--Possui o telefone residencial (61) 3030-4040;
--Email pessoal é fulano@email.com;
--Email de trabalho será é fulano.tal@brh.com;
--Possui dois dependentes:
--Filha Beltrana de Tal;
--Esposa Cicrana de Tal.
--Atenção
--Você deve escolher os valores dos demais campos para o colaborador, dependentes e projeto;
--Atenção à ordem em que os registros devem ser inseridos.
--
-- Carga do colaborador Fulano de Tal
INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('A1234', 'Fulano de Tal', '123.456.270-86', '48666', 'DIR', '71111-100', 'Avenida das Castanheiras', 'Casa 1');
/
-- Carga dos telefones do colaborador Fulano de Tal
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A1234', '(61) 9 9999-9999', 'C'); -- celular
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A1234', '(61) 3030-4040', 'R'); -- residencial
/
-- Carga dos emails do colaborador Fulano de Tal
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('A1234', 'fulano@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('A1234', 'fulano.tal@brh.com', 'T');
/
-- Carga dos dependentes do colaborador Fulano de Tal
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('123.456.789-12', 'A1234', 'Filha Beltrana de Tal', 'Filho(a)', to_date('2012-08-23', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('234.567.890-12', 'A1234', 'Esposa Cicrana de Tal', 'Cônjuge', to_date('1979-03-09', 'yyyy-mm-dd'));
/
-- Carga do projeto BI
INSERT INTO brh.projeto (nome, responsavel, inicio, fim) VALUES ('BI', 'A1234', to_date('2023-09-21', 'yyyy-mm-dd'), null);
/
-- Carga do papel desempenhado pelo colaborador Fulano de Tal
INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de Negócios'); 
-- Carga da atribuição do papel do colaborador Fulano de Tal
INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (9, 'A1234', 8);
/
COMMIT;
/
-- Crie uma consulta que liste a sigla e o nome do departamento
-- O resultado da consulta deve ser ordenado pelo nome doo departamento.
select sigla, nome from brh.departamento order by nome;
/
-- Crie uma consulta que liste:
-- nome do colaborador;
-- nome do dependente;
-- data de nascimento do dependente;
-- parentesco do dependente.
-- O resultado deve ser ordenado pelo nome do colaborador e pelo nome do dependente.
select t1.nome, t2.nome, t2.data_nascimento, t2.parentesco from brh.colaborador t1
inner join brh.dependente t2 on t1.matricula = t2.colaborador
order by t1.nome, t2.nome
/
-- O departamento SECAP não é mais parte da nossa organização, e todos os colaboradores serão dispensados
-- (somente para fins didáticos).
-- Atenção à ordem em que os registros devem ser removidos.
delete from brh.atribuicao 
where colaborador in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.dependente
where colaborador in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.email_colaborador
where colaborador in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.telefone_colaborador
where colaborador in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.projeto
where responsavel in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.departamento
where chefe in (select matricula from brh.colaborador where departamento = 'SECAP');
/
delete from brh.colaborador where departamento = 'SECAP'
/
delete from brh.departamento where sigla = 'SECAP'
/
COMMIT;
/
--Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;
select * 
 from dependente
where  nome like '%h%'
  and extract (month from data_nascimento) in (4,5,6)
;
/
-- Criar consulta que liste nome e o salário do colaborador com o maior salário;
-- OBS.: A consulta deve ser flexível para continuar funcionando caso surja algum funcionário com salário maior que o do Zico.
select * from colaborador
where salario = (select max(salario) as max_salario from colaborador)
;
-- A senioridade dos colaboradores é determinada a faixa salarial:
-- Júnior: até R$ 3.000,00;
-- Pleno: R$ 3.000,01 a R$ 6.000,00;
-- Sênior: R$ 6.000,01 a R$ 20.000,00;
-- Corpo diretor: acima de R$ 20.000,00.
-- Ordene a listagem por senioridade e por nome.
select t.matricula,
       t.nome,
       t.salario, 
       case
           when t.salario <= 3000
                then 'júnior'
           when t.salario > 3000 and t.salario <= 6000
               then 'pleno'
           when t.salario > 6000 and t.salario <= 20000
                then 'sênior'    
           else 'corpo diretor'
       end  senioridade
   from colaborador t
order by 4, 2;
/
-- Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto;
-- Ordene a consulta pelo nome do departamento e nome do projeto.
select  c.nome as nome_departamento, d.nome as nome_projeto, count(1) quantidade_colaboradores
  from atribuicao a, colaborador b, departamento c, projeto d
where a.colaborador = b.matricula
  and b.departamento = c.sigla
  and a.projeto = d.id
group by c.nome, d.nome
order by c.nome, d.nome
;
