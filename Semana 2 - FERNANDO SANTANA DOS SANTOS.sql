///ADICIONAR PAPEL///

SELECT * FROM brh.papel;
INSERT INTO brh.papel (id,nome) VALUES (8,'product_owner');

///ADICIONAR ENDEREÇO///

SELECT * FROM brh.endereco;
INSERT INTO brh.endereco (cep,uf,cidade,bairro) VALUES ('71777-700','SP','SAMPA','SANTO AMARO');

///ADICIONANDO COLABORADOR///

SELECT * FROM brh.colaborador;
INSERT INTO brh.colaborador (matricula,cpf,nome,salario,departamento,cep,logradouro,complemento_endereco) VALUES ('Y001','123.456.789-00','JOHN','12345','DEPTI','12345-678','NEBRASKA','AP20');

///ADICIONANDO TELEFONE COLABORADOR///

SELECT * FROM brh.telefone_colaborador;
INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(11) 7777-8888','Y001','M');
INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(11) 3030-4040','Y002','F');

///ADICIONANDO EMAIL COLABORADOR///

SELECT * FROM brh.email_colaborador;
INSERT INTO brh.email_colaborador (email, colaborador, tipo) VALUES ('fulano@email.com','Y001','P');
INSERT INTO brh.email_colaborador (email, colaborador, tipo) VALUES ('fulano.tal@brh.com','Y002','T');

///ADICIONAR DEPENDENTE///

SELECT * FROM brh.dependente;
INSERT INTO brh.dependente (cpf,nome,data_nascimento,parentesco,colaborador) VALUES ('123.456.789-01','Beltrana de Tal',to_date('2009-07-01', 'yyyy-mm-dd'),'Filho(a)','Y001');
INSERT INTO brh.dependente (cpf,nome,data_nascimento,parentesco,colaborador) VALUES ('123.456.789-02','Ciclana de Tal',to_date('1990-05-05', 'yyyy-mm-dd'),'Conjuge','Y001');

///CADASTRAR PROJETO///

SELECT * FROM brh.projeto;
INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) VALUES (5,'BI','Y001',to_date('2024-03-02','yyyy-mm-dd'),null);

///ATRIBUINDO PROJETO AO COLABORADOR///

SELECT * FROM brh.atribuicao;
INSERT INTO brh.atribuicao (colaborador, projeto, papel) VALUES ('Y001',3,5);

///ATUALIZANDO CADASTRO COLABORADOR///

SELECT * FROM brh.colaborador WHERE nome LIKE '%MARIA%';
UPDATE brh.colaborador SET nome = ' MARIA MENDONÇA' WHERE matricula = 'Y003';
SELECT * FROM brh.email_colaborador WHERE email LIKE '%maria%';
UPDATE brh.email_colaborador SET email = 'maria.mendonca@email.com' WHERE colaborador = 'Y003' AND tipo = 'P'; 
UPDATE brh.email_colaborador SET email = 'maria.mendonca@corporativo.com' WHERE colaborador = 'Y003' AND tipo = 'T'; 

///RELATÓRIO DE CONJUGE///

SELECT * FROM brh.dependente;
SELECT colaborador AS "MATRÍCULA DO COLABORADOR", nome AS "NOME DO DEPENDENTE", data_nascimento AS "DATA DE NASCIMENTO" FROM brh.dependente WHERE parentesco = 'CONJUGE';

///RELATÓRIO DE TELEFÔNICOS///

SELECT * FROM brh.telefone_colaborador;
SELECT colaborador AS "MATRÍCULA DO COLABORADOR", numero AS "NÚMERO DE TELEFONE" FROM brh.telefone_colaborador WHERE tipo = 'M' OR tipo = 'C' ORDER BY colaborador ASC, numero ASC;

///EXCLUIR DEP E COLABORADOR DO DEP///

SELECT * FROM brh.colaborador WHERE departamento = 'SECAP'; 
SELECT * FROM brh.telefone_colaborador WHERE colaborador = 'Y004' OR colaborador = 'J004' OR colaborador = 'K004' OR colaborador = 'S004'; 
DELETE FROM brh.telefone_colaborador WHERE colaborador = 'Y004' OR colaborador = 'J004' OR colaborador = 'K004' OR colaborador = 'S004'; 
SELECT * FROM brh.email_colaborador WHERE colaborador = 'Y004' OR colaborador = 'J004'' OR colaborador = 'K004'' OR colaborador = 'S004'; 
DELETE FROM brh.email_colaborador WHERE colaborador = 'Y004' OR colaborador = 'J004' OR colaborador = 'K004' OR colaborador = 'S004'; 
SELECT * FROM brh.dependente WHERE colaborador = 'Y004' OR colaborador = 'J004' OR colaborador = 'K004' OR colaborador = 'S004'; 
DELETE FROM brh.dependente WHERE colaborador ='Y004' OR colaborador = 'J004' OR colaborador = 'K004' OR colaborador = 'S004';
SELECT * FROM brh.departamento WHERE sigla = 'SECAP'; 
DELETE FROM brh.departamento WHERE sigla = 'SECAP'; 
SELECT * FROM brh.colaborador WHERE departamento = 'SECAP';
DELETE FROM brh.colaborador WHERE departamento = 'SECAP'; 

///RELATÓRIO DE DEPARTAMENTO///

SELECT * FROM brh.departamento;
SELECT * FROM brh.colaborador;
SELECT brh.departamento.sigla AS "SIGLA DO DEPARTAMENTO", brh.departamento.nome AS "NOME DO DEPARTAMENTO" 
FROM brh.departamento JOIN brh.colaborador ON brh.departamento.sigla = brh.colaborador.departamento 
WHERE brh.colaborador.cep = '71777-700' AND (brh.departamento.sigla = 'SECAP' OR brh.departamento.sigla = 'SESEG');