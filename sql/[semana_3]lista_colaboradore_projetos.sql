SELECT
    C##brh.DEPARTAMENTO.nome AS Nome_Departamento,
    C##brh.PROJETO.nome AS Nome_Projeto,
    COUNT(C##brh.ATRIBUICAO.colaborador) AS Quantidade_Colaboradores
FROM
    C##brh.DEPARTAMENTO
INNER JOIN
    C##brh.COLABORADOR ON C##brh.DEPARTAMENTO.sigla = C##brh.COLABORADOR.departamento
INNER JOIN
    C##brh.ATRIBUICAO ON C##brh.COLABORADOR.matricula = C##brh.ATRIBUICAO.colaborador
INNER JOIN
    C##brh.PROJETO ON C##brh.ATRIBUICAO.projeto = C##brh.PROJETO.id
GROUP BY
    C##brh.DEPARTAMENTO.nome, C##brh.PROJETO.nome
ORDER BY
    C##brh.DEPARTAMENTO.nome, C##brh.PROJETO.nome;