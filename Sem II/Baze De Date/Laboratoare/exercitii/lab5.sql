--0
--a)
SELECT last_name,
	salary,
	department_id
FROM employees e
where salary > (
		SELECT AVG(salary)
		FROM employees
		WHERE department_id = e.department_id
	);
--b)
SELECT last_name,
	salary,
	department_id,
	department_name,
	(
		SELECT AVG(salary)
		FROM employees
		WHERE department_id = d.department_id
	) "Salariu Mediu"
FROM employees e
where salary > (
		SELECT AVG(salary)
		FROM employees
		WHERE department_id = e.department_id
	);
--1)
SELECT last_name,
	salary
FROM employees
WHERE salary > ALL(
		SELECT salary
		FROM employees
		group by department_id
	);
-- ruleaza conditia cu TOATE valorile din subcerere
--2)
SELECT last_name,
	salary
FROM employees e
WHERE salary = (
		SELECT MIN(salary)
		FROM employees
		WHERE e.department_id = department_id
	);
--sau
SELECT last_name,
	salary,
	department_id
FROM employees
WHERE (department_id, salary) IN (
		SELECT department_id,
			MIN(salary)
		FROM employees
		GROUP BY department_id
	);
--3
SELECT MAX(salary)
FROM employees
WHERE department_id == 30;
SELECT last_name
FROM employees e
WHERE department_id IN (
		SELECT DISTINCT department_id
		FROM employees e2
		WHERE e2.salary = (
				SELECT MAX(salary)
				FROM employees
				WHERE department_id = 30
			)
			AND department_id != 30
	);
--4
SELECT last_name,
	salary
FROM employees
where rownums <= 3
order by salary;
--5
SELECT employee_id,
	last_name
FROM employees
WHERE employee_id IN (
		SELECT manager_id
		FROM employees
		GROUP BY manager_id
		HAVING COUNT(*) >= 2
	);
--6
SELECT location_id
FROM locations
WHERE location_id IN (
		SELECT location_id
		from departments
	);
--alternativ
SELECT location_id
FROM locations
WHERE location_id IN (
		SELECT location_id
		from departments
	);
--sau
select location_id
from locations loc
where EXISTS (
		select 1
		from departments
		where loc.location_id = location_id
	);
--7
SELECT department_id
FROM departments
WHERE department_id NOT IN (
		SELECT NVL(department_id, 0)
		from employees
	);
--8
WITH val_dep AS (
	SELECT department_name,
		SUM(salary) AS total
	FROM departments d
		join employees e USING(department_id)
	GROUP BY department_name
),
val_medie AS (
	SELECT sum(total.) / COUNT(*) AS medie
	FROM val_dep
)
SELECT *
FROM val_dep
WHERE total > (
		SELECT medie
		FROM val_medie
	)
ORDER BY department_name;
--9
WITH subord AS(
	-- toti aia condusi de steven king
	SELECT employee_id,
		hire_date
	FROM employees
	WHERE manager_id = (
			SELECT employee_id
			FROM employees
			WHERE lower(last_name || first_name) = 'kingsteven'
		)
),
vechime AS (
	-- ala cu cea mai mare vechime
	SELECT employee_id
	FROM subord
	WHERE hire_date = (
			SELECT min(hire_date)
			FROM subord
		)
)
SELECT employee_id,
	last_name,
	first_name,
	job_id,
	hire_date,
	manager_id
FROM employees
where to_char(hire_date, 'yyyy') != '1970'
	AND employee_id IN (
		select employee_id
		FROM vechime
	);
--10
SELECT * -- asta e un trick bun cand trebuie sa limitezi numarul dupa ce ordonezi
FROM (
		SELECT employee_id
		FROM employees
		ORDER BY salary
	)
where rownum < 11;
--11
SELECT 'Departamentul' || department_name || 'este condus de' || nvl(to_char(manager_id), 'nimeni') || 'si' || CASE
		WHEN (
			SELECT COUNT(employee_id)
			FROM employees
			WHERE d.department_id = department_id
		) = 0 THEN 'nu are salariati'
		ELSE 'are numarul de salariati' || (
			SELECT COUNT(employee_id)
			FROM employees
			WHERE d.department_id = department_id
		)
	END Detalii
FROM departments d;
--12
SELECT last_name,
	first_name,
	nullif(length(last_name), length(first_name)) Lungime
FROM employees;
--13
SELECT last_name,
	hire_date,
	salary,
	CASE
		TO_CHAR(hire_date, 'yyyy')
		WHEN '1989' THEN salary * 1.20
		WHEN '1990' THEN salary * 1.15
		WHEN '1991' THEN salary * 1.10
		ELSE salary
	END "sALARIU MARIT"
FROM employees;
--sau cu DECODE
SELECT last_name,
	hire_date,
	salary,
	DECODE (
		TO_CHAR(hire_date, 'yyyy'),
		'1989',
		salary * 1.20,
		'1990',
		salary * 1.15,
		'1991',
		salary * 1.10,
		salary
	) "Salariu Marit"
FROM employees;
--14
SELECT job_id,
	CASE
		WHEN lower(job_id) like 's%' THEN (
			SELECT sum(salary)
			FROM employees
			WHERE job_id = j.job_id
		)
		WHEN job_id = (
			SELECT job_id
			FROM employees
			WHERE salary = (
					SELECT max(salary)
					FROM employees
				)
		) THEN (
			SELECT round(avg(salary))
			FROM employees
		)
		ELSE (
			SELECT min(salary)
			FROM employees
			WHERE job_id = j.job_id
		)
	END joburi
FROM jobs j;