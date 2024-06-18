-- INSERIR NOVO COLABORADOR
INSERT INTO brh.colaborador (
    matricula,
    cpf,
    nome,
    salario,
    departamento,
    cep,
    logradouro,
    complemento_endereco
) VALUES (
    'A124',
    '293.603.947-47',
    'Fulano de Tal',
    8750,
    'SEDES',
    '71111-100',
    'Avenida das Castanheiras',
    'Casa 30'
);

INSERT INTO brh.papel (
    id,
    nome
) VALUES (
    8,
    'Especialista de Negócios'
);

INSERT INTO brh.telefone_colaborador (
    colaborador,
    numero,
    tipo
) VALUES (
    'A124',
    '(61) 99999-9999',
    'M'
);

INSERT INTO brh.telefone_colaborador (
    colaborador,
    numero,
    tipo
) VALUES (
    'A124',
    '(61) 3030-4040',
    'R'
);

INSERT INTO brh.telefone_colaborador (
    colaborador,
    numero,
    tipo
) VALUES (
    'A124',
    '(61) 3587-2020',
    'C'
);

INSERT INTO brh.email_colaborador (
    colaborador,
    email,
    tipo
) VALUES (
    'A124',
    'fulano@email.com',
    'P'
);

INSERT INTO brh.email_colaborador (
    colaborador,
    email,
    tipo
) VALUES (
    'A124',
    'fulano.tal@brh.com',
    'T'
);

INSERT INTO brh.dependente (
    cpf,
    colaborador,
    nome,
    parentesco,
    data_nascimento
) VALUES (
    '832.987.154-12',
    'A124',
    'Beltrana de Tal',
    'Filho(a)',
    TO_DATE('2020-07-04', 'yyyy-mm-dd')
);

INSERT INTO brh.dependente (
    cpf,
    colaborador,
    nome,
    parentesco,
    data_nascimento
) VALUES (
    '367.419.374-22',
    'A124',
    'Cicrana de Tal',
    'Cônjuge',
    TO_DATE('1987-10-13', 'yyyy-mm-dd')
);

INSERT INTO brh.projeto (
    id,
    nome,
    responsavel,
    inicio,
    fim
) VALUES (
    5,
    'BI',
    'N123',
    TO_DATE('2024-01-01', 'yyyy-mm-dd'),
    TO_DATE('2024-12-31', 'yyyy-mm-dd')
);

INSERT INTO brh.atribuicao (
    projeto,
    colaborador,
    papel
) VALUES (
    5,
    'A124',
    8
);



-- RELATÓRIO DE CÔNJUGES
SELECT
    colab.nome AS nome_colaborador,
    depen.nome AS nome_conjuge,
    depen.data_nascimento AS data_nascimento_conjuge
FROM
         brh.colaborador colab
    INNER JOIN brh.dependente depen ON colab.matricula = depen.colaborador
WHERE
    depen.parentesco = 'CÃ´njuge';
-- !!! Tive que usar CÃ´njuge no lugar de Cônjuge, pois meu SGBD estava com problemas nos caracteres, assim a query funciona, só para entregar o exercício funcionando



-- FILTRAR DEPENDENTES
SELECT
    *
FROM
    brh.dependente
WHERE
    to_char(data_nascimento, 'MM') IN ( 04, 05, 06 )
    OR nome LIKE '%h%'
ORDER BY
    nome;


-- COLABORADOR COM SALÁRIO MAIS ALTO
SELECT nome, salario FROM brh.colaborador WHERE salario = (SELECT MAX(salario) FROM brh.colaborador);

-- RELATÓRIO DE SENIORIDADE
SELECT matricula, nome, salario,
    (
        CASE
            WHEN salario <= 3000 THEN
                'Júnior'
            WHEN salario > 3000
                 AND salario <= 6000 THEN
                'Pleno'
            WHEN salario > 6000
                 AND salario <= 20000 THEN
                'Sênior'
            ELSE
                'Corpo Diretor'
        END
    ) AS senioridade
FROM
    brh.colaborador
ORDER BY
    senioridade,
    nome;



-- RELATÓRIO DE CONTATOS
SELECT
    colab.nome,
    fone.numero,
    fone.tipo AS tipo_telefone,
    mail.email,
    mail.tipo AS tipo_email
FROM
         brh.telefone_colaborador fone
    INNER JOIN brh.colaborador colab ON colab.matricula = fone.colaborador
    INNER JOIN brh.email_colaborador mail ON colab.matricula = mail.colaborador
WHERE
        mail.tipo = 'T'
    AND ( fone.tipo = 'M'
          OR fone.tipo = 'C' );



-- LISTAR COLABORADORES COM MAIS DEPENDENTES
SELECT colab.nome AS nome_colaborador,
    COUNT(depen.colaborador) AS quantidade_dependente
FROM
         brh.colaborador colab
    INNER JOIN brh.dependente depen ON colab.matricula = depen.colaborador
HAVING
    COUNT(depen.colaborador) >= 2
GROUP BY
    colab.nome
ORDER BY
    quantidade_dependente DESC,
    colab.nome;



-- RELATÓRIO DE DEPENDENTES MENORES DE IDADE
SELECT
    colab.matricula AS matricula_colaborador,
    depen.nome AS nome_dependente,
    trunc((months_between(sysdate, depen.data_nascimento)) / 12) AS idade_dependente
FROM
         brh.colaborador colab
    INNER JOIN brh.dependente depen ON colab.matricula = depen.colaborador
WHERE
    trunc((months_between(sysdate, depen.data_nascimento)) / 12) < 18;



-- RELATÓRIO ANALÍTICO DE EQUIPES
SELECT
    depto.nome  AS nome_departamento,
    depto.chefe,
    colab.nome  AS nome_colaborador,
    fone.numero AS telefone,
    depen.nome  AS nome_dependente,
    atribuicao.nome_papel,
    atribuicao.nome_projeto
FROM
         brh.departamento depto
    INNER JOIN brh.colaborador colab ON colab.departamento = depto.sigla
    INNER JOIN brh.telefone_colaborador fone ON fone.colaborador = colab.matricula
    INNER JOIN brh.dependente depen ON depen.colaborador = fone.colaborador
    INNER JOIN (
        SELECT
            papel.nome AS nome_papel,
            proj.nome AS nome_projeto,
            atrib.colaborador AS colaborador
        FROM
                 brh.papel papel
            INNER JOIN brh.atribuicao atrib ON atrib.papel = papel.id
            INNER JOIN brh.projeto proj ON atrib.projeto = proj.id
    )                        atribuicao ON depen.colaborador = atribuicao.colaborador
ORDER BY
    atribuicao.nome_projeto,
    colab.nome,
    depen.nome;



-- LISTAR QUANTIDADE DE COLABORADORES EM PROJETOS
SELECT * FROM brh.departamento;
SELECT * FROM brh.projeto;
SELECT * FROM brh.colaborador;
SELECT * FROM brh.atribuicao;

SELECT
    depto.nome AS nome_departamento,
    proj.nome AS nome_projeto,
    COUNT(*) AS QUANTIDADE_COLABORADORES
FROM
         brh.departamento depto
    INNER JOIN brh.colaborador colab ON depto.sigla = colab.departamento
    INNER JOIN brh.atribuicao atrib ON colab.matricula = atrib.colaborador
    INNER JOIN brh.projeto proj ON atrib.projeto = proj.id
GROUP BY depto.nome, proj.nome
ORDER BY depto.nome, proj.nome;


-- criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" --
SELECT
    colab.nome AS nome_colaborador,
    depen.nome AS nome_dependente,
    depen.data_nascimento
FROM
    brh.dependente depen
    INNER JOIN brh.colaborador colab ON depen.colaborador = colab.matricula
WHERE
    TO_CHAR(depen.data_nascimento, 'MM') IN ('04', '05', '06')
    OR LOWER(depen.nome) LIKE '%h%'
ORDER BY
    colab.nome,
    depen.nome;

-- LISTAR COLABORADORS EM PROJETOS
SELECT
    depto.nome AS nome_departamento,
    proj.nome AS nome_projeto,
    COUNT(atrib.colaborador) AS quantidade_colaboradores
FROM
    brh.departamento depto
    INNER JOIN brh.colaborador colab ON depto.sigla = colab.departamento
    INNER JOIN brh.atribuicao atrib ON colab.matricula = atrib.colaborador
    INNER JOIN brh.projeto proj ON atrib.projeto = proj.id
GROUP BY
    depto.nome,
    proj.nome
ORDER BY
    depto.nome,
    proj.nome;

-- LISTAR FAIXA ETÁRIA DOS DEPENDENTES
SELECT
    d.cpf AS cpf_dependente,
    d.nome AS nome_dependente,
    TO_CHAR(d.data_nascimento, 'DD/MM/YYYY') AS data_nascimento_formatado,
    d.parentesco,
    d.colaborador AS matricula_colaborador,
    TRUNC(MONTHS_BETWEEN(SYSDATE, d.data_nascimento) / 12) AS idade_dependente,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, d.data_nascimento) / 12) < 18 THEN 'Menor de idade'
        ELSE 'Maior de idade'
    END AS faixa_etaria
FROM
    brh.dependente d
ORDER BY
    d.colaborador,
    d.nome;

-- PAGINAR LISTAGEM DE COLABORADORES
WITH paginado AS (
    SELECT
        nome,
        ROW_NUMBER() OVER (ORDER BY nome) AS num_linha
    FROM
        brh.colaborador
)
SELECT
    nome
FROM
    paginado
WHERE
    num_linha BETWEEN 11 AND 20;

-- RELATÓRIO DE PLANO DE SAÚDE
SELECT
    colab.nome AS nome_colaborador,
    colab.salario,
    (
        CASE
            WHEN colab.salario <= 3000 THEN 0.01 * colab.salario -- Júnior paga 1% do salário
            WHEN colab.salario <= 6000 THEN 0.02 * colab.salario -- Pleno paga 2% do salário
            WHEN colab.salario <= 20000 THEN 0.03 * colab.salario -- Sênior paga 3% do salário
            ELSE 0.05 * colab.salario -- Corpo diretor paga 5% do salário
        END
    ) AS contribuicao_senioridade,
    SUM(
        CASE
            WHEN depen.parentesco = 'Cônjuge' THEN 100 -- Cônjuge acrescenta R$ 100,00
            WHEN depen.idade >= 18 THEN 50 -- Maior de idade acrescenta R$ 50,00
            ELSE 25 -- Menor de idade acrescenta R$ 25,00
        END
    ) AS contribuicao_dependentes,
    (
        CASE
            WHEN colab.salario <= 3000 THEN 0.01 * colab.salario
            WHEN colab.salario <= 6000 THEN 0.02 * colab.salario
            WHEN colab.salario <= 20000 THEN 0.03 * colab.salario
            ELSE 0.05 * colab.salario
        END
    ) +
    SUM(
        CASE
            WHEN depen.parentesco = 'Cônjuge' THEN 100
            WHEN depen.idade >= 18 THEN 50
            ELSE 25
        END
    ) AS total_mensalidade
FROM
    brh.colaborador colab
    LEFT JOIN brh.dependente depen ON colab.matricula = depen.colaborador
GROUP BY
    colab.nome, colab.salario
ORDER BY
    colab.nome;

-- LISTAR COLABORADORES que participam de todos os projetos
WITH total_projetos AS (
    SELECT COUNT(*) AS total_projetos FROM brh.projeto
),
colaboradores_projetos AS (
    SELECT
        colab.matricula,
        colab.nome AS nome_colaborador,
        COUNT(DISTINCT atrib.projeto) AS total_projetos_colaborador
    FROM
        brh.colaborador colab
        INNER JOIN brh.atribuicao atrib ON colab.matricula = atrib.colaborador
    GROUP BY
        colab.matricula, colab.nome
)
SELECT
    cp.nome_colaborador,
    cp.matricula
FROM
    colaboradores_projetos cp
    CROSS JOIN total_projetos tp
WHERE
    cp.total_projetos_colaborador = tp.total_projetos
ORDER BY
    cp.nome_colaborador;

