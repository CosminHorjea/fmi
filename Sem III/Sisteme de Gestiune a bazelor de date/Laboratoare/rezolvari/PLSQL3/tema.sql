SELECT * FROM employees;
SELECT * FROM jobs;
SELECT SUM(salary + salary*NVL(commission_pct,0)) FROM employees;
--1
--cursor clasic
DECLARE
    current_id jobs%ROWTYPE;
    current_employee employees%ROWTYPE;
    CURSOR c IS
        SELECT *
        FROM jobs;
    CURSOR angajati(j jobs.job_id%TYPE) IS
        SELECT *
        FROM employees
        WHERE job_id = j;
BEGIN
    open c;
    LOOP
        FETCH c into current_id;
        EXIT WHEN c%NOTFOUND;
        DBMS_output.PUT_line('\\ '||current_id.job_title);
        open angajati(current_id.job_id);
        LOOP
            FETCH angajati into current_employee;
            EXIT WHEN angajati%notfound;
            DBMS_output.PUT_line(current_employee.last_name || ' ' || current_employee.salary);
            
        END LOOP;
        close angajati;
    END LOOP;
    close c;    
END;
/
--ciclu cursor
DECLARE
    current_id jobs%ROWTYPE;
    current_employee employees%ROWTYPE;
    CURSOR c IS
        SELECT *
        FROM jobs;
    CURSOR angajati(j jobs.job_id%TYPE) IS
        SELECT *
        FROM employees
        WHERE job_id = j;
BEGIN
    FOR i in c LOOP
        DBMS_output.PUT_line('\\ '||i.job_title);
        
        for j in angajati(i.job_id) LOOP
            DBMS_output.PUT_line(j.last_name|| ' ' || j.salary);
        END LOOP;
    END LOOP;
END;
/
--ciclu cursor cu subcereri
DECLARE
    current_id jobs%ROWTYPE;
    current_employee employees%ROWTYPE;
    CURSOR c IS
        SELECT *
        FROM jobs;
    CURSOR angajati(j jobs.job_id%TYPE) IS
        SELECT *
        FROM employees
        WHERE job_id = j;
BEGIN
    FOR i in (SELECT * FROM jobs) LOOP
        DBMS_output.PUT_line('\\ '||i.job_title);
        
        for j in (SELECT * FROM employees WHERE job_id = i.job_id) LOOP
            DBMS_output.PUT_line(j.last_name || ' ' || j.salary);
        END LOOP;
    END LOOP;
END;
/
--expresii cursor
DECLARE
    current_id jobs.JOB_TITLE%TYPE;
    current_employee employees%ROWTYPE;
    TYPE refcursor IS REF CURSOR;
    CURSOR c IS
        SELECT job_title ,
            CURSOR (SELECT * FROM employees e
                    WHERE e.job_id = j.job_id)            
        FROM jobs j;
     v_cursor refcursor;
BEGIN
    open c;
    LOOP
        FETCH c into current_id,v_cursor;
        exit when c%notfound;
        dbms_output.put_line('\\'||current_id);
        LOOP
            FETCH v_cursor into current_employee;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_output.put_line(current_employee.last_name || ' ' || current_employee.salary);
        END LOOP;
    END LOOP;
    close c;
END;
/
--2
DECLARE
    current_id jobs%ROWTYPE;
    current_employee employees%ROWTYPE;
    CURSOR c IS
        SELECT *
        FROM jobs;
    CURSOR angajati(j jobs.job_id%TYPE) IS
        SELECT *
        FROM employees
        WHERE job_id = j;
    allSalaries  NUMBER(10):=0;
    jobSalaries  NUMBER(10):=0;
    allEmployees NUMBER(10) :=0;
BEGIN
    open c;
    LOOP
        FETCH c into current_id;
        EXIT WHEN c%NOTFOUND;
        DBMS_output.PUT_line('\\ '||current_id.job_title);
        open angajati(current_id.job_id);
        jobSalaries:=0;
        LOOP    
            
            FETCH angajati into current_employee;
            EXIT WHEN angajati%notfound;
            jobSalaries := jobSalaries+current_employee.salary;
            DBMS_output.PUT_line(angajati%ROWCOUNT||' '||current_employee.last_name || ' ' || current_employee.salary);
            
        END LOOP;
        IF angajati%rowcount = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu lucreaza nimeni in acest departament');
        ELSE
            DBMS_OUTPUT.Put_LINE('Numar angajati: '|| angajati%ROWCOUNT);
            DBMS_OUTPUT.Put_LINE('Valaure lunara venituri: '||jobSalaries);
            DBMS_OUTPUT.Put_LINE('Valoare Medie: '|| ROUND(jobSalaries /(angajati%ROWCOUNT),2));
            allSalaries := allSalaries + jobSalaries;
            allEmployees := allEmployees + angajati%ROWCOUNT;
        END IF;
        close angajati;
    END LOOP;
    close c;    
    DBMS_OUTPUT.PUT_LINE('Total angajati '|| allEmployees);
    DBMS_OUTPUT.PUT_LINE('Total salarii ' || allSalaries);
    DBMS_OUTPUT.PUT_LINE('Medie salarii ' || ROUND(allSalaries/allEmployees,2));
END;
/
--3
DECLARE
    current_id jobs%ROWTYPE;
    TYPE tb IS TABLE OF employees%ROWTYPE;
    allEmployees tb;
    CURSOR c IS
        SELECT *
        FROM employees;
    allSalaries NUMBER(10);

BEGIN
    OPEN c;
    FETCH c BULK COLLECT INTO allEmployees;
    SELECT SUM(salary + salary*NVL(commission_pct,0)) INTO allSalaries
    FROM employees;
    FOR i IN allEmployees.FIRST..allEmployees.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(allEmployees(i).last_name || ' ' || 
                    Round((allemployees(i).salary+NVL(allemployees(i).commission_pct,0) * allemployees(i).salary)/allsalaries * 100,4) || '%');
    END LOOP;
END;
/

--4
DECLARE
    current_id jobs%ROWTYPE;
    TYPE tb IS TABLE OF employees%ROWTYPE;
    allEmployees tb;
    CURSOR c IS
        SELECT *
        FROM jobs;
    CURSOR angajati(j jobs.job_id%TYPE) IS
        SELECT *
        FROM employees
        WHERE job_id = j
        ORDER BY salary DESC;
BEGIN
    open c;
    LOOP
        FETCH c into current_id;
        EXIT WHEN c%NOTFOUND;
        DBMS_output.PUT_line('\\ '||current_id.job_title);
        open angajati(current_id.job_id);
        FETCH angajati Bulk collect into allEmployees;
        if(angajati%ROWCOUNT<5) THEN
            DBMS_OUTPUT.PUT_LINE('Departamentul nu are 5 angajati');
        ELSE
            for i in 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(allEmployees(i).last_name || ' ' || allEmployees(i).salary);
            END LOOP; 
        END IF;

        close angajati;
    END LOOP;
    close c;    

END;
/


