/*Inserir novo colaborador
Fulano de Tal no novo projeto BI para exercer o papel de Especialista de Negócios.

Informações sobre o colaborador
Possui o telefone celular (61) 9 9999-9999;
Possui o telefone residencial (61) 3030-4040;
Email pessoal é fulano@email.com;
Email de trabalho será é fulano.tal@brh.com;
Possui dois dependentes:
Filha Beltrana de Tal;
Esposa Cicrana de Tal.
Atenção
Você deve escolher os valores dos demais campos para o colaborador, dependentes e projeto;
Atenção à ordem em que os registros devem ser inseridos.*/

select * from brh.endereco

INSERT INTO brh.endereco 
(cep, uf, cidade, bairro) 
VALUES 
('04050-002', 'SP', 'Sao Paulo', 'Vila Guarani');

select * from brh.papel

INSERT INTO brh.papel 
(id, nome)
VALUES
('8', 'Especialista de Negócios')

select * from brh.colaborador

INSERT INTO brh.colaborador
(matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco)
VALUES
('X999', 'Fulano de Tal', '123.456.789-00', 1500, 'SECAP', '04050-002', 'Avenida Arvore', '254 bloco 3');

select * from brh.projeto

INSERT INTO brh.projeto 
(id, nome, responsavel, inicio, fim) 
VALUES 
(5, 'BI', 'H123', to_date('2024-03-24', 'yyyy-mm-dd'), null);

select * from brh.dependente

INSERT INTO brh.dependente
(cpf, nome, data_nascimento, parentesco, colaborador ) 
VALUES 
('123.456.789-02', 'Beltrana de Tal', to_date('2022-05-15', 'yyyy-mm-dd'), 'Filho(a)', 'X999');

INSERT INTO brh.dependente
(cpf, nome, data_nascimento, parentesco, colaborador ) 
VALUES 
('014.258.369-09', 'Cicrana de Tal', to_date('1985-02-15', 'yyyy-mm-dd'), 'CÃ´njuge', 'X999');

select * from brh.telefone_colaborador

INSERT INTO brh.telefone_colaborador
(numero, colaborador, tipo)
VALUES
('(61) 9 9999-9999', 'X999', 'M')

INSERT INTO brh.telefone_colaborador
(numero, colaborador, tipo)
VALUES
('(61) 3030-4040', 'X999', 'R')

select * from brh.email_colaborador

INSERT INTO brh.email_colaborador
(email, colaborador, tipo)
VALUES
('fulano@email.com', 'X999', 'P')

INSERT INTO brh.email_colaborador
(email, colaborador, tipo)
VALUES
('fulano.tal@brh.com', 'X999', 'T')

SELECT * FROM brh.atribuicao

INSERT INTO brh.atribuicao
(projeto, colaborador, papel) 
VALUES 
('5', 'X999', '8')

/*Atualizar cadastro de colaborador
Maria casou e precisa que seus dados sejam atualizados na base.
Informações sobre o colaborador
Nome de casada: Maria Mendonça;
Email: maria.mendonca@email.com;
Tarefa
Atualize os dados da Maria; */

SELECT * FROM brh.colaborador

UPDATE brh.colaborador
set nome = 'Maria Mendonça'
where
matricula = 'M123'

SELECT * FROM brh.email_colaborador

UPDATE brh.email_colaborador
set email = 'maria.mendonca@email.com'
where
colaborador = 'M123'
AND
tipo = 'P'

COMMIT

/*Relatório de cônjuges
Crie uma consulta que liste:
matricula do colaborador;
nome do dependente;
data de nascimento do dependente.
Regras de aceitação
A consulta deve listar somente os dependentes que são Cônjuge.*/

SELECT * FROM brh.dependente;

SELECT colaborador 
AS "MATRÍCULA DO COLABORADOR", nome 
AS "NOME DO DEPENDENTE", data_nascimento 
AS "DATA DE NASCIMENTO" 
FROM brh.dependente 
WHERE parentesco = 'CÃ´njuge';

/*Relatório de contatos telefônicos
Crie uma consulta que liste:
matricula do colaborador;
número de telefone.
Regras de aceitação
A consulta deve listar somente telefones móveis ou comerciais;
O resultado deve ser ordenado pela matrícula do colaborador e pelo número do telefone.*/

SELECT * FROM brh.telefone_colaborador

SELECT colaborador
AS "MATRÍCULA DO COLABORADOR", numero 
AS "NÚMERO DE TELEFONE" 
FROM brh.telefone_colaborador 
WHERE tipo = 'M' OR tipo = 'C' ORDER BY colaborador ASC, numero ASC;

/*Excluir departamento SECAP
O departamento SECAP não é mais parte da nossa organização
todos os colaboradores serão dispensados (somente para fins didáticos).
Tarefa: Remova o departamento SECAP da base de dados;*/

SELECT * FROM brh.colaborador
WHERE departamento = 'SECAP'; /*H123, M123, R123, W123, X999*/

SELECT * FROM brh.telefone_colaborador 
WHERE colaborador = 'H123' 
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999';

DELETE FROM brh.telefone_colaborador 
WHERE colaborador = 'H123' 
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999'; 

SELECT * FROM brh.email_colaborador 
WHERE colaborador = 'H123' 
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999'; 

DELETE FROM brh.email_colaborador 
WHERE colaborador = 'H123' 
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999'; 

SELECT * FROM brh.dependente 
WHERE colaborador = 'H123' 
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999'

DELETE FROM brh.dependente 
WHERE colaborador = 'H123'
OR colaborador = 'M123' OR colaborador = 'R123' OR colaborador = 'W123' OR colaborador = 'X999';

SELECT * FROM brh.departamento 
WHERE sigla = 'SECAP'; 

DELETE FROM brh.departamento 
WHERE sigla = 'SECAP'; 

SELECT * FROM brh.colaborador 
WHERE departamento = 'SECAP';

SELECT * FROM brh.projeto
WHERE responsavel = 'H123'; 

DELETE FROM brh.projeto 
WHERE responsavel = 'H123'; 

SELECT * FROM brh.colaborador 
WHERE departamento = 'SECAP';

DELETE FROM brh.colaborador 
WHERE departamento = 'SECAP'; 

/*Relatório de departamentos
Crie uma consulta que liste a sigla e o nome do departamento;
Regras de aceitação: A consulta deve listar somente os colaboradores que:
1. morem no CEP 71777-700;
2. trabalhem nos departamentos SECAP ou SESEG.
O resultado da consulta deve ser ordenado pelo nome do departamento.*/

SELECT * FROM brh.departamento

SELECT * FROM brh.colaborador

SELECT brh.departamento.sigla 
AS "SIGLA DO DEPARTAMENTO", brh.departamento.nome 
AS "NOME DO DEPARTAMENTO" 
FROM brh.departamento 
JOIN brh.colaborador 
ON brh.departamento.sigla = brh.colaborador.departamento 
WHERE brh.colaborador.cep = '71777-700' 
AND (brh.departamento.sigla = 'SECAP' OR brh.departamento.sigla = 'SESEG');

/*DESAFIO
Relatório de dependentes menores de idade
Crie uma consulta que liste:
a matrícula do colaborador;
o nome do dependente;
e a idade do dependente (não a data de nascimento)
Regras de aceitação
A consulta deve listar somente os colaboradores que são menores de idade em relação à data atual.
Dica: usar a função que pega a data e hora atual do Oracle: SYSDATE.
A função MONTHS_BETWEEN também pode te ajudar a chegar no resultado esperado.

TRUNC
Trunca uma data, hora ou carimbo de data/hora para a parte especificada. 
Sintaxe TRUNC( <date_or_time_expr>, <date_or_time_part> )

MONTH: arredonda para o início do mês
DAY: arredonda para o início do dia
HOUR: arredonda para o início da hora
MINUTE: arredonda para o início do minuto

FIM ATIVIDADES SEMANA 2*/

SELECT * FROM brh.dependente;
SELECT * FROM brh.colaborador;

SELECT colaborador 
AS "MATRÍCULA DO COLABORADOR", nome 
AS "NOME DO DEPENDENTE", 
TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento)/12) 
AS "IDADE" FROM brh.dependente;


