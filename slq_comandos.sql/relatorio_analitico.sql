SELECT
    D.nome AS "Departamento",
    D.chefe AS "Chefe do Departamento",
    C.nome AS "Colaborador",
    P.nome AS "Projeto",
    PA.nome AS "Nome do Papel",
    TO_CHAR(TC.numero) AS "Telefone",
    DE.nome AS "Dependente"
FROM
    C##brh.DEPARTAMENTO D
JOIN
    C##brh.COLABORADOR C ON D.sigla = C.departamento
LEFT JOIN
    C##brh.PROJETO P ON C.matricula = P.responsavel
LEFT JOIN
    C##brh.PAPEL PA ON C.matricula = TO_CHAR(PA.id)
LEFT JOIN
    C##brh.TELEFONE_COLABORADOR TC ON C.matricula = TC.colaborador
LEFT JOIN
    C##brh.DEPENDENTE DE ON C.matricula = DE.colaborador
ORDER BY
    "Projeto", "Colaborador", "Dependente";