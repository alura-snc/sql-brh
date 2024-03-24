-- SEMANA 2
--Novos cadastros
INSERT INTO
    papel (id, nome)
VALUES
    (8, 'Especialista de Negócios');

INSERT INTO
    endereco (cep, uf, cidade, bairro)
VALUES
    ('11111-231', 'SP', 'São Paulo', 'Jardim Flora');

INSERT INTO
    colaborador (
        matricula,
        nome,
        cpf,
        salario,
        departamento,
        cep,
        logradouro,
        complemento_endereco
    )
VALUES
    (
        'A001',
        'Fulano',
        '123.456.789-10',
        '78055',
        'DIR',
        '11111-231',
        'Rua dos Perdidos',
        'Jardim Flora'
    );

INSERT INTO
    telefone_colaborador (colaborador, numero, tipo)
VALUES
    ('A001', '(61) 99999-9999', 'M');

INSERT INTO
    telefone_colaborador (colaborador, numero, tipo)
VALUES
    ('A001', '(61) 3030-4040', 'R');

INSERT INTO
    email_colaborador (colaborador, email, tipo)
VALUES
    ('A001', 'fulano@email.com', 'P');

INSERT INTO
    email_colaborador (colaborador, email, tipo)
VALUES
    ('A001', 'fulano.tal@brh.com', 'T');

INSERT INTO
    projeto (nome, responsavel, inicio, fim)
VALUES
    (
        'BI',
        'B123',
        to_date('2023-09-24', 'yyyy-mm-dd'),
        null
    );

INSERT INTO
    dependente (
        cpf,
        colaborador,
        nome,
        parentesco,
        data_nascimento
    )
VALUES
    (
        '333.444.555-06',
        'A001',
        'Beltrana',
        'Filho(a)',
        to_date('2010-04-15', 'yyyy-mm-dd')
    );

INSERT INTO
    dependente (
        cpf,
        colaborador,
        nome,
        parentesco,
        data_nascimento
    )
VALUES
    (
        '222.123.787-09',
        'A001',
        'Cicrana',
        'Cônjuge',
        to_date('1980-01-20', 'yyyy-mm-dd')
    );

INSERT INTO
    atribuicao (projeto, colaborador, papel)
VALUES
    (9, 'A001', 8);

-- Relatório de Departamentos
SELECT
    *
from
    departamento
order by
    departamento.nome;

-- Relatório de Departamentos
select
    *
from
    colaborador
where
    cep = '71777-700'
    and departamento in ('SECAP', 'SESEG');

-- Excluir departamento SECAP
delete from
    departamento
where
    sigla = 'SECAP';

-- Relatório de contatos
select
    colaborador.nome,
    email_colaborador.email,
    telefone_colaborador.numero
from
    colaborador
    inner join email_colaborador on colaborador.matricula = email_colaborador.colaborador
    inner join telefone_colaborador on colaborador.matricula = telefone_colaborador.colaborador
where
    email_colaborador.tipo = 'T'
    and telefone_colaborador.tipo = 'M'
order by
    colaborador.nome;

--Relatório de dependentes
select
    c.nome as "Colaborador",
    d.nome as "Dependente",
    d.data_nascimento,
    d.parentesco
from
    colaborador c
    inner join dependente d on c.matricula = d.colaborador
order by
    c.nome,
    d.nome;

-- Desafio relatório analítico de equipes
select
    d.nome as departamento,
    d.chefe as chefe_departamento,
    c.nome as colaborador,
    t.numero as telefone_colaborador,
    p.nome as projeto,
    pa.nome as papel,
    de.nome as dependente
FROM
    departamento d
    inner join colaborador c on d.sigla = c.departamento
    inner join telefone_colaborador t on c.matricula = t.colaborador
    inner join atribuicao a on c.matricula = a.colaborador
    inner join projeto p on a.projeto = p.id
    inner join papel pa on a.papel = pa.id
    left join dependente de on c.matricula = de.colaborador
order by
    p.nome,
    c.nome,
    d.nome;

-- Atualizar cadastro de colaborador
update
    colaborador
set
    nome = 'Maria Mendonça'
where
    matricula = 'M123';

-- Relatório de cônjuges
select
    colaborador as matricula,
    nome,
    data_nascimento,
    parentesco
from
    dependente
where
    parentesco = 'Cônjuge';

-- Relatório de contatos telefônicos
select
    colaborador,
    numero
from
    telefone_colaborador
where
    tipo in ('M', 'C')
order by
    colaborador,
    numero desc;

-- Atualizar e-mails de colaborador
select
    *
from
    email_colaborador
where
    colaborador = 'M123'
    and tipo = 'p';
    
update
    email_colaborador
set
    email = 'maria.mendonca@email.com'
where
    colaborador = 'M123'
    and tipo = 'p';