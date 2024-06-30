
-- INSERIR NOVO COLABORADOR  FINAL


INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('V111', 'Fulano de Tal', '478.254.896-77', '8950', 'SEDES', '03258055', 'Rua Scipiao', 'Casa 2');

INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo)  VALUES ('V111', '(11) 9 8547-6632', 'M');

INSERT INTO brh.telefone_colaborador (numero, colaborador, tipo)  VALUES ('V111', '(11) 3457 9658', 'R');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('V111', 'fulaninho@hotmail.com;', 'P');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('V111', 'fulaninho.tal@brh.com;', 'T');

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('897.358.458.33', 'V111', 'Filha Beltrana de Tal', 'Filho(a)', to_date('2011-08-22', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('587.412.365-98', 'V111', 'Esposa Cicrana de Tal', 'Cônjuge', to_date('1992-02-25', 'yyyy-mm-dd'));

-- CONSULTA RELATORIO DE CONJUGES 

SELECT 
DP.NOME AS "NOME DO DEPENDENTE", DP.DATA_NASCIMENTO AS "DATA DE NASCIMENTO DEPENDENTE", DP.PARENTESCO, CL.NOME AS "NOME DO COLABORADOR"
FROM
BRH.DEPENDENTE DP
INNER JOIN
BRH.COLABORADOR CL
ON NOME.CL = NOME.DP WHERE DP.PARENTESCO = 'CONJUGE';
    
    -- CONSULTA FILTROS DE DEPENDENTES  
    
SELECT * FROM BRH.DEPENDENTE WHERE TO_CHAR ((DATA_NASCIMENTO, 'MM' = '4', '5', '6') OR NOME LIKE '%h%');

-- CONSULTA COLABORADOR MAIOR SALARIO 

SELECT NOME AS "NOME DO COLABORADOR", SALARIO AS "SALARIO DO COLABORADOR", MAX(SALARIO) FROM BRH.COLABORADOR;

 -- RELATORIO DE CONTATOS
 
 SELECT CL.NOME AS "NOME DO COLABORADOR", TL.TELEFONE AS "TELEFONE DO COLABORADOR", EM.EMAIL AS "EMAIL DO COLABORADOR"
 FROM
 BRH.COLABORADOR CL
 INNER JOIN 
 brh.telefone_colaborador TL
 INNER JOIN
 brh.email_colaborador EM 
 WHERE TL.TIPO = 'M' OR 'C' AND  EM.TIPO = 'T'
 ON CL.NOME = TL.TELEFONE AND EM.EMAIL
 ORDER BY
    ( brh.colaborador.nome );
 
 
 -- CONSULTA RELATORIO DE SENIORIDADE 

SELECT MATRICULA, NOME, SALARIO CASE WHEN salario <= 3000.00 THEN 'Júnior' WHEN salario <= 6000.00 THEN 'Pleno' WHEN salario <= 20000.00 THEN 'Sênior' ELSE 'Corpo diretor'
    END AS SENIORIDADE FROM BRH.COLABORADOR;
 
    
COMMIT;

