----- Inserir novo colaborador

INSERT INTO brh_colaborador 
(matricula,cpf,nome,salario,departamento,cep,logradouro,complemento)
VALUES
('A1234','589.467.247-98','Fulano de Tal','5000','SEDES','71777-700','Avenida Principal', 'Casa-12')

INSERT INTO brh_projeto
(nome,responsavel,inicio,fim)
VALUES
('BI','A1234',to date('2023-09-27','yyyy-mm-dd'), null);

INSERT INTO brh_papel
(matricula,nome)
VALUES
('A1234','Especialista de Negócios')

INSERT INTO brh.telefone_colaborador 
(colaborador, numero, tipo)
VALUES 
('A1234', '(61) 9 9999-9999', 'M');

INSERT INTO brh.telefone_colaborador 
(colaborador, numero, tipo)
VALUES 
('A1234', '(61) 3030-4040', 'R');

INSERT INTO brh.email_colaborador 
(colaborador, email, tipo) 
VALUES ('A1234', 'fulano@email.com', 'P');

INSERT INTO brh.email_colaborador 
(colaborador, email, tipo) 
VALUES ('A1234', 'fulano.tal@brh.com', 'T');

INSERT INTO brh.dependente 
(cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES 
('240.741.543-15', 'A1234', 'Beltrana de Tal', 'Filho(a)', to_date('2019-07-26', 'yyyy-mm-dd'))


INSERT INTO brh.dependente 
(cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES 
('240.741.543-15', 'A1234', 'Cicrana de Tal', 'Esposa)', to_date('1995-02-12', 'yyyy-mm-dd'))

----------Relatório de departamentos
  
select sigla,nome from brh.departamento




