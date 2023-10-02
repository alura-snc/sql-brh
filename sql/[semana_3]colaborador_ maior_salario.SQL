SELECT
    nome,
    salario
FROM
    c##brh.colaborador
WHERE salario = (SELECT MAX(salario) FROM c##brh.colaborador);