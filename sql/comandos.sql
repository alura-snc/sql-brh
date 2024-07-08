/*Inserir novo colaborador
Cadastrar o novo colaborador Fulano de Tal no novo projeto BI para exercer o papel de Especialista de Negócios.

Informações sobre o colaborador
Possui o telefone celular (61) 9 9999-9999;
Possui o telefone residencial (61) 3030-4040;
Email pessoal é fulano@email.com;
Email de trabalho será é fulano.tal@brh.com;
Possui dois dependentes:
Filha Beltrana de Tal;
Esposa Cicrana de Tal.
Atenção
Você deve escolher os valores dos demais campos para o colaborador, dependentes e projeto;
Atenção à ordem em que os registros devem ser inseridos.*/

INSERT INTO brh.COLABORADOR
(MATRICULA, CPF, NOME, SALARIO, DEPARTAMENTO, CEP, LOGRADOURO, COMPLEMENTO_ENDERECO)
VALUES
('A234', '852.258.258-88', 'Fulano de Tal',  4582, 'SEFOL', '71222-200', 'Quatro Rios', 'Casa 9');

INSERT INTO BRH.PROJETO
(ID, NOME, RESPONSAVEL, INICIO, FIM)
VALUES
('9','BI','A234',TO_DATE('05/04/2023','DD/MM/YYYY'),NULL);

INSERT INTO BRH.PAPEL
(ID, NOME)
VALUES
(8,'Especialista de Neg�cios');

INSERT INTO BRH.ATRIBUICAO
(COLABORADOR, PROJETO, PAPEL)
VALUES
('A234','9','8');

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 9 9999-9999','A234','C');

INSERT INTO BRH.TELEFONE_COLABORADOR
(NUMERO, COLABORADOR, TIPO)
VALUES
('(61) 3030-4040','A234','R');

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano@email.com','A234','P');

INSERT INTO BRH.EMAIL_COLABORADOR
(EMAIL, COLABORADOR, TIPO)
VALUES
('fulano.tal@brh.com','A234','T');

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('003.334.345-77', 'Beltrana de Tal', TO_DATE('01/04/2020','DD/MM/YYYY'),'Filho(a)', 'A234');

INSERT INTO BRH.DEPENDENTE
(CPF, NOME, DATA_NASCIMENTO, PARENTESCO, COLABORADOR)
VALUES
('123.374.375-45', 'Cilana de Tal', TO_DATE('11/09/2020','DD/MM/YYYY'),'Filho(a)', 'A234');

/*Relatório de departamentos
Crie uma consulta que liste a sigla e o nome do departamento;
A consulta deve listar somente os colaboradores que:
morem no CEP 71777-700;
trabalhem nos departamentos SECAP ou SESEG.
O resultado da consulta deve ser ordenado pelo nome do departamento.*/
SELECT A.SIGLA, A.NOME
FROM BRH.DEPARTAMENTO A INNER JOIN BRH.COLABORADOR B
ON A.SIGLA = B.DEPARTAMENTO
WHERE (B.CEP = '71777-700') AND (B.DEPARTAMENTO IN ('SECAP','SESEG'))
ORDER BY A.NOME;

/*Excluir departamento SECAP
O departamento SECAP não é mais parte da nossa organização, e todos os colaboradores serão dispensados (somente para fins didáticos).
Remova o departamento SECAP da base de dados;*/
DELETE FROM BRH.DEPARTAMENTO WHERE SIGLA = 'SECAP';

/*Relatório de contatos
Crie uma consulta que liste:
O nome do Colaborador;
O email de trabalho do Colaborador; e
O telefone celular do Colaborador.
O resultado deve ser ordenado pelo nome do colaborador.*/

SELECT A.NOME, B.EMAIL, C.NUMERO
FROM BRH.COLABORADOR A INNER JOIN BRH.EMAIL B
ON A.MATRICULA = B.COLABORADOR INNER JOIN BRH.TELEFONE C
ON A.MATRICULA = C.COLABORADOR
WHERE B.TIPO = 'T' AND C.TIPO = 'M'

/*Relatório analítico de equipes
Crie uma consulta que liste:
O nome do Departamento;
O nome do chefe do Departamento;
O nome do Colaborador;
O nome do Projeto que ele está alocado;
O nome do papel desempenhado por ele;
O número de telefone do Colaborador;
O nome do Dependente do Colaborador.

O resultado deve ser ordenado pelo nome do nome do projeto, nome do colaborador e nome do dependente. */

SELECT 
D.NOME AS "NOME DEPARTAMENTO",
C.NOME AS "NOME CHEFE",
COL.NOME AS "NOME COLABORADOR",
P.NOME AS "NOME PROJETO",
AT.PAPEL AS "NOME PAPEL",
TC.NUMERO AS "TELEFONE COLABORADOR",
DEP.NOME AS "NOME DEPENDENTE"
FROM BRH.DEPARTAMENTO D 
INNER JOIN BRH.COLABORADOR C ON D.CHEFE = C.MATRICULA
INNER JOIN BRH.COLABORADOR COL ON COL.DEPARTAMENTO = D.SIGLA
INNER JOIN BRH.ATRIBUICAO AT ON AT.COLABORADOR = COL.MATRICULA
INNER JOIN BRH.PROJETO P ON P.ID = AT.PROJETO
INNER JOIN BRH.TELEFONE_COLABORADOR TC ON TC.COLABORADOR = COL.MATRICULA
INNER JOIN BRH.DEPENDENTE DEP ON DEP.COLABORADOR = COL.MATRICULA
ORDER BY P.NOME, COL.NOME, DEP.NOME;
