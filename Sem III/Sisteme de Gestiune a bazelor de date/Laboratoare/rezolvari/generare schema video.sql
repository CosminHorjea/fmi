--Laborator PL/SQL 1

--2
<< principal >> 
DECLARE
    v_client_id       NUMBER(4) := 1600;
    v_client_nume     VARCHAR2(50) := 'N1';
    v_nou_client_id   NUMBER(3) := 500;
BEGIN
    << secundar >> 
    DECLARE
        v_client_id         NUMBER(4) := 0;
        v_client_nume       VARCHAR2(50) := 'N2';
        v_nou_client_id     NUMBER(3) := 300;
        v_nou_client_nume   VARCHAR2(50) := 'N3';
    BEGIN
        v_client_id := v_nou_client_id;
        principal.v_client_nume := v_client_nume
                                   || ' '
                                   || v_nou_client_nume;
--poziția 1
        DBMS_OUTPUT.PUT_LINE('Poz1 ' || v_client_id);
        DBMS_OUTPUT.PUT_LINE(v_client_nume);
        DBMS_OUTPUT.PUT_LINE(v_nou_client_id);
        DBMS_OUTPUT.PUT_LINE(v_nou_client_nume);
    END;

    v_client_id := ( v_client_id * 12 ) / 10;
--poziția 2
    DBMS_OUTPUT.PUT_LINE(v_client_id);
    DBMS_OUTPUT.PUT_LINE(v_client_nume);
END;
/

--3
--varianta 1
VARIABLE g_mesaj VARCHAR2(50)
BEGIN
      :g_mesaj := 'Invat PL/SQL';
END;
/
PRINT g_mesaj

--varianta 2
BEGIN
    DBMS_OUTPUT.PUT_LINE('Invat PL/SQL');
END;
/

--4
DECLARE
    v_dep departments.department_name%TYPE;
BEGIN
    SELECT department_name
    INTO v_dep
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                        FROM employees
                        GROUP BY department_id);
    DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep);
END;
/

--5
VARIABLE rezultat VARCHAR2(35)
BEGIN
    SELECT department_name
    INTO :rezultat
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                        FROM employees
                        
                        GROUP BY department_id);

    DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat);
END;
/
PRINT rezultat

--6
DECLARE
    v_dep departments.department_name%TYPE;
    v_nr NUMBER;
BEGIN
    SELECT department_name, COUNT(*)
    INTO v_dep, v_nr
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                        FROM employees
                        GROUP BY department_id);
    DBMS_OUTPUT.PUT('Departamentul '|| v_dep);
    DBMS_OUTPUT.PUT_LINE(' are '|| v_nr || ' angajati');
END;
/

--7
SET VERIFY OFF
DECLARE
    v_cod employees.employee_id%TYPE:=&p_cod;
    v_bonus NUMBER(8);
    v_salariu_anual NUMBER(8);
BEGIN
    SELECT salary*12 INTO v_salariu_anual
    FROM employees
    WHERE employee_id = v_cod;
    IF v_salariu_anual>=200001
        THEN v_bonus:=20000;
    ELSIF v_salariu_anual BETWEEN 100001 AND 200000
        THEN v_bonus:=10000;
    ELSE v_bonus:=5000;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
/
SET VERIFY ON

SELECT *
FROM employees;

--8
DECLARE
    v_cod employees.employee_id%TYPE:=&p_cod;
    v_bonus NUMBER(8);
    v_salariu_anual NUMBER(8);
BEGIN
    SELECT salary*12 INTO v_salariu_anual
    FROM employees
    WHERE employee_id = v_cod;
    CASE WHEN v_salariu_anual>=200001
        THEN v_bonus:=20000;
    WHEN v_salariu_anual BETWEEN 100001 AND 200000
        THEN v_bonus:=10000;
    ELSE v_bonus:=5000;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
/

--9
DEFINE p_cod_sal= 200
DEFINE p_cod_dept = 80
DEFINE p_procent =20
DECLARE
    v_cod_sal emp_prof.employee_id%TYPE:= &p_cod_sal;
    v_cod_dept emp_prof.department_id%TYPE:= &p_cod_dept;
    v_procent NUMBER(8):=&p_procent;
BEGIN
    UPDATE emp_prof
    SET department_id = v_cod_dept,
    salary=salary + (salary* v_procent/100)
    WHERE employee_id= v_cod_sal;
    
    IF SQL%ROWCOUNT =0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista un angajat cu acest cod');
    ELSE DBMS_OUTPUT.PUT_LINE('Actualizare realizata');
    END IF;
END;
/
ROLLBACK;

SELECT department_id, salary
FROM emp_prof
WHERE employee_id = 200;

--10
CREATE TABLE zile_prof (
    id NUMBER(5) PRIMARY KEY,
    data DATE,
    nume_zi VARCHAR2(50)
);

DECLARE
    contor NUMBER(6) := 1;
    v_data DATE;
    maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
    LOOP
        v_data := sysdate+contor;
        INSERT INTO zile_prof
        VALUES (contor,v_data,to_char(v_data,'Day'));
        contor := contor + 1;
        EXIT WHEN contor > maxim;
    END LOOP;
END;
/

SELECT *
FROM zile_prof;

--11
DECLARE
    contor NUMBER(6) := 1;
    v_data DATE;
    maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
    WHILE contor <= maxim LOOP
        v_data := sysdate+contor;
        INSERT INTO zile_prof
        VALUES (contor,v_data,to_char(v_data,'Day'));
        contor := contor + 1;
    END LOOP;
END;
/
ROLLBACK;

--12
DECLARE
    v_data DATE;
    maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
    FOR contor IN 1..maxim LOOP
        v_data := sysdate+contor;
        INSERT INTO zile_prof
        VALUES (contor,v_data,to_char(v_data,'Day'));
    END LOOP;
END;
/

--13
--var 1
DECLARE
    i POSITIVE:=1;
    max_loop CONSTANT POSITIVE:=10;
BEGIN
    LOOP
        i:=i+1;
        IF i>max_loop THEN
            DBMS_OUTPUT.PUT_LINE('in loop i=' || i);
            GOTO urmator;
        END IF;
    END LOOP;
    <<urmator>>
    i:=1;
    DBMS_OUTPUT.PUT_LINE('dupa loop i=' || i);
END;
/

--var2
DECLARE
    i POSITIVE:=1;
    max_loop CONSTANT POSITIVE:=10;
BEGIN
    i:=1;
    LOOP
        i:=i+1;
        DBMS_OUTPUT.PUT_LINE('in loop i=' || i);
        EXIT WHEN i>max_loop;
    END LOOP;
    i:=1;
    DBMS_OUTPUT.PUT_LINE('dupa loop i=' || i);
END;
/

--exercitiu
BEGIN
    DBMS_OUTPUT.PUT('CEVA');
    DBMS_OUTPUT.PUT_LINE('GFJHGHJ');
    DBMS_OUTPUT.PUT(' CEVAJDFNBHFJDGH');
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT(' JDF');
END;
/

--TEMA 1, 2, 3, 4, 5 (EXERCITII) JOS
