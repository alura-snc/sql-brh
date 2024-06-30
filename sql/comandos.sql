/*  1 - Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.; */ 


SELECT * FROM brh.dependente WHERE nome LIKE '%h%' OR TO_CHAR(data_nascimento, 'MM')IN('04', '05', '06') ;


/* 2 -  Criar consulta que liste nome e o salário do colaborador com o maior salário; */

SELECT nome, salario FROM (
    SELECT nome, salario FROM brh.colaborador ORDER BY salario DESC
)
WHERE ROWNUM = 1;


/* 3 A senioridade dos colaboradores é determinada a faixa salarial:

Júnior: até R$ 3.000,00;
Pleno: R$ 3.000,01 a R$ 6.000,00;
Sênior: R$ 6.000,01 a R$ 20.000,00;
Corpo diretor: acima de R$ 20.000,00.
*/

select
matricula, nome, salario,(
    case     when salario <= 3000 then 'Junior'
             when salario > 3000 and salario <= 6000 then 'Pleno'
             when salario > 6000 and salario <= 20000 then 'Senior'
    else 'Corpor Diretor'
    END) as senioridade
from brh.colaborador 
order by  nome;



/* 4 - Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores daquele departamento fazem parte do projeto; */
SELECT d.nome as Depto, p.nome as Projeto, COUNT(*) as Num_Colaboradores FROM brh.departamento d
INNER JOIN brh.colaborador c ON d.sigla = c.departamento
INNER JOIN brh.atribuicao a ON c.matricula = a.colaborador
INNER JOIN brh.projeto p ON a.projeto = p.id
GROUP BY d.nome, p.nome ORDER BY d.nome, p.nome;

/* 5 Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui; */ 


SELECT c.nome, count(*) as num_dependentes FROM brh.dependente d
INNER JOIN brh.colaborador c ON d.colaborador = c.matricula
GROUP BY c.nome ;

/*Regras de aceitação
No relatório deve ter somente colaboradores com 2 ou mais dependentes.
Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente.*/

SELECT c.nome, count(*) as num_dependentes FROM brh.dependente d
INNER JOIN brh.colaborador c ON d.colaborador = c.matricula
GROUP BY c.nome HAVING count(*) >= 2 ORDER BY num_dependentes DESC, c.nome;