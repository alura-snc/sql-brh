-- Remover Atribuições
DELETE FROM C##brh.ATRIBUICAO WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover Dependentes
DELETE FROM C##brh.DEPENDENTE WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover Telefones
DELETE FROM C##brh.TELEFONE_COLABORADOR WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover E-mails
DELETE FROM C##brh.EMAIL_COLABORADOR WHERE colaborador IN (SELECT matricula FROM C##brh.COLABORADOR WHERE departamento = 'SECAP');
-- Remover colaboradores (não deve ser a tabela TELEFONE_COLABORADOR)
DELETE FROM C##brh.COLABORADOR WHERE departamento = 'SECAP';
-- Remover Departamento
DELETE FROM C##brh.DEPARTAMENTO WHERE sigla = 'SECAP';
