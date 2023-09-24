INSERT INTO BRH.ENDERECO (cep, uf, cidade, bairro)
VALUES
('02401-200','SP','São Paulo','Santana');

INSERT INTO BRH.COLABORADOR (matricula, cpf, nome, salario, departamento, cep,
logradouro, complemento_endereco) 
VALUES 
('A124','335.578.528.06','fulano de tal',580.55,'DEPTI','02401-200','Rua Voluntários da Pátria','Senac');

INSERT INTO BRH.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES
('(61) 9 9999-9999','A124','M');

INSERT INTO BRH.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES
('(61) 3030-4040','A124','R');

INSERT INTO BRH.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES
('fulano@email.com','A124','P');

INSERT INTO BRH.EMAIL_COLABORADOR (email, colaborador, tipo)
VALUES
('fulano.tal@brh.com','A124','T');

INSERT INTO BRH.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES
('236.254.875-55','Beltrana de Tal','02/02/2022','Filho(a)','A124');

INSERT INTO BRH.DEPENDENTE (cpf, nome, data_nascimento, parentesco, colaborador)
VALUES
('005.275.852-98','Cicrana de Tal','01/08/1785','CÃ´njuge','A124');

INSERT INTO BRH.PROJETO (nome,responsavel, inicio, fim) --ID GERADO AUTOMÁTICAMENTE
VALUES
('BI','B123','01/09/2023','12/12/2023');

INSERT INTO BRH.PAPEL (nome) --ID GERADO AUTOMÁTICAMENTE
VALUES
('Especialista de Negócios');

INSERT INTO BRH.ATRIBUICAO (colaborador, projeto,papel)
VALUES
('A124',9,8);

--Consulta da sigla e nome do departamento ordernando por nome do departamento

SELECT sigla, nome as "NOME DO DEPARTAMENTO" FROM BRH.DEPARTAMENTO ORDER BY (nome);

--Consulta do nome do colaborador, nome do dependente do colaborador, data de nacimento do dependente e parentesco

SELECT C.nome AS "NOME DO COLABORADOR", D.nome AS "NOME DO DEPENDENTE",
D.data_nascimento AS "DATA DE NASCIMENTO DO DEPENDENTE", D.parentesco  
FROM BRH.COLABORADOR C JOIN BRH.DEPENDENTE D ON  D.COLABORADOR = C.MATRICULA;

--Removendo registro das tabelas Colaboradores e Departamentos e relacionamentos

DELETE (SELECT * FROM BRH.DEPENDENTE D JOIN BRH.COLABORADOR C 
ON D.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP'); 

DELETE (SELECT * FROM BRH.EMAIL_COLABORADOR E JOIN BRH.COLABORADOR C 
ON E.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP');

DELETE (SELECT * FROM BRH.TELEFONE_COLABORADOR T JOIN BRH.COLABORADOR C 
ON T.COLABORADOR = C.MATRICULA WHERE C.DEPARTAMENTO = 'SECAP');

DELETE FROM BRH.COLABORADOR WHERE departamento = 'SECAP';  
    
DELETE FROM BRH.DEPARTAMENTO WHERE SIGLA = 'SECAP';


