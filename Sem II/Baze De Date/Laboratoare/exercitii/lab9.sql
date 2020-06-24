--1
CREATE OR REPLACE VIEW VIZ_EMP30_CHO AS(
		SELECT employee_id,
			last_name,
			email,
			salary
		FROM emp_cho
		WHERE department_id = 30
	);
DESC VIZ_EMP30_CHO;
INSERT INTO VIZ_EMP30_CHO VALUE(559, 'last_name', 'email', 10000) --cannot insert
	--2
CREATE OR REPLACE VIEW VIZ_EMP30_CHO AS (
		SELECT employee_id,
			last_name,
			email,
			salary,
			hire_date,
			job_id,
			department_id
		FROM emp_cho
		WHERE department_id = 30
	);
-- ca sa pot insera printr-o vizualizare in tabelul de baza rebuie sa includ coloanele cu not null.
UPDATE viz_emp30_cho
SET hire_date = hire_date -15
WHERE employee_id = 601;
DELETE FROM viz_emp30_cho
WHERE employee_id = 601;
--3
CREATE OR REPLACE VIEW VIZ_EMPSAL50_CHO AS(
		select employee_id,
			last_name,
			email,
			job_id,
			hire_date,
			salary * 12
		FROM emp_cho
		WHERE departemnt_id = 50
	);
--4
INSERT INTO VIZ_EMPSAL50_cho(employee_id, last_name, email, job_id, hire_date)
VALUES(567, 'last_name', 'email000', 'IT_PROG', sysdate);
--b
select *
from USER_UPDATABLE_COLUMNS
where table_name = 'VIZ_EMPSAL50_cho';
--5
CREATE OR REPLACE VIEW VIZ_EMP_DEP30_CHO AS
SELECT v.*,
	-- pp ca inseamna TOATE coloanele
	d.department_name
FROM VIZ_EMP30_CHO v
	JOIN departments d ON(d.department_id = v.department_id);
--b
INSERT INTO VIZ_EMP_DEP30_cho(
		employee_id,
		last_name,
		email,
		salary,
		job_id,
		hire_date,
		department_id
	)
VALUES (
		358,
		'lname',
		'email',
		15000,
		'IT_PROG',
		sysdate,
		30
	);
--c
select *
from USER_UPDATABLE_COLUMNS
where table_name = 'VIZ_EMP_DEP30_CHO';
--d
DELETE FROM VIZ_EMP_DEP30_CHO
WHERE employee_id = 358;
--6
CREATE OR REPLACE VIEW VIZ_DEP_SUM_CHO AS (
		SELECT department_id,
			min(salary),
			max(salary),
			avg(sal)
		FROM employees
			RIGHT JOIN departments USING (department_id)
		GROUP BY departemnt_id;
)
SELECT *
FROM VIZ_DEPT_SUM_CHO;
--7
CREATE OR REPLACE VIEW VIZ_EMP30_PNU AS (
		SELECT employee_id,
			last_name,
			email,
			salary,
			hire_date,
			job_id,
			department_id
		FROM emp_pnu
		WHERE department_id = 30
	) WITH READ ONLY CONSTRAINT verific;
--8
select view_name,
	text
FROM user_views
WHERE view_name LIKE '%CHO';
--9
SELECT last_name,
	salary,
	department_id,
	(
		SELECT MAX(salary)
		FROM employees
		WHERE department_id = E.department_id
	) max_salary
FROM employees E;
--10
CREATE OR REPLACE VIEW VIZ_SAL_CHO AS (
		SELECT last_name,
			department_name,
			salary,
			city
		FROM employees
			JOIN departments USING(department_id)
			JOIN locations USING(location_id)
	);
SELECT *
FROM VIZ_SAL_CHO;
--11
ALTER TABLE emp_cho
ADD CONSTRAINT ck_nume_emp_cho CHECK(UPPER(last_name) NOT LIKE 'WX%');