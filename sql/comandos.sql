INSERT INTO brh_Departamento (sigla_departamento, nome, departamento_superior, chefe)
VALUES ('Financeiro', 'Departamento Financeiro', NULL, 'IDCHEFE001');

INSERT INTO brh_Colaborador (matricula, departamento, cpf, nome, salario)
VALUES ('IDKFA2510401098', 'Financeiro', '99988877789', 'Fulano de Tal', 6500);

INSERT INTO brh_Endereco (cep, logradouro, bairro, complemento, cidade, estado, colaborador)
VALUES ('14940000', 'Rua das Palmeiras 89', 'Setor Oeste', 'Apto 555', 'São Paulo', 'SP', 'IDKFA2510401098');

INSERT INTO brh_Projeto (id_projeto, nome, inicio, fim, matricula)
VALUES ('BI2024', 'Projeto BI', TO_DATE('01/01/2024', 'DD/MM/YYYY'), NULL, 'IDKFA2510401098');

INSERT INTO brh_Telefones (colaborador, telefones, tipo)
VALUES ('IDKFA2510401098', '(61) 9 9999-9999', 'Celular');

INSERT INTO brh_Emails (colaborador, emails)
VALUES ('IDKFA2510401098', 'fulano@email.com');

INSERT INTO brh_Dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('77788866625', 'IDKFA2510401098', 'Beltrana de Tal', 'Filha', TO_DATE('15/05/2010', 'DD/MM/YYYY'));

INSERT INTO brh_Papel (id_papel, nome)
VALUES ('PA017', 'Especialista de Negócios');

INSERT INTO brh_Atribuicao (matricula, id_projeto, id_papel)
VALUES ('IDKFA2510401098', 'BI2024', 'PA017');

SELECT sigla_departamento, nome
FROM brh_Departamento
ORDER BY nome;

SELECT c.nome AS nome_colaborador,
       d.nome AS nome_dependente,
       TO_CHAR(d.data_nascimento, 'DD/MM/YYYY') AS data_nascimento_dependente,
       d.parentesco
FROM brh_Colaborador c
JOIN brh_Dependente d ON c.matricula = d.colaborador
ORDER BY c.nome, d.nome;

DELETE FROM brh_Dependente
WHERE colaborador IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Telefones
WHERE colaborador IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Emails
WHERE colaborador IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Endereco
WHERE colaborador IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Atribuicao
WHERE matricula IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Projeto
WHERE matricula IN (
    SELECT matricula FROM brh_Colaborador WHERE departamento = 'SECAP'
);

DELETE FROM brh_Colaborador
WHERE departamento = 'SECAP';

DELETE FROM brh_Departamento
WHERE sigla_departamento = 'SECAP';







