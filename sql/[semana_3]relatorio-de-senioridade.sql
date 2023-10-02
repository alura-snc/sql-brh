SELECT
    matricula,
    nome,
    salario,
    CASE
        WHEN salario BETWEEN 0 AND 3000 THEN 'JUNIOR'
        WHEN salario BETWEEN 3000.01 AND 6000 THEN 'PLENO'
        WHEN salario BETWEEN 6000.01 AND 20000 THEN 'SENIOR'
        WHEN salario > 20000 THEN 'CORPO DIRETOR'
        ELSE 'DESCONHECIDO'
    END AS SENIORIDADE
FROM
    c##brh.colaborador
ORDER BY
    SENIORIDADE, NOME;
