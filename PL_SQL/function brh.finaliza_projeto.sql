



CREATE OR REPLACE FUNCTION brh.finaliza_projeto(p_id NUMBER)
RETURN DATE
IS
    v_data_finalizacao DATE;
BEGIN
    -- Obtém a data e hora atuais
    v_data_finalizacao := SYSDATE;
    
    -- Atualiza a data de finalização do projeto
    UPDATE brh.projeto
    SET fim = v_data_finalizacao
    WHERE id = p_id;
    
    -- Retorna a data de finalização atribuída ao projeto
    RETURN v_data_finalizacao;
EXCEPTION
    WHEN OTHERS THEN
        -- Trate exceções, se necessário
        -- Faça um ROLLBACK em caso de erro
        ROLLBACK;
END;







DECLARE
    v_data_finalizacao DATE;
BEGIN
    v_data_finalizacao := brh.finaliza_projeto(27); -- Substitua 27 pelo ID do projeto que deseja finalizar.
    DBMS_OUTPUT.PUT_LINE('Data de Finalização: ' || TO_CHAR(v_data_finalizacao, 'YYYY-MM-DD HH24:MI:SS'));
END;



DECLARE
    v_finalizacao DATE;
BEGIN
    v_finalizacao := brh.finaliza_projeto(27); -- Substitua 1 pelo ID do projeto desejado
    DBMS_OUTPUT.PUT_LINE('Data de finalização do projeto: ' || TO_CHAR(v_finalizacao, 'DD-MM-YYYY HH24:MI:SS'));
    COMMIT; -- Confirmar as alterações
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        ROLLBACK;
END;
