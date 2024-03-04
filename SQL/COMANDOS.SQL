---Inserir projeto

INSERT INTO brh.projeto (nome, responsavel, inicio) VALUES ('BI', 'M123', SYSDATE);

-- inserir papel 

INSERT INTO brh.papel (nome) VALUES ('Especialista de Negócios'); 

--Insert de colaborador

INSERT INTO brh.colaborador (matricula, cpf, nome, salario, departamento, cep, logradouro) VALUES ('FU123', '141.964.600-11', 'Fulano de Tal', '5000,00', 'DEREH', '71111-100', 'QI 11,bloco G apto 30');

-- Insert telefone 1 e 2

INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(61) 9999-9999', 'FU123', 'M'); 

INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo) VALUES ('(61) 3030-4040', 'FU123', 'R'); 

-- Insert email

INSERT INTO brh.email_colaborador (email, colaborador, tipo) VALUES ('fulano@email.com', 'FU123', 'P'); 

-- Relatório de cônjuge

select c.nome as COLABORADOR, d.nome AS DEPENDENTE, d.data_nascimento
from brh.colaborador c
inner join brh.dependente d
on c.matricula = d.colaborador
where d.parentesco = 'Cônjuge'


-- FILTRAR DEPENDENTES

SELECT * FROM brh.dependente 
WHERE to_char (DATA_NASCIMENTO, 'mm') in ('04', '05', '06')
OR lower (NOME) LIKE '%h%'
ORDER BY NOME;

--Listar colaborador maior salário

SELECT NOME, SALARIO
FROM brh.colaborador
WHERE SALARIO = (SELECT MAX (SALARIO) FROM brh.colaborador);



SELECT NOME, SALARIO
FROM brh.colaborador
ORDER BY SALARIO DESC
FETCH FIRST 1 ROW ONLY;

--RELATÓRIO DE SENIORIDADE

SELECT C.MATRICULA,
C.NOME, 
C.SALARIO,
(CASE
        WHEN C.SALARIO <= 3000 THEN 'Junior'
        WHEN C.SALARIO <= 6000 THEN 'Pleno'
        WHEN C.SALARIO <= 20000 THEN 'Senior'
        ELSE 'Corpo Diretor'
    END) SENIORIDADE
FROM brh.colaborador C
ORDER BY C.SALARIO, NOME;


---RELATÓRIO DE CONTATOS

SELECT C. NOME, TC.NUMERO, EC.EMAIL
FROM brh.colaborador C
INNER JOIN brh.telefone_colaborador TC ON C.MATRICULA = TC.COLABORADOR AND TC. TIPO IN ('M', 'C')
INNER JOIN brh.email_colaborador EC ON C.MATRICULA = EC.COLABORADOR AND EC.TIPO = 'T'
ORDER BY NOME;