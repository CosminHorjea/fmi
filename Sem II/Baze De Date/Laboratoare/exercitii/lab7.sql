--1
CREATE TABLE emp_cho AS
SELECT *
FROM employees;
CREATE TABLE dept_cho AS
SELECT *
FROM departments;
--2
DESC emp_cho;
DESC dept_cho;
--3 
SELECT *
from emp_cho;
SELECT *
from dept_cho;
--4
ALTER TABLE emp_cho
ADD CONSTRAINT pk_emp PRIMARY KEY(employee_id);
ALTER TABLE dept_cho
ADD CONSTRAINT pk_emp PRIMARY KEY(department_id);
ALTER TABLE emp_cho
ADD CONSTRAINT fk_emp_dept_cho FOREIGN KEY(department_id) REFERENCES dept_cho(department_id);
--5
INSERT INTO dept_cho(department_id, department_name)
VALUES (300, 'Programare');
--6
INSERT INTO emp_cho
VALUES(
		257,
		NULL,
		'nume257',
		'email257',
		NULL,
		SYSDATE,
		'IT_PROG',
		NULL,
		NULL,
		NULL,
		NULL
	);
--7
INSERT INTO emp_cho (
		hire_date,
		job_id,
		employee_id,
		last_name,
		email,
		department_id
	)
VALUES (
		sysdate,
		'sa_man',
		278,
		'nume_278',
		'email_278',
		300
	);
--8
INSERT INTO emp_cho(
		employee_id,
		last_name,
		email,
		hire_date,
		job_id,
		salary,
		commission_pct
	)
VALUES(
		252,
		'Nume252',
		'nume@gmail.com',
		SYSDATE,
		'SA_REP',
		5000,
		NULL
	);
ROLLBACK;
INSERT INTO (
		SELECT employee_id,
			last_name,
			email,
			hire_date,
			job_id,
			salary,
			commission_pct
		FROM emp_pnu
	)
VALUES (
		252,
		'Nume252',
		'nume252@emp.com',
		SYSDATE,
		'SA_REP',
		5000,
		NULL
	);
SELECT employee_id,
	last_name,
	email,
	hire_date,
	job_id,
	salary,
	commission_pct
FROM emp_pnu
WHERE employee_id = 252;
ROLLBACK;
INSERT INTO(
		SELECT employee_id,
			last_name,
			hire_date,
			job_id,
			email
		FROM emp_cho
	)
VALUES(
		(
			SELECT max(employee_id) + 1
			FROM emp_cho
		),
		'nume_nou',
		sysdatem,
		'sa_man',
		'email@cho.com'
	);
--9
CREATE TABLE emp1_cho as
select *
from employees;
DELETE FROM emp1_cho;
INSERT INTO emp1_cho
SELECT *
FROM employees
where commission_pct > 0.25;
--10
INSERT INTO emp_cho
SELECT 0,
	USER,
	USER,
	'TOTAL',
	'TOTAL',
	SYSDATE,
	'TOTAL',
	SUM(salary),
	ROUND(AVG(commission_pct)),
	null,
	null
FROM employees;
SELECT *
FROM emp_cho;
--12
create table emp1_cho as
select *
from employees;
create table emp2_cho as
select *
from employees;
create table emp3_cho as
select *
from employees;
delete from emp1_cho;
delete from emp2_cho;
delete from emp3_cho;
INSERT ALL
	WHEN salary < 5000 then into emp1_cho
	WHEN salary >= 5000
	AND salary <= 10000 then into emp2_cho
	ELSE INTO emp3_cho
SELECT *
FROM employees;
--13
CREATE TABLE emp0_cho AS
SELECT *
FROM employees;
DELETE FROM emp0_cho;
INSERT FIRST -- FIRST, se opreste cand este satisfacuta prima conditie de when, adica un angajat care are dep 80 nu va aparea si in alt tabel
	WHEN department_id = 80 THEN INTO emp0_pnu
	WHEN salary < 5000 THEN INTO emp1_pnu
	WHEN salary > = 5000
	AND salary <= 10000 THEN INTO emp2_pnu
	ELSE INTO emp3_pnu
SELECT *
FROM employees;
--14
UPDATE emp_cho
SET salary = salary * 1.05;
--15
UPDATE emp_cho
SET job_id = 'SA_REP'
WHERE commission_pct is not null
	and department_id = 80;
--16
UPDATE dept_cho
SET manager_id = (
		SELECT employee_id
		from emp_cho
		where initcap(last_name) = 'Grant'
			and initcap(first_name) = 'Douglas'
	)
WHERE department_id = 20;
update emp_pnu
set salary = salary + 1000
where initcap(last_name) = 'Grant'
	and initcap(first_name) = 'Douglas';
--17
UPDATE emp_cho e
SET (salary, commission_pct) =(
		SELECT salary,
			commission_pct
		FROM emp_cho
		WHERE employee_id = e.manager_id
	)
WHERE salary = (
		SELECT MIN(salary)
		FROM emp_cho
	);
--18
UPDATE emp_cho e
SET email = substr(last_name, 1, 1) || nvl(first_name, '.')
WHERE salary = (
		select max(salary)
		from emp_cho
		where department_id = e.department_id
	);
--19
UPDATE emp_cho e
SET salary = (
		SELECT AVG(salary)
	)
WHERE hire_date = (
		SELECT min(hire_date)
		FROM emp_cho
		where department_id = e.department_id
	);
--20
DELETE FROM dept_cho;
--se pot sterge doar alea care nu au angajati
ROLLBACK;
--21
DELETE FROM dept_cho
WHERE department_id not in (
		SELECT nvl(department_id, -100)
		from emp_cho
	);
--22
INSERT INTO dept_cho
VALUES (400, 'depart400', null, null);
--23
SAVEPOINT P;
-- punt de salvare, atat
--24
DELETE FROM dept_cho
WHERE department_id BETWEEN 160 and 200;
--25
rollback to p;
-- ma introc la p(savepoint);