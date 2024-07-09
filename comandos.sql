SELECT c.nome AS nome_colaborador, 
       d.nome AS nome_dependente, 
       d.data_nascimento, 
       d.parentesco
FROM brh.colaborador c
JOIN brh.dependente d ON c.matricula = d.colaborador
WHERE EXTRACT(MONTH FROM d.data_nascimento) IN (4, 5, 6)
   OR LOWER(d.nome) LIKE '%h%'
ORDER BY c.nome, d.nome;

SELECT nome, salario
FROM brh.colaborador
WHERE salario = (SELECT MAX(salario) FROM brh.colaborador);

SELECT matricula, 
       nome, 
       salario, 
       CASE 
           WHEN salario <= 3000.00 THEN 'Júnior'
           WHEN salario > 3000.00 AND salario <= 6000.00 THEN 'Pleno'
           WHEN salario > 6000.00 AND salario <= 20000.00 THEN 'Sênior'
           ELSE 'Corpo diretor'
       END AS nivel_senioridade
FROM brh.colaborador;

SELECT d.nome AS nome_departamento, 
       p.nome AS nome_projeto, 
       COUNT(a.colaborador) AS quantidade_colaboradores
FROM brh.departamento d
JOIN brh.colaborador c ON d.sigla = c.departamento
JOIN brh.atribuicao a ON c.matricula = a.colaborador
JOIN brh.projeto p ON a.projeto = p.id
GROUP BY d.nome, p.nome
ORDER BY d.nome, p.nome;
SELECT d.nome AS nome_departamento, 
       p.nome AS nome_projeto, 
       COUNT(c.matricula) AS quantidade_colaboradores
FROM brh.departamento d
JOIN brh.colaborador c ON d.sigla = c.departamento
JOIN brh.atribuicao a ON c.matricula = a.colaborador
JOIN brh.projeto p ON a.projeto = p.id
GROUP BY d.nome, p.nome
ORDER BY d.nome, p.nome;
