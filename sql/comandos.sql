-- Inserir novo colaborador

INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco)
    VALUES ('AA123', 'Catarina', '222.333.444-55', '10000', 'DEPTI', '71111-100', 'Avenida das Pirambóias', 'Apto 233');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo)
    VALUES ('AA123', '(61) 9 9999-9999', 'M');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo)
    VALUES ('AA123', '(61) 3030-4040', 'R');

INSERT INTO brh.email_colaborador (colaborador, email, tipo)
    VALUES ('AA123', 'catarina@email.com', 'P');

INSERT INTO brh.email_colaborador (colaborador, email, tipo)
    VALUES ('AA123', 'catarina.cat@brh.com', 'T');

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
    VALUES ('123.123.123-44', 'AA123', 'Melissa', 'Filho(a)', to_date('2020-01-01', 'yyyy-mm-dd'));

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
    VALUES ('124.124.124-44', 'AA123', 'Samantha', 'Cônjuge', to_date('1980-01-01', 'yyyy-mm-dd'));

INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de Negócios');

INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'BI', 'AA123', to_date('2023-01-01', 'yyyy-mm-dd'), null);

INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'AA123', 8);


-- Atualizar cadastro de colaborador

-- Checar como está o registro antes da mudança
SELECT nome FROM brh.colaborador
	WHERE matricula = 'M123';
SELECT email FROM brh.email_colaborador
	WHERE colaborador = 'M123';

-- Alterar o nome do colaborador
UPDATE brh.colaborador
	SET nome = 'Maria Mendonça'
	WHERE matricula = 'M123';

-- Alterar o e-mail do colaborador
UPDATE brh.email_colaborador
	SET email = 'maria.mendonca@email.com'
	WHERE colaborador = 'M123' AND tipo = 'P';

-- Checar como ficou o registro após a mudança
SELECT nome FROM brh.colaborador
	WHERE matricula = 'M123';
SELECT email FROM brh.email_colaborador
	WHERE colaborador = 'M123';


-- Relatório de cônjuges

SELECT colaborador AS matricula , nome, data_nascimento FROM brh.dependente
	WHERE parentesco = 'Cônjuge';


-- Relatório de contatos telefônicos

SELECT colaborador AS matricula, numero FROM brh.telefone_colaborador
	WHERE tipo <> 'R'
	ORDER BY colaborador, numero;


-- Excluir departamento SECAP

-- Checando os colaboradores que vão ser dispensados
SELECT * FROM brh.colaborador
    WHERE departamento = 'SECAP';

-- Excluíndo registros de contatos
DELETE FROM brh.telefone_colaborador
	WHERE colaborador IN (
	SELECT * FROM brh.colaborador
    	WHERE departamento = 'SECAP');
DELETE FROM brh.email_colaborador
	WHERE colaborador IN (
	SELECT * FROM brh.colaborador
    	WHERE departamento = 'SECAP');
DELETE FROM brh.dependente
	WHERE colaborador IN (
	SELECT * FROM brh.colaborador
    	WHERE departamento = 'SECAP');

-- Excluindo os registros dos colaboradores dispensados
DELETE FROM brh.colaborador
	WHERE departamento = 'SECAP';

-- Excluindo o registro do departamento extinto
DELETE FROM brh.departamento
	WHERE sigla = 'SECAP';

-- Checando se os registros foram excluídos
SELECT * FROM brh.colaborador
    WHERE departamento = 'SECAP';


-- Relatório de departamentos

SELECT departamento AS sigla, nome FROM brh.colaborador
	WHERE cep = '71777-700' AND departamento IN ('SECAP', 'SESEG')
	ORDER BY departamento;
