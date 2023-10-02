-- consulta_departamento_projeto_colaboradores


Ordene a consulta pelo nome do departamento e nome do projeto.

SELECT
    D.NOME AS "Nome do Departamento",
    P.NOME AS "Nome do Projeto",
    COALESCE(COUNT(C.MATRICULA), 0) AS "Quantidade de Colaboradores"
FROM BRH_DEPARTAMENTO D
LEFT JOIN BRH_COLABORADOR C ON D.SIGLA = C.DEPARTAMENTO
CROSS JOIN BRH_PROJETO P
LEFT JOIN BRH_ATRIBUICAO A ON P.ID = A.PROJETO AND C.MATRICULA = A.COLABORADOR
GROUP BY D.NOME, P.NOME
ORDER BY D.NOME, P.NOME;