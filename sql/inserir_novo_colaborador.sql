-- Inserir o novo CEP. Ele não adiciona o colaborador se não colocar o CEP... (PK..)
INSERT INTO c##brh.endereco(cep, uf, cidade, bairro)
VALUES ('12345-678', 'SP', 'Ribeirão Preto', 'Ipiranga');

INSERT INTO C##brh.COLABORADOR (matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco)
VALUES ('Fulano123', '123.456.789-01', 'Fulano de Tal', 5000.00, 'SEDES', '12345-678', 'Rua A, 123', 'Apt 2B');

INSERT INTO C##brh.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES ('(61) 9 9999-9999', 'Fulano123', 'M'); -- Mobile phone

INSERT INTO C##brh.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES ('(61) 3030-4040', 'Fulano123', 'R'); 

INSERT INTO C##brh.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES ('fulano@email.com', 'Fulano123', 'P'); 

INSERT INTO C##brh.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES ('fulano.tal@brh.com', 'Fulano123', 'T'); 

INSERT INTO C##brh.PROJETO (nome, responsavel, inicio, fim)
VALUES ('BI', 'Fulano123', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));

INSERT INTO C##brh.PAPEL (nome)
VALUES ('Especialista de Negócios');

INSERT INTO C##brh.ATRIBUICAO (colaborador, projeto, papel)
VALUES ('Fulano123', (SELECT id FROM C##brh.PROJETO WHERE nome = 'BI'), (SELECT id FROM C##brh.PAPEL WHERE nome = 'Especialista de Negócios'));

INSERT INTO C##brh.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES ('111.222.333-44', 'Beltrana de Tal', TO_DATE('2000-01-15', 'YYYY-MM-DD'), 'Filho(a)', 'Fulano123');

INSERT INTO C##brh.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES ('222.333.444-55', 'Cicrana de Tal', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 'Cônjuge', 'Fulano123');
