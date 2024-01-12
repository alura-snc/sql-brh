-- Cadastrar o novo colaborador Fulano de Tal no novo projeto
-- BI para exercer o papel de Especialista de Negócios.


INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de Negócios');

INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES ('Z1234', 'Fulano de Tal', '103.845.160-42', '49944', 'DIR', '71444-400', 'Avenida Principal', 'ChÃ¡cara 18');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('Z1234', '(61) 9 9999-9999', 'M');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('Z1234', '(61) 9 3030-4040', 'R');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('Z1234', ' fulano@email.com', 'P');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('Z1234', ' fulano.tal@brh.com', 'T');

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('243.361.552-68', 'Z1234', 'Beltrana de Tal', 'Filho(a)', to_date('2010-02-01', 'yyyy-mm-dd'));

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('245.201.558-87', 'Z1234', 'Cicrana de Tal', 'CÃ´njuge', to_date('1988-12-11', 'yyyy-mm-dd'));

INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (1, 'Z1234', 2);


select*from brh.atribuicao where colaborador='Z1234';

--O resultado da consulta deve ser ordenado pelo nome doo departamento.
SELECT sigla, nome AS "NOME DO DEPARTAMENTO'"  FROM brh.departamento ORDER BY nome;

--Tarefa
--Crie uma consulta que liste:
--nome do colaborador;
--nome do dependente;
-- data de nascimento do dependente;
--parentesco do dependente.


SELECT brh.colaborador.nome, brh.dependente.nome, brh.dependente.data_nascimento, brh.dependente.parentesco 
FROM brh.colaborador 
FULL JOIN brh.dependente 
ON brh.colaborador .matricula = brh.dependente.colaborador 
WHERE brh.colaborador.nome > 'A' AND brh.dependente.nome >'A'
ORDER BY colaborador ASC;

--Remova o departamento SECAP da base de dados;
 
DELETE FROM brh.departamento WHERE sigla= 'SECAP';



select
brh.colaborador.nome,
brh.email_colaborador.email as "E-mail Corporativo",
brh.telefone_colaborador.numero as "Telefone Celular"
from brh.colaborador

inner join brh.email_colaborador
on brh.colaborador.matricula = brh.email_colaborador.colaborador
inner join brh.telefone_colaborador
on brh.colaborador.matricula = brh.telefone_colaborador.colaborador
where brh.email_colaborador.tipo = 'T' and
brh.telefone_colaborador.tipo = 'M'
ORDER BY brh.colaborador.nome;


COMMIT;