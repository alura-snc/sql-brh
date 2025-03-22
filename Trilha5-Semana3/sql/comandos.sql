INSERT INTO brh.colaborador (MATRICULA, CPF, NOME, SALARIO, LOGRADOURO, COMPLEMENTO_ENDERECO, CEP, DEPARTAMENTO) 
VALUES ('w234','223.456.789-20', 'Fulano de Tal', '456', 'Rua tal tal ro, 10', 'CASA12', '71111-890', 'DEPTI');

INSERT INTO brh.telefone_colaborador (numero, tipo, colaborador) VALUES ('(89) 9 0009-9999','M', 'w234');
INSERT INTO brh.telefone_colaborador (numero, tipo, colaborador) VALUES ('(89) 3010-4040','R', 'w234');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('w234', ' fulano@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('w234', ' fulano.tal@brh.com', 'T');

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('223.456.789-20', 'w234', 'Beltrana de Tal', 'Filho(a)', to_date('2000-01-01', 'yyyy-mm-dd'));

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES ('455.788.598-25', 'w234', 'Cicrana de Tal', 'Cônjuge', to_date('1980-08-90', 'yyyy-mm-dd'));

SELECT * FROM brh.dependente WHERE colaborador = 'w234';

UPDATE brh.dependente set (cpf) = '890.006.921-00' WHERE cpf = '223.456.789-20';


--Relatorio de Conjuges

SELECT COLABORADOR AS MATRICULA_COLABORADOR, NOME, TO_CHAR (DATA_NASCIMENTO, 'dd/mm/yyyy')
FROM BRH.DEPENDENTE 
WHERE PARENTESCO = 'Cônjuge';

--Relatorio contato telefônicos

SELECT COLABORADOR, NUMERO FROM BRH.TELEFONE_COLABORADOR WHERE TIPO IN ('M', 'C') ORDER BY COLABORADOR, NUMERO;

--Colaborador com maior salário

SELECT MAX(SALARIO) FROM BRH.COLABORADOR;

SELECT NOME, SALARIO 
FROM BRH.COLABORADOR 
WHERE SALARIO = (SELECT MAX(SALARIO)FROM BRH.COLABORADOR);

--Relatorio de Senioridade
    
SELECT MATRICULA, NOME, SALARIO, 
    CASE 
        WHEN SALARIO <= 3000 THEN 'Junior'
        WHEN SALARIO <= 6000 THEN 'Pleno'
        WHEN SALARIO <= 20000 THEN 'Senior'
        ELSE 'Corpo Diretor'
    END SENIORIDADE
FROM BRH.COLABORADOR
ORDER BY SENIORIDADE, NOME;

COMMIT;