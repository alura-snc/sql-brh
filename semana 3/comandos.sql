---Filtrar dependentes---
---Tarefa 1--Filtrar dependente---

select c.nome COLABORADOR,d.nome DEPENDENTE,d.data_nascimento DATA_NASCIMENTO
from dependente d
inner join colaborador c on d.colaborador=c.matricula
WHERE extract(month from d.data_nascimento) in (4,5,6) --OR extract(month from d.data_nascimento) in (6) 
OR d.nome like '%h%'
order by c.nome,d.nome

---Tarefa 2----Listar Colaborador com maior salário--
select nome,salario from colaborador
where salario =(select max(salario)from colaborador)

commit

---Tarefa 3-----Relatório de  Senioridade--
  
select matricula,nome,salario,
Case 
    when salario <=3000 then 'Junior'
    when salario <=6000 then 'Plano'
    when salario <=20000 then 'Sênio'
    else 
    'Corpo Diretor'
    end  Senioridade
    from colaborador 
    order by Senioridade,nome

---Tarefa 4---Listar Colaboradores em Projetos-------

select d.nome as Departamento,p.nome as Projeto,count(colaborador) as QTD_Colaboradores
from colaborador c
inner join departamento d on c.departamento=d.sigla
inner join atribuicao a on c.matricula=a.colaborador
inner join projeto  p on a.projeto=p.id
group by d.nome,p.nome
order by d.nome,p.nome

---Tarefa 5-lISTAR COLABORADOR COM MAIS DEPENDENTE--
  
select c.nome COLABORADOR,count(d.colaborador)as QUANTIDADE_DEPENDENTE 
from COLABORADOR c
INNER JOIN DEPENDENTE D ON C.MATRICULA=D.COLABORADOR
group by c.nome,d.colaborador
having count(d.colaborador) > 1
order by QUANTIDADE_DEPENDENTE desc ,c.nome asc 


---Tarefa 6- Listar faixa etária dos dependentes--

SELECT 
d.cpf,
d.nome DEPENDENTE,
to_char(d.data_nascimento,'dd/mm/yyyy') DATA_NASCIMENTO,
d.parentesco,
d.colaborador Matricula_Colaborador,(extract(YEAR FROM SYSDATE)-extract(YEAR FROM d.data_nascimento)) IDADE, 
Case 
    when (extract(YEAR FROM SYSDATE)-extract(YEAR FROM d.data_nascimento)) >= 18 then 'MAIOR DE IDADE'
    else 
    'MENOR DE IDADE'
    end as IDADE
from dependente d
inner join colaborador c on d.colaborador=c.matricula
order by c.matricula,d.nome

------7 -----RELATÓRIO PLANO DE SAÚDE------------------------------------------------------------------------------

CREATE VIEW VW_CUSTO_CONV_NIVEL AS
SELECT CONV.MATRICULA,CONV.NIVEL,CONV.SALARIO,CONV.VALOR_CONVENIO
FROM
(
SELECT C.MATRICULA MATRICULA,
CASE WHEN SALARIO <=3000 THEN 'JUNIOR'
     WHEN SALARIO <=6000 THEN 'PLENO'
     WHEN SALARIO <=10000 THEN 'SENIOR'
     ELSE 'CORPO DIRETOR'
     END NIVEL,
     C.SALARIO,     
     CASE WHEN SALARIO <=3000 THEN (SALARIO*1)/100
     WHEN SALARIO <=6000 THEN (SALARIO*2)/100
     WHEN SALARIO <=10000 THEN (SALARIO*3)/100
     ELSE (SALARIO*5)/100
     END VALOR_CONVENIO,D.PARENTESCO,
     Case WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM d.data_nascimento)) >= 18  AND PARENTESCO='Filho(a)' THEN '50'
     WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM d.data_nascimento)) <= 18  AND PARENTESCO='Filho(a)' THEN '25'
       WHEN  PARENTESCO='Conjuge' THEN '100'
    ELSE 
    '0'
    END CUSTO_DEPENTENTE
FROM COLABORADOR C
LEFT JOIN DEPENDENTE D ON C.MATRICULA=D.COLABORADOR
ORDER BY C.NOME
)CONV
GROUP BY CONV.MATRICULA,CONV.NIVEL,CONV.SALARIO,VALOR_CONVENIO


COMMIT


CREATE VIEW VW_CUSTO_CONV_DEPENDENTE AS
SELECT CONVDEP.MATRICULA MATRICULA,SUM(CONVDEP.CUSTO_DEPENTENTE) CUSTO_POR_DEP
FROM
(SELECT  C.MATRICULA,D.PARENTESCO,CASE WHEN SALARIO <=3000 THEN (SALARIO*1)/100
     WHEN SALARIO <=6000 THEN (SALARIO*2)/100
     WHEN SALARIO <=10000 THEN (SALARIO*3)/100
     ELSE (SALARIO*5)/100
     END VALOR_CONVENIO,
     Case WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM d.data_nascimento)) >= 18  AND PARENTESCO='Filho(a)' THEN '50'
     WHEN (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM d.data_nascimento)) <= 18  AND PARENTESCO='Filho(a)' THEN '25'
       WHEN  PARENTESCO='Cônjuge' THEN '100'
    ELSE 
    '0'
    END CUSTO_DEPENTENTE
FROM COLABORADOR C
LEFT JOIN DEPENDENTE D ON C.MATRICULA=D.COLABORADOR
)CONVDEP
GROUP BY MATRICULA


SELECT VWCN.MATRICULA MATRICULA ,VWCN.NIVEL,VWCN.SALARIO,VWCN.VALOR_CONVENIO,VWCD.CUSTO_POR_DEP CUSTO_DEPENTENDES,SUM(VWCN.VALOR_CONVENIO + VWCD.CUSTO_POR_DEP)TOTAL_CUSTO_CONVENIO
FROM VW_CUSTO_CONV_NIVEL VWCN
INNER JOIN VW_CUSTO_CONV_DEPENDENTE VWCD
ON VWCN.MATRICULA=VWCD.MATRICULA
GROUP BY VWCN.MATRICULA,VWCN.NIVEL,VWCN.SALARIO,VWCN.VALOR_CONVENIO,VWCD.CUSTO_POR_DEP

----8--------------Listar colaboradores que participaram de todos os projetos--------------------------------------------------------------------
SELECT DISTINCT(C.NOME)
FROM COLABORADOR C
WHERE C.MATRICULA IN (SELECT P.RESPONSAVEL FROM PROJETO P) 

INSERT INTO PROJETO (NOME,RESPONSAVEL,INICIO,FIM) VALUES ('SENAC','K123','27/02/24','')
