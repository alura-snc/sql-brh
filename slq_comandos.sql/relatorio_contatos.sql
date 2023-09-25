SELECT
    C.nome AS "Nome",
    E.email AS "Email",
    T.numero AS "Telefone"
FROM
    C##brh.COLABORADOR C
LEFT JOIN
    C##brh.EMAIL_COLABORADOR E ON C.matricula = E.colaborador AND E.tipo = 'T'
LEFT JOIN
    C##brh.TELEFONE_COLABORADOR T ON C.matricula = T.colaborador AND T.tipo = 'M'
ORDER BY
    "Nome";