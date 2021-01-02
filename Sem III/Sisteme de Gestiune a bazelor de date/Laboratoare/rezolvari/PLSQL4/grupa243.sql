--6
CREATE OR REPLACE PROCEDURE f6_hco
AS
    faraAngajati EXCEPTION;
    ziMaxima NUMBER:=0;
    angZiMaxima NUMBER:= 0;
    angZiCurenta NUMBER:=0;
    nrRanduri NUMBER:=0;
    nrCrt NUMBER :=1;
    prev_vechime NUMBER:=0;
BEGIN
    FOR dept in (SELECT department_id,department_name FROM departments) LOOP
        DBMS_OUTPUT.PUT_LINE('' || dept.department_name);
        FOR i in '1'..'7' LOOP
            SELECT COUNT(*) INTO angZiCurenta
            FROM employees
            WHERE to_char(hire_date,'D') = i AND department_id = dept.department_id;
            IF angZiCurenta = 0 THEN
                --DBMS_OUTPUT.PUT_LINE('In ziua '|| i||' nu a fost angajat nimeni');
                -- nu am mai afisat asta pentru ca era destul de greu de citit output-ul
                CONTINUE;
            END IF;
            IF angZiCurenta > angZiMaxima THEN
                ziMaxima := i;
                angZiMaxima := angZiCurenta;
            END IF;
        END LOOP;
        IF ziMaxima = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu avem angajati in departament');
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ziua maxima ' || ziMaxima || ' cu angajatii: ');
        nrCrt:=0;
        prev_vechime := 0;
        for ang IN 
            (SELECT last_name,hire_date,salary 
             FROM employees 
             where to_char(hire_date,'D') = ziMaxima AND department_id = dept.department_id
             Order by hire_date ASC) LOOP
            if prev_vechime = 0 OR prev_vechime != ROUND(sysdate-ang.hire_date) THEN
               nrCrt:= nrCrt+1;
            END IF;
            DBMS_OUTPUT.PUT_LINE(nrCrt||' '||ang.last_name || ' ' || ROUND(sysdate-ang.hire_date) || ' '||ang.salary);
            prev_vechime:= ROUND(sysdate-ang.hire_date);
            nrRanduri:=nrRanduri+1;
        END LOOP;
        
        ziMaxima:=0;
        angZiMaxima:= 0;
    END LOOP;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'SELECT',nrRanduri,'Fara erori');
    
END;
/
EXECUTE f6_hco;


SELECT last_name, to_char(hire_date,'D') FROM employees;
SELECT * FROM job_history;
--5b (cu job_history)
CREATE OR REPLACE PROCEDURE f5_hco
AS
    faraAngajati EXCEPTION;
    ziMaxima NUMBER:=0;
    angZiMaxima NUMBER:= 0;
    angZiCurenta NUMBER:=0;
    nrRanduri NUMBER:=0;
BEGIN
    FOR dept in (SELECT department_id FROM departments) LOOP
        DBMS_OUTPUT.PUT_LINE('' || dept.department_id);
        FOR i in '1'..'7' LOOP
            SELECT COUNT(*) INTO angZiCurenta
            FROM employees e LEFT JOIN job_history j ON(e.employee_id = j.employee_id) 
            WHERE to_char(hire_date,'D') = i AND e.department_id = dept.department_id;
            IF angZiCurenta = 0 THEN
                DBMS_OUTPUT.PUT_LINE('In ziua '|| i||' nu a fost angajat nimeni');
                CONTINUE;
            END IF;
            IF angZiCurenta > angZiMaxima THEN
                ziMaxima := i;
                angZiMaxima := angZiCurenta;
            END IF;
        END LOOP;
        IF ziMaxima = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu avem angajati in departament');
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ziua maxima ' || ziMaxima || ' cu angajatii: ');
        for ang IN 
            (SELECT last_name,hire_date,salary 
             FROM employees 
             where to_char(hire_date,'D') = ziMaxima AND department_id = dept.department_id) LOOP
            DBMS_OUTPUT.PUT_LINE(ang.last_name || ' ' || ROUND(sysdate-ang.hire_date) || ' '||ang.salary);
            nrRanduri:=nrRanduri+1;
        END LOOP;
        
        ziMaxima:=0;
        angZiMaxima:= 0;
    END LOOP;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'SELECT',nrRanduri,'Fara erori');
    
END;
/
EXECUTE f5_hco;


--5
CREATE OR REPLACE PROCEDURE f5_hco
AS
    faraAngajati EXCEPTION;
    ziMaxima NUMBER:=0;
    angZiMaxima NUMBER:= 0;
    angZiCurenta NUMBER:=0;
    nrRanduri NUMBER:=0;
BEGIN
    FOR dept in (SELECT department_id,department_name FROM departments) LOOP
        DBMS_OUTPUT.PUT_LINE('' || dept.department_name);
        FOR i in '1'..'7' LOOP
            SELECT COUNT(*) INTO angZiCurenta
            FROM employees
            WHERE to_char(hire_date,'D') = i AND department_id = dept.department_id;
            IF angZiCurenta = 0 THEN
                --DBMS_OUTPUT.PUT_LINE('In ziua '|| i||' nu a fost angajat nimeni');
                -- in cazul in care nu e numeni angajat intr-o anumita zi dintr-un departament
                CONTINUE;
            END IF;
            IF angZiCurenta > angZiMaxima THEN
                ziMaxima := i;
                angZiMaxima := angZiCurenta;
            END IF;
        END LOOP;
        IF ziMaxima = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu avem angajati in departament');
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ziua maxima ' || ziMaxima || ' cu angajatii: ');
        for ang IN 
            (SELECT last_name,hire_date,salary 
             FROM employees 
             where to_char(hire_date,'D') = ziMaxima AND department_id = dept.department_id) LOOP
            DBMS_OUTPUT.PUT_LINE(ang.last_name || ' ' || ROUND(sysdate-ang.hire_date) || ' '||ang.salary);
            nrRanduri:=nrRanduri+1;
        END LOOP;
        
        ziMaxima:=0;
        angZiMaxima:= 0;
    END LOOP;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'SELECT',nrRanduri,'Fara erori');
    
END;
/
EXECUTE f5_hco;
--4
CREATE OR REPLACE PROCEDURE f4_hco
    (mng employees.manager_id%TYPE)
AS
    personsManaged NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO personsManaged
    FROM employees
    WHERE manager_id = mng;
    if personsManaged = 0 THEN
        INSERT INTO info_hco
        VALUES(USER,SYSDATE,'UPDATE',0,'Nu exista manager cu id-ul dat');
        RAISE NO_DATA_FOUND;
    END IF;
    UPDATE emp_hco
    SET salary = salary * 1.1
    WHERE manager_id = mng;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'UPDATE',personsManaged,'Fara erori');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Mangerul cu id-ul specificat nu exista');
     WHEN OTHERS THEN
            INSERT INTO info_hco
            VALUES (USER, SYSDATE, 'UPDATE', 0 , 'Alta eroare');
END f4_hco;
/


SELECT employee_id,salary,manager_id FROM emp_hco WHERE manager_id=101;
EXECUTE f4_hco(101);
SELECT employee_id,salary,manager_id FROM emp_hco WHERE manager_id=101;


SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM departments;
SELECT * FROM locations;
--3
CREATE OR REPLACE FUNCTION f3_hco
    (oras locations.city%type)
RETURN NUMBER IS
    TYPE ang IS TABLE of employees%ROWTYPE;
    angajati ang;
    nr NUMBER:=0;
    nr_jobs NUMBER(10);
BEGIN
    -- nu avem orasul
    SELECT COUNT(*) into nr_jobs FROM locations
    WHERE city = oras;
    IF sql%ROWCOUNT = 0 THEN
        INSERT INTO info_hco
        VALUES (USER,SYSDATE,'SELECT',nr,'Nu exista orasul specificat');
        raise NO_DATA_FOUND;
    END IF;
    -- nu lucreaza nimeni
    SELECT employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,e.manager_id,e.department_id BULK COLLECT INTO angajati 
    FROM employees e JOIN departments d ON (d.department_id = e.department_id)
        JOIN locations l ON (l.location_id = d.location_id)
    WHERE city = oras;
    
    IF sql%rowcount = 0 THEN
        INSERT INTO info_hco
        VALUES (USER,SYSDATE,'SELECT',nr,'Nu lucreaza oameni in orasul specificat');
        raise NO_DATA_FOUND;
    END IF;
    
    for i in angajati.FIRST..angajati.LAST LOOP
        SELECT COUNT(DISTINCT(job_id)) INTO nr_jobs
        FROM job_history 
        where employee_id = angajati(i).employee_id;
        IF  nr_jobs >= 2 THEN
            nr := nr +1;
        END IF;
        nr_jobs :=0;
    END LOOP;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'SELECT',nr,'Fara erori');
    RETURN nr;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu am gasit angajati in orasu specificat');
     WHEN OTHERS THEN         
            INSERT INTO info_hco
            VALUES (USER, SYSDATE, 'UPDATE', 0 , 'Alta eroare');
END f3_hco;
/
DECLARE 
    sal NUMBER;
BEGIN
    sal := f3_hco('Seattle');
    DBMS_OUTPUT.PUT_LINE(sal);
END;
/


SELECT * FROM info_hco;

create or REPLACE FUNCTION f2_hco
    (v_nume employees.last_name%TYPE DEFAULT 'Bell')
RETURN NUMBER IS
    nr NUMBER := 0;
    salariu employees.salary%type;
    mesaj VARCHAR2(500);
BEGIN
    SELECT salary INTO salariu
    FROM employees
    WHERE UPPER(last_name) = UPPER(v_nume);
    nr := SQL%ROWCOUNT;
    INSERT INTO info_hco
    VALUES (USER,SYSDATE,'SELECT',nr,'Fara erori');
    RETURN salariu;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        nr:= SQL%ROWCOUNT;
        INSERT INTO info_hco
        VALUES (USER,SYSDATE,'SELECT',nr,'Nu exista angajati cu numele dat');
        RETURN -1;
    WHEN TOO_MANY_ROWS THEN
        nr:= SQL%ROWCOUNT;
        mesaj:= SQLCODE|| ' ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(MESAJ);
        INSERT INTO info_hco
        VALUES (USER, SYSDATE, 'SELECT', nr, mesaj);
            RETURN -2;
            --RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');

    WHEN OTHERS THEN
        mesaj := SQLERRM;
        INSERT INTO info_hco
        VALUES (USER, SYSDATE, 'SELECT', nr, mesaj);
                --RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
        RETURN -3;
END f2_hco;
/

DROP table info_hco;

CREATE TABLE info_hco(
--    ID NUMBER(10, 2) PRIMARY KEY,
    utilizator VARCHAR2(50),
    data TIMESTAMP,
    comanda VARCHAR2(100),
    nr_linii NUMBER,
    eroare VARCHAR2(50));