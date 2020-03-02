--Horjea Cosmin-Marian
--143


-- ex 6
SELECT employee_id||' '||first_name||' '||last_name||' '||email||' '||phone_number||' '||hire_date||' '||job_id||' '||salary||' '||commission_pct||' '|| manager_id||' '|| department_id as"Informatii Complete" FROM employees;

-- ex 10

SELECT first_name||' '||last_name AS "Nume", job_id , hire_date FROM employees WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989' ORDER BY hire_date;  

--ex 10 cu join

SELECT first_name,jobs.job_title from employees INNER JOIN jobs ON jobs.job_id=employees.job_id;
SELECT first_name||' '||last_name AS "Nume", jobs.job_title , hire_date FROM employees INNER JOIN jobs ON jobs.job_id=employees.job_id WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989' ORDER BY hire_date;  
