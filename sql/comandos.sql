INSERT INTO colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
    VALUES ('AA123', 'Catarina', '222.333.444-55', '10000', 'DEPTI', '71111-100', 'Avenida das Pirambóias', 'Apto 233');

INSERT INTO telefone_colaborador (colaborador, numero, tipo) 
    VALUES ('AA123', '(61) 9 9999-9999', 'M');

INSERT INTO telefone_colaborador (colaborador, numero, tipo) 
    VALUES ('AA123', '(61) 3030-4040', 'R');

INSERT INTO email_colaborador (colaborador, email, tipo) 
    VALUES ('AA123', 'catarina@email.com', 'P');

INSERT INTO email_colaborador (colaborador, email, tipo) 
    VALUES ('AA123', 'catarina.cat@brh.com', 'T');

INSERT INTO dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
    VALUES ('123.123.123-44', 'AA123', 'Melissa', 'Filho(a)', to_date('2020-01-01', 'yyyy-mm-dd'));

INSERT INTO dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
    VALUES ('124.124.124-44', 'AA123', 'Samantha', 'Cônjuge', to_date('1980-01-01', 'yyyy-mm-dd'));

INSERT INTO papel (id, nome) VALUES (8, 'Especialista de Negócios');

INSERT INTO projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'BI', 'AA123', to_date('2023-01-01', 'yyyy-mm-dd'), null);

INSERT INTO atribuicao (projeto, colaborador, papel) VALUES (5, 'AA123', 8);

SELECT nome FROM colaborador 
	WHERE matricula = 'M123';

SELECT email FROM email_colaborador 
	WHERE colaborador = 'M123';

UPDATE colaborador 
	SET nome = 'Maria Mendonça' 
	WHERE matricula = 'M123';

UPDATE email_colaborador 
	SET email = 'maria.mendonca@email.com' 
	WHERE colaborador = 'M123' AND tipo = 'P';

SELECT nome FROM colaborador 
	WHERE matricula = 'M123';

SELECT email FROM email_colaborador 
	WHERE colaborador = 'M123';

SELECT colaborador AS matricula , nome, data_nascimento FROM dependente 
	WHERE parentesco = 'Cônjuge';

SELECT colaborador AS matricula, numero FROM telefone_colaborador 
	WHERE tipo <> 'R' 
	ORDER BY colaborador, numero;

SELECT * FROM colaborador 
    WHERE departamento = 'SECAP';

DELETE FROM telefone_colaborador 
	WHERE colaborador IN ( 
	SELECT * FROM colaborador 
    	WHERE departamento = 'SECAP');

DELETE FROM email_colaborador 
	WHERE colaborador IN ( 
	SELECT * FROM colaborador 
    	WHERE departamento = 'SECAP');

DELETE FROM dependente 
	WHERE colaborador IN ( 
	SELECT * FROM colaborador 
    	WHERE departamento = 'SECAP');

DELETE FROM colaborador 
	WHERE departamento = 'SECAP';

DELETE FROM departamento 
	WHERE sigla = 'SECAP';

SELECT * FROM colaborador 
    WHERE departamento = 'SECAP';

SELECT departamento AS sigla, nome FROM colaborador 
	WHERE cep = '71777-700' AND departamento IN ('SECAP', 'SESEG') 
	ORDER BY departamento;


