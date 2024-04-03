--CURSORES

set serveroutput on;

--cursor nome_curso is select colun1_, coluna2_ from nome_tabela;

--open, fetch e close.

--rowtype tambem transfere dados.

-- nome_do_cursor %found, %notfound, %rowcount, %isopen

-------------------------------------------------------------------------------
--EX1
drop table funcionarios cascade constraints;
create table funcionarios (cd_fun char(3) PRIMARY KEY,
                          nm_fun varchar2(50),
                          salario number(6,2),
                          dt_admissao date);
            
begin
    INSERT INTO FUNCIONARIOS VALUES (1, 'MARCEL', 1000, '04-04-2000');
    INSERT INTO FUNCIONARIOS VALUES (2, 'CLAUDIA', 16000, '02-10-1998');
    INSERT INTO FUNCIONARIOS VALUES (3, 'JOAQUIM', 5500, '10-07-2010');
    INSERT INTO FUNCIONARIOS VALUES (4, 'VALERIA', 7300, '08-06-2015');
END;

DECLARE
    CURSOR c_EXIBIR IS SELECT NM_FUN, SALARIO FROM FUNCIONARIOS;
    v_exibir c_exbir%rowtype;
BEGIN
    open c_exibir;
    
    loop 
        fetch c_exibir into v_exibir;
    exit when c_exibir %notfound;
    dbms_output.put_line('Nome: ' || v_exibir.nm_fun || ' - salario: ' || v_exibir.salario);
    end loop;
    close c_exibir;
    
END;

--Usando FOR

DECLARE
    CURSOR c_EXIBIR IS SELECT NM_FUN, SALARIO FROM FUNCIONARIOS;
    
BEGIN
    For v_exibir in c_exibir loop
        dbms_output.put_line('Nome: ' || v_exibir.nm_fun || ' - salario: ' || v_exibir.salario);
        
    end loop;
end;
-------------------------------------------------------------------------------
--ex2
alter tABLE FUNCIONARIOS ADD TEMPO NUMBER(9);

declare
    V_tempo number(9);
    v_dt_admissao date;
    v_cd_fun number(9);
begin
    select dt_admissao into v_dt_admissao from funcionarios;
    v_tempo := sysdate - v_tempo;
    update funcionarios set tempo = v_tempo where cd_fun = v_cd_fun;
end;

-- o msm

DECLARE
    CURSOR c_EXIBIR IS SELECT NM_FUN, SALARIO FROM FUNCIONARIOS;
    
BEGIN
    For v_exibir in c_exibir loop
        update funcionario set tempo = sysdate - v_exibir.dt_adm 
        where cd_fun = v_exibir.cd_fun;
    end loop;
    end;
--PARA FUNCIONARIOS COM TEMPO SUPERIOR OU IGUAL A 150 MESES, + 10% AO SALARIO, PARA O RESTANTE 5% 

DECLARE
    CURSOR C_CALCULAR_SAL IS SELECT * FROM FUNCIONARIOS;
    V_TEMPO_MESES number(9);
    V_SALARIO_ANTIGO number(6,2);
BEGIN
    
    for v_exibir in c_exibir loop
       if MONTHS_BETWEEN( sysdate, v_exibir.dt_admissao ) >= 150 then
        update funcionario set salario = salario * 1.1 where cd_fun - v_exibir.cd_fun;
        else
        update funcionario set salario = salario * 1.05 where cd_fun - v_exibir.cd_fun;
    end if;
    end loop;
    
END;