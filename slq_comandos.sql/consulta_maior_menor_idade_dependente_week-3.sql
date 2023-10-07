-- MAIOR E MENOR IDADE DEPENDENTE



SELECT
    D.CPF AS "CPF do Dependente",
    D.NOME AS "Nome do Dependente",
    TO_CHAR(D.DATA_NASCIMENTO, 'DD/MM/YYYY') AS "Data de Nascimento",
    D.PARENTESCO AS "Parentesco",
    C.MATRICULA AS "Matr�cula do Colaborador",
    CASE
        WHEN MONTHS_BETWEEN(SYSDATE, D.DATA_NASCIMENTO) / 12 < 18 THEN 'Menor de idade'
        ELSE 'Maior de idade'
    END AS "Faixa Et�ria"
FROM BRH_DEPENDENTE D
INNER JOIN BRH_COLABORADOR C ON D.COLABORADOR = C.MATRICULA
ORDER BY C.MATRICULA, D.NOME;