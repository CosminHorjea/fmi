SELECT * FROM employees;
SELECT * FROM jobs;
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
            DBMS_output.PUT_line(current_employee.last_name);
            
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
            DBMS_output.PUT_line(j.last_name);
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
            DBMS_output.PUT_line(j.last_name);
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
            DBMS_output.put_line(current_employee.last_name);
        END LOOP;
    END LOOP;
    close c;
END;

--2
