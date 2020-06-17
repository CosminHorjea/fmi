--ex din Lab 2
-- ex 6
SELECT employee_id,
	last_name,
	salary,
	round(salary * 1.15, 2) "Salariu nou",
	round(salary * 1.15 / 100, 2) "Numar sute"
FROM employees
where mod(salary, 1000) != 0;
--ex 7
SELECT last_name "Nume angajat",
	rpad(to_char(hire_date), 20, 'X') "Data angajarii"
FROM employees
WHERE commission_pct is NOT NULL;
--ex 8
SELECT TO_CHAR(SYSDATE + 30, 'MONTH DD YYYY HH24:MI:SS') "Data"
FROM DUAL;
--ex 10
SELECT TO_CHAR(SYSDATE + 12 / 24, 'DD/MM HH24:MI:SS') "Data"
FROM DUAL;
-- B) Data de peste 5 minute
SELECT SYSDATE + 5 / 24 / 60 -- 1/288 5 minute dintr-o zi // mereu ne raportam la zi
FROM DUAL;
-- urmatoarele sunt rezolvate direct in pdf
--ex 13
SELECT last_name,
	NVL(TO_CHAR(commission_pct), 'Fara Comision') "Comision"
from employees;
--ex 14
SELECT last_name,
	salary,
	commission_pct
FROM employees
WHERE (salary + salary * commission_pct) > 10000;
-- daca nu am comision , conditia iese null
--SELECT NULL+10 FROM DUAL; -- orice operatie nu NULL da tot NULL; *!*!*
-- trebuie asa
SELECT last_name,
	salary,
	commission_pct
FROM employees
WHERE salary + salary * NVL(commission_pct, 0) > 10000;
-- ex 15
SELECT last_name,
	job_id,
	salary,
	DECODE(
		job_id,
		'IT_PROG',
		salary * 1.1,
		-- sunt if elseuri practic
		'ST_CLERK',
		salary * 1.15,
		'SA_REP',
		salary * 1.2,
		salary
	) "Salariu renegociat"
FROM employees;
--Sau (sunt echivalente pretty much) e alegere pur de preferinta
SELECT last_name,
	job_id,
	salary,
	CASE
		job_id
		WHEN 'IT_PROG' THEN salary * 1.1 -- e gresit in pdf lab 2 , nu se pune "," dupa valoare
		WHEN 'ST_CLERK' THEN salary * 1.15
		WHEN 'SA_REP' THEN salary * 1.2
		ELSE salary
	END "Salariu renegociat"
FROM employees;
--Join-uri
SELECT employee_id,
	department_name
FROM employees e,
	departments d
WHERE e.department_id = d.department_id;
select employee_id,
	department_name
from employees e
	join departments d on (e.department_id = d.department_id);
select employee_id,
	department_name
from employees e
	join departments d using(department_id);
-- asta e doar cand coloanele se numesc la fel
--ex 17
SELECT e.job_id,
	job_title
FROM employees e,
	jobs j
WHERE department_id = 30
	AND e.job_id = j.job_id;
--ex 18
SELECT last_name,
	department_name,
	location_id
FROM employees e,
	departments d
WHERE e.department_id = d.department_id
	AND commission_pct is not null;
select employee_id,
	department_id
from employees e,
	departments d
where e.department_id (+) = d.department_id;
-- in ca z ca un employee nu are department
-- ex 19
SELECT last_name,
	job_title,
	department_name
FROM employees e,
	departments d,
	jobs j,
	locations l
WHERE e.department_id = d.department_id
	and e.job_id = j.job_id
	and d.location_id = l.location_id
	and initcap(city) = 'Oxford';
-- ex 20
SELECT ang.employee_id Ang #, ang.last_name Angajat, sef.employee_id Mgr#,
	sef.last_name Manager
FROM employees ang,
	employees sef
WHERE ang.manager_id = sef.employee_id;
-- ex 21      
SELECT ang.employee_id Ang #, ang.last_name Angajat, sef.employee_id Mgr#,
	sef.last_name Manager
FROM employees ang,
	employees sef
WHERE ang.manager_id = sef.employee_id (+);
-- unde vad (+) inseamna ca ii dau voi coloanei aleaia sa fie NULL
--ex 22
select ang.last_name,
	ang.department_id,
	coleg.last_name
FROM employees ang,
	employees coleg
where ang.department_id = coleg.department_id
	and ang.employee_id > coleg.employee_id;
--ex 23 TEMA
-- ex 24
SELECT ang.last_name,
	ang.hire_date,
	gates.hire_date
from employees ang,
	employees gates
WHERE ang.hire_date > gates.hire_date
	and initcap(gates.last_name) = 'Gates';
--TEMA 23, 25;
--23 Creaţi o cerere prin care să se afişeze numele angajatilor, codul job-ului, titlul job-ului,numele departamentului şi salariul angajaţilor. Se vor include și angajații al căror departament nu este cunoscut
SELECT last_name,
	job_id,
	job_title
FROM employees
	JOIN jobs USING (job_id)
	JOIN departments USING (department_id);
--25  Să se afişeze numele salariatului şi data angajării împreună cu numele şi data angajării şefului direct pentru salariaţii care au fost angajaţi înaintea şefilor lor. Se vor eticheta coloanele Angajat, Data_ang, Manager si Data_mgr
SELECT e.last_name Angajat,
	e.hire_date DataAngj,
	sef.last_name Manager,
	sef.hire_date AngSef
FROM employees e,
	employees sef
WHERE e.hire_date < sef.hire_date
	AND e.manager_id = sef.employee_id;