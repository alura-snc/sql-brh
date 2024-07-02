--Filtrar dependentes
SELECT
    b.nome AS nome_colaborador,
    a.nome AS nome_dependente,
    a.data_nascimento
FROM
         brh.dependente a
    INNER JOIN brh.colaborador b ON a.colaborador = b.matricula
WHERE
    EXTRACT(MONTH FROM a.data_nascimento) IN ( 4, 5, 6 )
    AND ( a.nome LIKE '%H%'
          OR a.nome LIKE '%h%' )
ORDER BY
    nome_colaborador,
    nome_dependente;
    
--Listar colaborador com maior salário
SELECT
    nome,
    salario
FROM
    brh.colaborador
WHERE
    salario IN (
        SELECT
            MAX(salario)
        FROM
            brh.colaborador
    )

--Relatório de senioridade
SELECT
    matricula,
    nome,
    salario,
    (
        CASE
            WHEN salario <= 3000 THEN
                'JÚNIOR'
            WHEN salario > 3000
                 AND salario <= 6000 THEN
                'PLENO'
            WHEN salario > 6000
                 AND salario <= 20000 THEN
                'SÊNIOR'
            ELSE
                'CORPO DIRETOR'
        END
    ) AS nível_senioridade
FROM
    brh.colaborador
ORDER BY
    4, 2
    
--Listar quantidade de colaboradores em projetos
SELECT
    d.nome   AS nome_departamento,
    p.nome,
    COUNT(*) AS quantos_colaboradores
FROM
         brh.departamento d
    INNER JOIN brh.colaborador c ON d.sigla = c.departamento
    INNER JOIN brh.atribuicao  a ON c.matricula = a.colaborador
    INNER JOIN brh.projeto     p ON a.projeto = p.id
GROUP BY
    d.nome,
    p.nome
ORDER BY
    d.nome,
    p.nome

--Listar colaboradores com mais dependentes
SELECT
    colab.nome,
    COUNT(dep.cpf)
FROM
         brh.colaborador colab
    INNER JOIN brh.dependente dep ON colab.matricula = dep.colaborador
GROUP BY
    colab.nome
HAVING
    COUNT(dep.cpf) >= 2
ORDER BY
    COUNT(dep.cpf) DESC,
    colab.nome
    
--Relatório analítico de equipes
SELECT
    d.nome  AS nome_departamento,
    d.chefe,
    c.nome  AS nome_colaborador,
    p.nome  AS nome_projeto,
    pa.nome AS nome_papel
FROM
         brh.departamento d
    INNER JOIN brh.colaborador c ON d.sigla = c.departamento
    INNER JOIN brh.atribuicao  a ON c.matricula = a.colaborador
    INNER JOIN brh.projeto     p ON a.projeto = p.id
    INNER JOIN brh.papel       pa ON a.papel = pa.id

--Listar faixa etária dos dependentes
SELECT
    cpf,
    nome,
    to_char(data_nascimento, 'DD/MM/YYYY')               AS data_nascimento,
    parentesco,
    colaborador,
    trunc(months_between(sysdate, data_nascimento) / 12) AS idade,
    (
        CASE
            WHEN trunc(months_between(sysdate, data_nascimento) / 12) < 18 THEN
                'MENOR DE IDADE'
            ELSE
                'MAIOR DE IDADE'
        END
    )                                                    AS faixa_etaria
FROM
    brh.dependente
ORDER BY
    colaborador,
    nome
    
--Paginar listagem de colaboradores

--Página 1: da Ana ao João (registros 1 ao 10);
SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num_linha,
            nome
        FROM
            brh.colaborador c
        ORDER BY
            c.nome
    )
WHERE
    num_linha BETWEEN 1 AND 10

--Página 2: da Kelly à Tati (registros 11 ao 20);
SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num_linha,
            nome
        FROM
            brh.colaborador c
        ORDER BY
            c.nome
    )
WHERE
    num_linha BETWEEN 11 AND 20
--Página 3: do Uri ao Zico (registros 21 ao 26).
     SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num_linha,
            nome
        FROM
            brh.colaborador c
        ORDER BY
            c.nome
    )
WHERE
    num_linha BETWEEN 21 AND 26
    
    