-- TAREFA 1 - Inserindo novo colaborador

INSERT INTO BRH.ENDERECO (cep, uf, cidade, bairro)
VALUES
('02401-200','SP','SÃ£o Paulo','Santana');

INSERT INTO BRH.COLABORADOR (matricula, cpf, nome, salario, departamento, cep,
logradouro, complemento_endereco) 
VALUES 
('A124','335.578.528.06','fulano de tal',580.55,'DEPTI','02401-200','Rua VoluntÃ¡rios da PÃ¡tria','Senac');

INSERT INTO BRH.TELEFONE_COLABORADOR (numero, colaborador, tipo)
VALUES
('(61) 99999-9999','A124','M');

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

INSERT INTO BRH.PROJETO (nome,responsavel, inicio, fim) --ID GERADO AUTOMÃ?TICAMENTE
VALUES
('BI','B123','01/09/2023','12/12/2023');

INSERT INTO BRH.PAPEL (nome) --ID GERADO AUTOMÃ?TICAMENTE
VALUES
('Especialista de NegÃ³cios');

INSERT INTO BRH.ATRIBUICAO (colaborador, projeto,papel)
VALUES
('A124',9,8);



--TAREFA 2 - Criando relatório de cônjuges

SELECT C.nome AS "NOME DO COLABORADOR", D.nome AS "NOME DO DEPENDENTE",
D.data_nascimento AS "DATA DE NASCIMENTO DO DEPENDENTE", D.PARENTESCO  
FROM BRH.COLABORADOR C JOIN BRH.DEPENDENTE D ON  D.COLABORADOR = C.MATRICULA
WHERE D.PARENTESCO = 'CÃ´njuge'



--TAREFA 3 - Filtrando dependentes
-- Criando consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome. 
-- Ordenando pelo nome do colaborador, depois pelo nome do dependente

SELECT 
    C.NOME AS COLABORADOR, 
    D.NOME AS DEPENDETE,
    D.DATA_NASCIMENTO AS "DATA DE NASCIMENTO"
FROM BRH.DEPENDENTE D
    INNER JOIN 
        BRH.COLABORADOR C ON C.MATRICULA = D.COLABORADOR       
WHERE
   (LOWER (D.NOME)) LIKE '%h%' OR
   EXTRACT(MONTH from D.DATA_NASCIMENTO) BETWEEN 4 and 6
ORDER BY C.NOME, D.NOME;