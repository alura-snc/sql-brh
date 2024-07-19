public class comandos {

    INSERT INTO brh.colaborador (
    matricula, cpf, nome, salario, departamento, cep, logradouro, complemento_endereco
) VALUES (
    '08754', 99925642165, 'Fulano de Tal', 8000.00, 'TI', '70000-000', 'Rua Exemplo', 'Apto 101'
    );
    INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(51) 9 9999-9999', '08754', 'M');
    INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(51) 3030-4040', '08754', 'R');
    INSERT INTO brh.email_colaborador (email, colaborador, tipo) VALUES ('fulano@email.com', '08754', 'P');
    INSERT INTO brh.email_colaborador (email, colaborador, tipo) VALUES ('fulano.tal@brh.com', '08754', 'T');
    INSERT INTO brh.dependente (cpf, nome, data_nascimento, parentesco, colaborador) VALUES ('111.222.333-44', 'Beltrana de Tal', TO_DATE('18-12-2012', 'DD-MM-YYYY'), 'Filho(a)', '08754');
    INSERT INTO brh.dependente (cpf, nome, data_nascimento, parentesco, colaborador) VALUES ('555.666.777-88', 'Cicrana de Tal', TO_DATE('09-07-1985', 'DD-MM-YYYY'), 'Cônjuge', '08754');
    INSERT INTO brh.projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'BI', '08754', TO_DATE('04-07-2024', 'DD-MM-YYYY'), NULL);
    INSERT INTO brh.atribuicao (colaborador, projeto, papel) VALUES ('08754', 5, 8);
    SELECT sigla, nome
    FROM brh.departamento
    ORDER BY nome;
    SELECT c.nome AS nome_colaborador,
    d.nome AS nome_dependente,
    d.data_nascimento,
    d.parentesco
    FROM brh.colaborador c
    JOIN brh.dependente d ON c.matricula = d.colaborador
    ORDER BY c.nome, d.nome;

    DELETE FROM brh.dependente
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.telefone_colaborador
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.email_colaborador
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.colaborador
    WHERE departamento = 'SECAP';
    DELETE FROM brh.departamento
    WHERE sigla = 'SECAP';
-- Remover dependentes dos colaboradores do departamento SECAP
    DELETE FROM brh.dependente
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.telefone_colaborador
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.email_colaborador
    WHERE colaborador IN (
            SELECT matricula
  FROM brh.colaborador
          WHERE departamento = 'SECAP'
    );
    DELETE FROM brh.colaborador
    WHERE departamento = 'SECAP';
    DELETE FROM brh.departamento
    WHERE sigla = 'SECAP';
}
