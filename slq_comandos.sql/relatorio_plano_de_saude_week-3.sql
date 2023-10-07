--- RELATÓRIO PLANO DE SAÚDE

SELECT
    C.MATRICULA AS "Matrícula do Colaborador",
    C.NOME AS "Nome do Colaborador",
    C.SALARIO AS "Salário",
    CASE
        WHEN C.SALARIO <= 3000 THEN 0.01
        WHEN C.SALARIO <= 6000 THEN 0.02
        WHEN C.SALARIO <= 20000 THEN 0.03
        ELSE 0.05
    END AS "Percentual Senioridade",
    COUNT(D.COLABORADOR) AS "Quantidade de Dependentes",
    SUM(
        CASE
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 < 18 THEN 25
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 >= 18 AND D.PARENTESCO = 'Cônjuge' THEN 100
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 >= 18 THEN 50
        END
    ) AS "Valor Dependentes",
    (C.SALARIO * (
        CASE
            WHEN C.SALARIO <= 3000 THEN 0.01
            WHEN C.SALARIO <= 6000 THEN 0.02
            WHEN C.SALARIO <= 20000 THEN 0.03
            ELSE 0.05
        END
    )) + SUM(
        CASE
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 < 18 THEN 25
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 >= 18 AND D.PARENTESCO = 'Cônjuge' THEN 100
            WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 >= 18 THEN 50
        END
    ) AS "Mensalidade Total"
FROM BRH_COLABORADOR C
LEFT JOIN BRH_DEPENDENTE D ON C.MATRICULA = D.COLABORADOR
GROUP BY C.MATRICULA, C.NOME, C.SALARIO
ORDER BY "Percentual Senioridade", "Matrícula do Colaborador";
