--Laborator PL/SQL 3

--1
DECLARE
    v_nr number(4);
    v_nume departments.department_name%TYPE;
    CURSOR c IS
        SELECT department_name nume, COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id(+)
        GROUP BY department_name;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_nume,v_nr;
        EXIT WHEN c%NOTFOUND;
        IF v_nr=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||
            ' nu lucreaza angajati');
        ELSIF v_nr=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||
            ' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||
            ' lucreaza '|| v_nr||' angajati');
        END IF;
    END LOOP;
    CLOSE c;
END;
/

DECLARE
    TYPE tab_nume IS TABLE OF 
        departments.department_name%TYPE;
    TYPE tab_nr IS TABLE OF NUMBER(4);
    t_nr tab_nr;
    t_nume tab_nume;
    CURSOR c IS
        SELECT department_name nume, 
            COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id(+)
        GROUP BY department_name;
BEGIN
    OPEN c;
    FETCH c BULK COLLECT INTO t_nume, t_nr;
    CLOSE c;
    FOR i IN t_nume.FIRST..t_nume.LAST LOOP
        IF t_nr(i)=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
            ' nu lucreaza angajati');
        ELSIF t_nr(i)=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
            ' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
            ' lucreaza '|| t_nr(i)||' angajati');
        END IF;
    END LOOP;
END;
/

--3 ciclu cursor
DECLARE
    CURSOR c IS
        SELECT department_name nume, 
            COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id(+)
        GROUP BY department_name;
BEGIN
    FOR i in c LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
            ' nu lucreaza angajati');
        ELSIF i.nr=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume ||
            ' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
            ' lucreaza '|| i.nr||' angajati');
        END IF;
    END LOOP;
END;
/

--4
BEGIN
    FOR i in 
        (SELECT department_name nume, COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id(+)
        GROUP BY department_name) LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
            ' nu lucreaza angajati');
        ELSIF i.nr=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume ||
            ' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
            ' lucreaza '|| i.nr||' angajati');
        END IF;
    END LOOP;
END;
/

--5
--a
DECLARE
    v_cod employees.employee_id%TYPE;
    v_nume employees.last_name%TYPE;
    v_nr NUMBER(4);
    CURSOR c IS
        SELECT sef.employee_id cod, MAX(sef.last_name) nume,
            count(*) nr
        FROM employees sef, employees ang
        WHERE ang.manager_id = sef.employee_id
        GROUP BY sef.employee_id
        ORDER BY nr DESC;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_cod,v_nume,v_nr;
        EXIT WHEN c%ROWCOUNT>3 OR c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Managerul '|| v_cod ||
            ' avand numele ' || v_nume ||
            ' conduce ' || v_nr||' angajati');
    END LOOP;
    CLOSE c;
END;
/

--b
--a
DECLARE
    v_cod employees.employee_id%TYPE;
    v_nume employees.last_name%TYPE;
    v_nr NUMBER(4);
    CURSOR c IS
        SELECT sef.employee_id cod, MAX(sef.last_name) nume,
            count(*) nr
        FROM employees sef, employees ang
        WHERE ang.manager_id = sef.employee_id
        GROUP BY sef.employee_id
        ORDER BY nr DESC;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_cod,v_nume,v_nr;
        EXIT WHEN c%ROWCOUNT>4 OR c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Managerul '|| v_cod ||
            ' avand numele ' || v_nume ||
            ' conduce ' || v_nr||' angajati');
    END LOOP;
    CLOSE c;
END;
/

--tema de facut topul real (SQL)

--6
DECLARE
    CURSOR c IS
        SELECT sef.employee_id cod, MAX(sef.last_name) nume,
        count(*) nr
        FROM employees sef, employees ang
        WHERE ang.manager_id = sef.employee_id
        GROUP BY sef.employee_id
        ORDER BY nr DESC;
BEGIN
    FOR i IN c LOOP
        EXIT WHEN c%ROWCOUNT>3;
        DBMS_OUTPUT.PUT_LINE('Managerul '|| i.cod ||
        ' avand numele ' || i.nume ||
        ' conduce '|| i.nr||' angajati');
    END LOOP;
END;
/

--7
DECLARE
    top number(1):= 0;
BEGIN
    FOR i IN (SELECT sef.employee_id cod, MAX(sef.last_name) nume,
                count(*) nr
                FROM employees sef, employees ang
                WHERE ang.manager_id = sef.employee_id
                GROUP BY sef.employee_id
                ORDER BY nr DESC)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Managerul '|| i.cod ||
        ' avand numele ' || i.nume ||
        ' conduce '|| i.nr||' angajati');
        top := top+1;
        EXIT WHEN top=3;
    END LOOP;
END;
/

--8
DECLARE
    v_x number(4) := &p_x;
    v_nr number(4);
    v_nume departments.department_name%TYPE;
    CURSOR c (paramentru NUMBER) IS
        SELECT department_name nume, COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id
        GROUP BY department_name
        HAVING COUNT(employee_id)> paramentru;
BEGIN
    OPEN c(v_x);
    LOOP
        FETCH c INTO v_nume,v_nr;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||
            ' lucreaza '|| v_nr||' angajati');
    END LOOP;
    CLOSE c;
END;
/

DECLARE
    v_x number(4) := &p_x;
    CURSOR c (paramentru NUMBER) IS
        SELECT department_name nume, COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id
        GROUP BY department_name
        HAVING COUNT(employee_id)> paramentru;
BEGIN
    FOR i in c(v_x) LOOP
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
        ' lucreaza '|| i.nr||' angajati');
    END LOOP;
END;
/

DECLARE
    v_x number(4) := &p_x;
BEGIN
    FOR i in (SELECT department_name nume, COUNT(employee_id) nr
        FROM departments d, employees e
        WHERE d.department_id=e.department_id
        GROUP BY department_name
        HAVING COUNT(employee_id)> v_x)
    LOOP
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||
        ' lucreaza '|| i.nr||' angajati');
    END LOOP;
END;
/

--9
SELECT last_name, hire_date, salary
FROM emp_prof
WHERE TO_CHAR(hire_date, 'yyyy') = 2000;

DECLARE
    CURSOR c IS
        SELECT *
        FROM emp_prof
        WHERE TO_CHAR(hire_date, 'YYYY') = 2000
        FOR UPDATE OF salary WAIT 10;
BEGIN
    FOR i IN c LOOP
        UPDATE emp_prof
        SET salary= salary+1000
        WHERE CURRENT OF c;
    END LOOP;
END;
/

SELECT last_name, hire_date, salary
FROM emp_prof
WHERE TO_CHAR(hire_date, 'yyyy') = 2000;

ROLLBACK;

--10
--c
BEGIN
    FOR v_dept IN (SELECT department_id, department_name
                    FROM departments
                    WHERE department_id IN (10,20,30,40))
    LOOP
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||v_dept.department_name);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR v_emp IN (SELECT last_name
                        FROM employees
                        WHERE department_id = v_dept.department_id)
        LOOP
            DBMS_OUTPUT.PUT_LINE (v_emp.last_name);
        END LOOP;
    END LOOP;
END;
/

--d expresii cursor
DECLARE
    TYPE refcursor IS REF CURSOR;
    CURSOR c_dept IS
        SELECT department_name,
            CURSOR (SELECT last_name
                    FROM employees e
                    WHERE e.department_id = d.department_id)            
        FROM departments d
        WHERE department_id IN (10,20,30,40);
    v_nume_dept departments.department_name%TYPE;
    v_cursor refcursor;
    v_nume_emp employees.last_name%TYPE;
BEGIN
    OPEN c_dept;
    LOOP
        FETCH c_dept INTO v_nume_dept, v_cursor;
        EXIT WHEN c_dept%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||v_nume_dept);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        LOOP
            FETCH v_cursor INTO v_nume_emp;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE (v_nume_emp);
        END LOOP;
    END LOOP;
    CLOSE c_dept;
END;
/

--11
DECLARE
    TYPE emp_tip IS REF CURSOR RETURN employees%ROWTYPE;
    -- sau
    -- TYPE emp_tip IS REF CURSOR;
    v_emp emp_tip;
    v_optiune NUMBER := &p_optiune;
    v_ang employees%ROWTYPE;
BEGIN
    IF v_optiune = 1 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees;
                       --WHERE employee_id = 1;
    ELSIF v_optiune = 2 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees
                       WHERE salary BETWEEN 10000 AND 20000;
    ELSIF v_optiune = 3 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees
                       WHERE TO_CHAR(hire_date, 'YYYY') = 2000; -- sau EXTRACT(YEAR FROM hire_date)
    ELSE
        DBMS_OUTPUT.PUT_LINE('Optiune incorecta');
    END IF;
    
    IF v_emp%ISOPEN THEN
        LOOP
            FETCH v_emp into v_ang;
            EXIT WHEN v_emp%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_ang.last_name);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Au fost procesate '||v_emp%ROWCOUNT
                                || ' linii');
        CLOSE v_emp;
    END IF;
END;
/

--12
DESC employees;

DECLARE
    TYPE rec IS RECORD (emp_id employees.employee_id%TYPE, 
                        sal employees.salary%TYPE,
                        comm_pct employees.commission_pct%TYPE);
    v_rec rec;
    TYPE empref IS REF CURSOR;
    v_emp empref;
    v_nr INTEGER := &n;
BEGIN
    OPEN v_emp FOR
        'SELECT employee_id, salary, commission_pct ' ||
        'FROM employees WHERE salary > :bind_var'
    USING v_nr;
    
    -- introduceti liniile corespunzatoare rezolvarii problemei
    LOOP
        FETCH v_emp INTO v_rec;
        EXIT WHEN v_emp%NOTFOUND;
        IF v_rec.comm_pct IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE(v_rec.emp_id || ' ' || v_rec.sal || ' ' 
                || v_rec.comm_pct);
        ELSE 
            DBMS_OUTPUT.PUT_LINE(v_rec.emp_id || ' ' || v_rec.sal);
        END IF;
    END LOOP;
    
    CLOSE v_emp;
END;
/

DECLARE
    TYPE rec IS RECORD (emp_id employees.employee_id%TYPE, 
                        sal employees.salary%TYPE,
                        comm_pct employees.commission_pct%TYPE);
    v_rec rec;
    TYPE empref IS REF CURSOR;
    v_emp empref;
    v_nr INTEGER := &n;
BEGIN
    OPEN v_emp FOR
        'SELECT employee_id, salary, commission_pct ' ||
        'FROM employees WHERE salary > :bind_var'
    USING v_nr;
    
    -- introduceti liniile corespunzatoare rezolvarii problemei
    FETCH v_emp INTO v_rec;
    WHILE v_emp%FOUND LOOP
        IF v_rec.comm_pct IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE(v_rec.emp_id || ' ' || v_rec.sal || ' ' 
                || v_rec.comm_pct);
        ELSE 
            DBMS_OUTPUT.PUT_LINE(v_rec.emp_id || ' ' || v_rec.sal);
        END IF;
        FETCH v_emp INTO v_rec;
    END LOOP;
    
    CLOSE v_emp;
END;
/

-- EXERCITII
--5
--varianta 1
DECLARE
    CURSOR c1 IS
        SELECT job_id, job_title
        FROM jobs;
    CURSOR c2 (parameter jobs.job_id%TYPE) IS
        SELECT last_name, salary
        FROM employees
        WHERE job_id = parameter
        ORDER BY salary DESC;
    TYPE job IS RECORD(id jobs.job_id%TYPE,
                       title jobs.job_title%TYPE);
    TYPE ang IS RECORD(last_name employees.last_name%TYPE,
                       salary employees.salary%TYPE);
    TYPE tab_ang IS TABLE OF ang;
    v_job job;
    v_ang tab_ang;
    top NUMBER;
    i INTEGER;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_job;
        EXIT WHEN c1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('JOB: '|| v_job.title);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    
        OPEN c2(v_job.id);
            DBMS_OUTPUT.PUT_LINE('Top cei ma bine platiti 5 angajati:');
            
            FETCH c2 BULK COLLECT INTO v_ang;
            IF c2%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('NU ARE ANGAJATI');
            END IF;
            top := 1;
            i := v_ang.first;
            WHILE i <= v_ang.last AND top < 5 LOOP
                IF i <> v_ang.first THEN
                    IF v_ang(i).salary != v_ang(v_ang.prior(i)).salary THEN
                        top := top + 1;
                    END IF;
                END IF;
                
                DBMS_OUTPUT.PUT_LINE(top || '. ' || v_ang(i).last_name || ' - ' || v_ang(i).salary);
                i := v_ang.next(i);
            END LOOP;
                
            CLOSE c2;
            DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
    CLOSE c1;
END;
/

--VARIANTA 2
DECLARE  
  TYPE refcursor IS REF CURSOR;  
  CURSOR c_jobs IS  
    SELECT DISTINCT job_title,
      CURSOR (SELECT last_name, salary
              FROM employees e 
              WHERE e.job_id = j.job_id
              ORDER BY salary desc)
    FROM jobs j;

  v_nume_job jobs.job_title%TYPE;
  v_cursor refcursor;
  v_nume_emp employees.last_name%TYPE;
  v_nr number;
  v_sal number;
BEGIN  
  OPEN c_jobs;  
  
  LOOP  
    FETCH c_jobs INTO v_nume_job, v_cursor;  
    EXIT WHEN c_jobs%NOTFOUND;
    v_nr := 0;
    v_sal := 0;
    DBMS_OUTPUT.PUT_LINE('La jobul '|| v_nume_job || 
        ' cei mai bine platiti angajati sunt:');
    LOOP  
      FETCH v_cursor INTO v_nume_emp, v_salariu_emp;  
      EXIT WHEN v_cursor%NOTFOUND OR v_nr > 5;  
      DBMS_OUTPUT.PUT_LINE (v_nume_emp || ' cu salariul ' || v_salariu_emp);
      v_nr := v_nr + 1;
    END LOOP;  
  END LOOP;  
END;
/

--TEMA 1, 2, 3, 4, 5 (alt tip de cursor)