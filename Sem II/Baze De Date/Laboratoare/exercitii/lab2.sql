-- ex 11

SELECT last_name,job_id,department_id FROM employees WHERE department_id IN (10,30) ORDER BY last_name;-- ORDER BY 1 acelasi lucru

SELECT last_name Nume,job_id,department_id FROM employees WHERE department_id IN (10,30)  ORDER BY Nume; -- o alta var


--ex12
SELECT last_name Angajat,salary "Salariu Lunar" FROM employees WHERE department_id IN (10,30) AND salary>1500  ORDER BY Nume; -- o alta var

--ex 13
SELECT TO_CHAR(SYSDATE,'HH12 YY') FROM DUAL;
DESC DUAL ;
SELECT * FROM DUAL;

SELECT SYSDATE FROM DUAL;

--ex 14

SELECT last_name,hire_date from employees WHERE hire_date LIKE('%87%');
SELECT last_name,hire_date from employees WHERE TO_CHAR(hire_date,'YY')='87';

--ex 15
SELECT last_name,job_id FROM employees WHERE manager_id IS NULL ;

--ex16
SELECT last_name,salary,job_id,commission_pct from employees where commission_pct IS NOT NULL ORDER BY salary DESC,commission_pct DESC;

--ex 17
SELECT last_name,salary,job_id,commission_pct from employees ORDER BY salary DESC,commission_pct DESC;

--ex 18
SELECT last_name from employees WHERE upper(last_name) LIKE '__A%';

--ex 19
SELECT last_name from employees where (upper(last_name) LIKE '%L%L%' and department_id =30) or manager_id=102;

--ex 20
SELECT last_name,job_id,salary from employees where job_id like '%CLERK%' OR job_id LIKE '%REP%' AND salary NOT IN (1000,2000,3000);


--Fisierul cu lab2

--ex1
SELECT CONCAT(first_name,last_name)||' castiga '||salary||' lunar dar doreste '|| salary*3 "Salariul Ideal" from employees;

--ex2
SELECT INITCAP(first_name), upper(last_name), length(last_name) Lungime 
from employees 
where last_name LIKE 'J%' or last_name LIKE 'M%' or upper(last_name) like '__A%' 
ORDER BY Lungime DESC;

SELECT INITCAP(first_name), upper(last_name), length(last_name) Lungime 
from employees 
where last_name LIKE 'J%' or last_name LIKE 'M%' or substr(upper(last_name), 3,1)='A' 
ORDER BY Lungime DESC;

--ex 3

SELECT employee_id,last_name,department_id
FROM employees
WHERE LTRIM(RTRIM(UPPER(first_name)))='STEVEN';
--sau
SELECT employee_id,last_name,department_id
FROM employees
WHERE TRIM(BOTH FROM UPPER(first_name))='STEVEN';

--ex4
SELECT EMPLOYEE_ID,last_name,LENGTH(last_name),instr(upper(last_name),'A') PozitieA FROM employees where last_name like '%e';

--ex 5
--SELECT last_name from employees where mod(tonumber(DATEDIFF('day',SYSDATE,hire_date)),7)=0;
SELECT TO_NUMBER('-25.789',99.999)
from dual;

SELECT last_name from employees where mod(round(SYSDATE-hire_date),7)=0;

--ex9
select round(to_date('31-12-2020','dd-mm-yyyy')-sysdate) NrZile
from dual;

-- TODO ex5 acasa