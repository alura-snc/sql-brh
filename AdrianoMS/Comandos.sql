--Cadastrar o novo colaborador Fulano de Tal no novo projeto BI para exercer o papel de Especialista de Negócios.

--Informações sobre o colaborador
--Possui o telefone celular (61) 9 9999-9999;
--Possui o telefone residencial (61) 3030-4040;
--Email pessoal é fulano@email.com;
--Email de trabalho será é fulano.tal@brh.com;
--Possui dois dependentes:
--Filha Beltrana de Tal;
--Esposa Cicrana de Tal.


INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES 
('F124', 'Fulano de Tal', '999.888.270-86', '5000', 'SEOPE', '71111-100', 'Rua Rosa', 'Casa Muro Vermelho');

--Telefone

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('F124', ' (61) 9 9999-9999', 'M');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('F124', ' (61) 3030-4040', 'R');

-- Emails

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('F124', ' fulano@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('F124', 'fulano.tal@brh.com', 'T');

--Dependentes

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('989.232.122.22', 'F124', 'Beltrana de Tal', 'Filho(a)', to_date('2015-05-30', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('092.238.123.11', 'F124', 'Esposa Cicrana de Tal', 'Cônjuge', to_date('1988-10-02', 'yyyy-mm-dd'));

-- Novo Projeto
INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'projeto BI', 'F124', to_date('2024-06-19', 'yyyy-mm-dd'), null);


-- Novo Papel 
INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de Negócios');

-- Nova Atribuição

INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'F124', 8);

--Crie uma consulta que liste a sigla e o nome do departamento;
--Adicione o código da consulta em sql/comandos.sql
--Faça commit do arquivo.
--Regras de aceitação
--O resultado da consulta deve ser ordenado pelo nome doo departamento.

SELECT sigla, nome FROM brh.departamento;


--Crie uma consulta que liste:
--nome do colaborador;
--nome do dependente;
--data de nascimento do dependente;
--parentesco do dependente.


SELECT c.nome, d.nome, d.data_nascimento, d.parentesco FROM brh.dependente d INNER JOIN brh.colaborador c ON d.colaborador = c.matricula;



--O departamento SECAP não é mais parte da nossa organização, e todos os colaboradores serão dispensados (somente para fins didáticos).

--Tarefa
--Remova o departamento SECAP da base de dados;

DELETE FROM brh.departamento WHERE sigla = 'SECAP';


--Tarefa
--Crie uma consulta que liste:
--O nome do Colaborador;
--O email de trabalho do Colaborador; e
--O telefone celular do Colaborador.

SELECT c.nome, e.email, t.numero FROM brh.email_colaborador e 
INNER JOIN brh.colaborador c ON  e.colaborador = c.matricula 
INNER JOIN brh.telefone_colaborador t ON c.matricula = t.colaborador
WHERE e.tipo = 'T' AND t.tipo = 'M';


--Tarefa
--Crie uma consulta que liste:
--O nome do Departamento;
--O nome do chefe do Departamento;
--O nome do Colaborador;
--O nome do Projeto que ele está alocado;
--O nome do papel desempenhado por ele;
--O número de telefone do Colaborador;
--O nome do Dependente do Colaborador.

SELECT d.nome as Departamento, cf.nome as "Chefe Departamento", 
c.nome as "Colaborador", prj.nome as Projeto, ppl.nome as Papel, t.numero as "Telefone", d.nome as "Nome Dependente"
FROM brh.departamento d
INNER JOIN brh.colaborador cf ON d.chefe = cf.matricula
INNER JOIN brh.colaborador c ON d.sigla = c.departamento
INNER JOIN brh.atribuicao a ON c.matricula = a.colaborador
INNER JOIN brh.projeto prj ON a.projeto = prj.id
INNER JOIN brh.papel ppl ON a.papel = ppl.id
INNER JOIN brh.telefone_colaborador t ON c.matricula = t.colaborador
INNER JOIN brh.dependente d ON c.matricula = d.colaborador;


COMMIT;