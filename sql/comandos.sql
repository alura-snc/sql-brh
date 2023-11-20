INSERT INTO papel (id, nome) VALUES (1,'Especialista de Negócios');

INSERT INTO departamento (sigla, nome, chefe, departamento_superior) VALUES ('ti', 'tecnologia da informação', 'jackson', '');

INSERT INTO endereco (cep, uf, cidade, bairro) VALUES ('01524-020', 'sp', 'são paulo', 'cambuci');

INSERT INTO colaborador (matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('1', '123.123.123-00', 'Fulano de Tal',
2000, 'ti', '01524-020', 'rua dois - 109', 'fundos' );

INSERT INTO telefone_colaborador (numero, colaborador, tipo) VALUES ('(61) 3030-4040', 1, 'R');
INSERT INTO telefone_colaborador (numero, colaborador, tipo) VALUES ('(61) 9 9999-9999', 1, 'C');

INSERT INTO email_colaborador (email, colaborador, tipo) VALUES ('fulano@email.com', 1, 'P');
INSERT INTO email_colaborador (email, colaborador, tipo) VALUES ('fulano.tal@brh.com', 1, 'T');

INSERT INTO dependente (cpf,nome,data_nascimento,parentesco, colaborador) VALUES ('321.321.321-99','beltrana de Tal', to_date('15/11/91','DD/MM/YY'), 'Filho(a)', 1);
INSERT INTO dependente (cpf,nome,data_nascimento,parentesco, colaborador) VALUES ('001.371.321-72', 'cicrana de Tal', to_date('30/01/74','DD/MM/YY'), 'cônjuge', '1');

INSERT INTO projeto (id, nome, responsavel, inicio, fim) VALUES (1, 'bi', 1,to_date('15/11/23','DD/MM/YY'),to_date('15/03/24','DD/MM/YY'));


SELECT sigla, nome FROM departamento ORDER BY nome;


SELECT c.nome as nome_colaborador, d.nome as nome_depentente, d.data_nascimento, d.parentesco
FROM
colaborador c
INNER JOIN
dependente d
ON c.matricula = d.colaborador
ORDER BY c.nome, d.nome desc;

INSERT INTO departamento (sigla, nome, chefe, departamento_superior) VALUES ('SECAP', 'secagem parlamentar', 'jackson', '');
select * from departamento;

DELETE FROM departamento WHERE sigla = 'SECAP'; 


