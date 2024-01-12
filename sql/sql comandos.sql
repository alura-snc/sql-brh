-- Cadastrar o novo colaborador Fulano de Tal no novo projeto
-- BI para exercer o papel de Especialista de Negócios.


INSERT INTO brh.papel (id, nome) VALUES (8, 'Especialista de Negócios');

INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) 
VALUES ('Z1234', 'Fulano de Tal', '103.845.160-42', '49944', 'DIR', '71444-400', 'Avenida Principal', 'ChÃ¡cara 18');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('Z1234', '(61) 9 9999-9999', 'M');

INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('Z1234', '(61) 9 3030-4040', 'R');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('Z1234', ' fulano@email.com', 'P');

INSERT INTO brh.email_colaborador (colaborador, email, tipo) VALUES ('Z1234', ' fulano.tal@brh.com', 'T');

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('243.361.552-68', 'Z1234', 'Beltrana de Tal', 'Filho(a)', to_date('2010-02-01', 'yyyy-mm-dd'));

INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('245.201.558-87', 'Z1234', 'Cicrana de Tal', 'CÃ´njuge', to_date('1988-12-11', 'yyyy-mm-dd'));

INSERT INTO brh.atribuicao (projeto, colaborador, papel) VALUES (1, 'Z1234', 2);


select*from brh.atribuicao where colaborador='Z1234';

--O resultado da consulta deve ser ordenado pelo nome doo departamento.
SELECT sigla, nome AS "NOME DO DEPARTAMENTO'"  FROM brh.departamento ORDER BY nome;

--Tarefa
--Crie uma consulta que liste:
--nome do colaborador;
--nome do dependente;
-- data de nascimento do dependente;
--parentesco do dependente.


SELECT brh.colaborador.nome, brh.dependente.nome, brh.dependente.data_nascimento, brh.dependente.parentesco 
FROM brh.colaborador 
FULL JOIN brh.dependente 
ON brh.colaborador .matricula = brh.dependente.colaborador 
WHERE brh.colaborador.nome > 'A' AND brh.dependente.nome >'A'
ORDER BY colaborador ASC;

--Remova o departamento SECAP da base de dados;
 
DELETE FROM brh.departamento WHERE sigla= 'SECAP';



select
brh.colaborador.nome,
brh.email_colaborador.email as "E-mail Corporativo",
brh.telefone_colaborador.numero as "Telefone Celular"
from brh.colaborador

inner join brh.email_colaborador
on brh.colaborador.matricula = brh.email_colaborador.colaborador
inner join brh.telefone_colaborador
on brh.colaborador.matricula = brh.telefone_colaborador.colaborador
where brh.email_colaborador.tipo = 'T' and
brh.telefone_colaborador.tipo = 'M'
ORDER BY brh.colaborador.nome;

--Criar uma consulta que liste os dependentes que nasceram em abril, maio ou junho, ou tenham a letra "h" no nome.;
--Ordene primeiramente pelo nome do colaborador, depois pelo nome do dependente.

select nome, data_nascimento, to_char(data_nascimento,' month') from brh.dependente
where(extract(month from data_nascimento)>=4 and extract(month from data_nascimento)<=6 )or( NOME like 'h' or NOME like 'H');

--Criar consulta que liste nome e o salário do colaborador com o maior salário;
--OBS.: A consulta deve ser flexível para continuar funcionando caso surja algum funcionário com salário maior que o do Zico.,


select nome, salario from brh.colaborador
order by salario desc;


--Criar uma consulta que liste a matrícula, nome, salário, e nível de senioridade do colaborador;
--Contexto
--A senioridade dos colaboradores é determinada a faixa salarial:

--´´Júnior: até R$ 3.000,00;
--Pleno: R$ 3.000,01 a R$ 6.000,00;
--Sênior: R$ 6.000,01 a R$ 20.000,00;
--Corpo diretor: acima de R$ 20.000,00
--Ordene a listagem por senioridade e por nome.

select
c.matricula, c.nome, c.salario,
(case when c.salario <= 3000 then 'Junior'
      when c.salario >= 3001 and c.salario <=6000 then 'Pleno'
      when c.salario >= 6001 and c.salario <=20000 then 'Senior'
      when c.salario > 20000 then 'Corpo diretor' end) as senioridade
from 
brh.colaborador c
order by senioridade, c.nome;

UPDATE brh.atribuicao SET projeto = 5 WHERE projeto = 1;
UPDATE brh.atribuicao SET projeto = 6 WHERE projeto = 2;
UPDATE brh.atribuicao SET projeto = 7 WHERE projeto = 3;
UPDATE brh.atribuicao SET projeto = 8 WHERE projeto = 4;

select * from brh.atribuicao;
select * from brh.projeto;
select * from brh.departamento;

--Criar consulta que liste o nome do departamento, nome do projeto e quantos colaboradores 
--daquele departamento fazem parte do projeto;

--Ordene a consulta pelo nome do departamento e nome do projeto.


select atr.projeto, count(*) as "qtd.total" 
from brh.atribuicao atr
group by projeto;

select distinct
 proj.nome, sum(atr.projeto) as "qtd.total"
from
brh.atribuicao atr
inner join
brh.projeto proj
on
proj.id = atr.projeto
group by proj.nome
;

--Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui;
--No relatório deve ter somente colaboradores com 2 ou mais dependentes.
--Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente.

SELECT 
    C.NOME,
    COUNT(*) AS "QTD DEPENDENTES"
FROM
    BRH.DEPENDENTE D
INNER JOIN
    BRH.COLABORADOR C ON D.COLABORADOR = C.MATRICULA
GROUP BY 
    C.NOME
HAVING (COUNT(*)) >= 2
ORDER BY
   "QTD DEPENDENTES" DESC, C.NOME;
--Criar consulta que liste o CPF do dependente, o nome do dependente, a data de nascimento (formato brasileiro), parentesco, 
--matrícula do colaborador, a idade do dependente e sua faixa etária;
--Se o dependente tiver menos de 18 anos, informar a faixa etária Menor de idade;
--Se o dependente tiver 18 anos ou mais, informar faixa etária Maior de idade;
--Ordenar consulta por matrícula do colaborador e nome do dependente.
SELECT 
    CPF,
    NOME AS "DEPENDENTE",
    TO_CHAR(DATA_NASCIMENTO,'DD/MM/YYYY') AS "DT NASCIMENTO",
    PARENTESCO,
    COLABORADOR AS "MATRICULA COLAB",
    TRUNC((MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO))/12) AS IDADE,
    CASE 
        WHEN (TRUNC((MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO))/12)) < 18 THEN 'MENOR DE IDADE'
        ELSE 'MAIOR DE IDADE'
    END AS "FAIXA ETARIA"
FROM 
    BRH.DEPENDENTE
ORDER BY
    COLABORADOR, NOME;
 

COMMIT;