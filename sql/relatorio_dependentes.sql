SELECT C.nome AS "Nome do Colaborador", D.nome AS "Nome do Dependente", D.data_nascimento AS "Data de Nascimento do Dependente", D.parentesco AS "Parentesco do Dependente"
FROM C##brh.COLABORADOR C
INNER JOIN C##brh.DEPENDENTE D ON C.matricula = D.colaborador
ORDER BY C.nome, D.nome;