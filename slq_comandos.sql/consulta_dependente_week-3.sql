--consulta dependente

SELECT c.NOME AS "Nome do Colaborador", d.NOME AS "Nome do Dependente"
FROM BRH_COLABORADOR c
INNER JOIN BRH_DEPENDENTE d ON c.MATRICULA = d.COLABORADOR
WHERE (TO_CHAR(d.DATA_NASCIMENTO, 'MM') IN ('04', '05', '06') OR UPPER(d.NOME) LIKE '%H%')
ORDER BY c.NOME, d.NOME;