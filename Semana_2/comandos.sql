    
   
select * from c##BRH.atribuicao;
select * from c##BRH.colaborador;
select * from c##BRH.endereco;
select * from c##BRH.departamento;
select * from c##BRH.DEPENDENTE;
select * from c##BRH.email_colaborador;
select * from c##BRH.papel;
select * from c##BRH.projeto;
select * from c##BRH.telefone_colaborador;


INSERT INTO c##brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco) VALUES ('A124', 'Fulano de Tal', '123.000.111.08', '5000', 'SEOPE', '71444-400', 'Area Residencial Nordeste - ARNE', 'Apto 606 - Ed Bonitao');
INSERT INTO c##brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 99999-9999', 'M'); 
INSERT INTO c##brh.telefone_colaborador (colaborador, numero, tipo) VALUES ('A124', '(61) 30304040', 'C'); 
INSERT INTO c##brh.email_colaborador (colaborador, email, tipo) VALUES ('A124', 'FULANO@email.com', 'P');
INSERT INTO c##brh.email_colaborador (colaborador, email, tipo) VALUES ('A124', 'FULANO@trabalho.com', 'T');
INSERT INTO c##brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('123.005.111-07', 'A124', 'Cicrana de Tal', 'Cônjuge', to_date('1970-01-01', 'yyyy-mm-dd'));
INSERT INTO c##brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento) VALUES ('123.006.111-07', 'A124', 'Beltrana de Tal', 'Filho(a)', to_date('2023-04-01', 'yyyy-mm-dd'));
INSERT INTO c##brh.projeto (id, nome, responsavel, inicio, fim) VALUES (5, 'BI', 'A124', to_date('2022-05-01', 'yyyy-mm-dd'), null);
INSERT INTO c##brh.atribuicao (projeto, colaborador, papel) VALUES (5, 'A124', 8);


//ROLLBACK;

select SIGLA, NOME from c##BRH.departamento;

//COORDENAR
select SIGLA, NOME from c##BRH.departamento ORDER BY NOME;

//COLABORADOR- DEPENDENTE

SELECT A.NOME AS NOME_COLABORADOR, b.nome AS NOME_DEPENDENTE FROM c##brh.colaborador A INNER JOIN c##brh.dependente B ON A.MATRICULA = b.colaborador;

//DATA PARENTESCO

SELECT A.NOME AS NOME_COLABORADOR, b.nome AS NOME_DEPENDENTE, b.data_nascimento, b.parentesco FROM c##brh.colaborador A INNER JOIN c##brh.dependente B ON A.MATRICULA = b.colaborador order by a.nome, b.nome;

//excluir

SELECT * FROM c##brh.departamento where sigla = 'SECAP';
DELETE FROM c##brh.departamento where sigla = 'SECAP';

//RELATORIO DE CONTATOS
SELECT a.nome as nome_colaborador, b.email, c.numero
FROM c##brh.colaborador a  
inner join c##brh.email_colaborador b 
on a.matricula = b.colaborador 
inner join c##brh.telefone_colaborador c 
on a.matricula = c.colaborador 
where b.tipo = 'T' and c.tipo = 'M';



