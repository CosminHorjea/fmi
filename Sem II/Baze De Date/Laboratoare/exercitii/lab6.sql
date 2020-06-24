--Noile tabele au următoarele scheme relaţionale: 
--1) 
-- PROJECT(project_id #, project_name, budget, start_date, deadline, delivery_date, project_manager)
--	- project_id reprezintă codul proiectului şi este cheia primară a relaţiei PROJECT 
--  - project_name reprezintă numele proiectului 
--  - budget este bugetul alocat proiectului 
--  - start_date este data demarării proiectului 
--  - deadline reprezintă data la care proiectul trebuie să fie finalizat 
--  - delivery_date este data la care proiectul este livrat efectiv 
--  - project_manager reprezintă codul managerului de proiect şi este cheie externă.Pe cine referă această coloană ? Ce relaţie implementează această cheie externă ? 
--2) WORKS_ON(
--	project_id #, employee_id#, start_date, end_date)
--	- cheia primară a relaţiei este compusă din atributele employee_id şi project_id.
--EXEMPLU : codurile salariatilor atasati proiectelor cu buget = 10000
-- NOT EXISTS
SELECT DISTINCT employee_id
FROM works_on a
WHERE NOT EXISTS(
		SELECT 1
		FROM projects p
		WHERE budget = 10000
			AND NOT EXISTS (
				SELECT 'x'
				FROM works_on b
				WHERE p.project_id = b.project_id
					AND b.employee_id = a.employee_id
			)
	);
-- SAU CU COUNT()
SELECT employee_id
FROM works_on
WHERE project_id IN (
		SELECT project_id
		FROM projects
		WHERE budget = 10000
	)
GROUP BY employee_id
HAVING COUNT(project_id) =(
		-- vreau la TOATE proiectele care au bugetul asta
		SELECT COUNT(*)
		FROM project
		WHERE budget = 10000
	);
--1
SELECT employee_id,
	last_name,
	first_name
FROM employees
WHERE employee_id IN (
		SELECT employee_id
		FROM works_on
		WHERE project_id IN (
				SELECT project_id
				FROM projects
				WHERE start_date >= to_date('01-jan-06')
					AND start_date <= to_date('30-jun-06')
			)
		GROUP BY employee_id
		HAVING count(project_id) = (
				SELECT count(*)
				FROM projects
				WHERE start_date >= to_date('01-jan-06')
					AND start_date <= to_date('30-jun-06')
			)
	);
-- daca il vrem cu with:
WITH proiecte AS (
	SELECT project_id
	FROM projects
	WHERE start_date >= to_date('01-jan-06')
		AND start_date <= to_date('30-jun-06')
)
SELECT employee_id,
	last_name,
	first_name
FROM employees
WHERE employee_id IN (
		SELECT employee_id
		FROM works_on
		WHERE project_id IN (
				SELECT project_id
				from proiecte
			)
		GROUP BY employee_id
		HAVING count(project_id) = (
				SELECT count(*)
				from proiecte
			)
	);
--2
SELECT *
FROM projects
WHERE project_id IN (
		SELECT project_id
		FROM works_on
		WHERE employee_id IN (
				-- multimea ang care au mai avut 2 joburi
				SELECT employee_id
				FROM job_history
				GROUP BY employee_id
				HAVING COUNT(job_id) = 2
			)
		GROUP BY project_id
		HAVING count(*) = (
				SELECT count(count(employee_id))
				FROM job_history
				group by employee_id
				HAVING COUNT(job_id) = 2
			)
	);
--3
SELECT count(count(employee_id))
FROM job_history
GROUP by employee_id
HAVING count(employee_id) >= 2;
--4
SELECT country_name,
	count(employee_id)
FROM countries
	JOIN locations USING (country_id)
	JOIN departments USING(location_id)
	JOIN employees USING (department_id)
GROUP by country_name;
--5 
SELECT employee_id,
	project_id
FROM employees
	LEFT JOIN works_on USING (employee_id);
--6
-- asta e din tema rezolvata
SELECT *
FROM employees
WHERE department_id IN (
		SELECT distinct(department_id)
		FROM employees e
			JOIN projectS p ON(e.EMPLOYEE_ID = p.PROJECT_MANAGER)
	);
--7
SELECT *
FROM employees
WHERE department_id NOT IN (
		SELECT department_id
		FROM employees e
			JOIN projects p ON(e.employee_id = p.project_manager)
	);
--8
SELECT department_id
FROM employees e
GROUP BY department_id
HAVING AVG(salary) > & p;
--9
WITH proiecte AS (
	SELECT project_id
	FROM projects
	WHERE project_manager = 102
)
SELECT employee_id
FROM works_on
WHERE project_id IN (
		SELECT PROJECT_ID
		from proiecte
	)
MINUS
SELECT employee_id
FROM works_on
WHERE project_id NOT IN (
		SELECT PROJECT_ID
		from proiecte
	);
--10
SELECT employee_id,
	last_name
FROM employees
	JOIN works_on USING (employee_id)
WHERE project_id in(
		SELECT project_id -- toate proiectele lui 200
		from works_on
		where employee_id = 200
	)
	AND employee_id != 200
GROUP BY employee_id,
	last_name
HAVING COUNT(*) =(
		SELECT COUNT(PROJECT_ID)
		from works_on
		where employee_id = 200
	);
--b)
select employee_id,
	last_name
from employees
	join works_on using (employee_id)
where project_id in (
		select project_id
		from works_on
		where employee_id = 200
	)
	and employee_id != 200
group by employee_id,
	last_name
having count(*) <= (
		select count(project_id)
		from works_on
		where employee_id = 200
	) -- <= inseamna ca angajatii lucreaza la toate proiectele lui 200 sau doar la o parte din ele
MINUS
-- eliminam angajatii care lucreaza la proiecte la care ang 200 nu lucreaza 
select employee_id,
	last_name
from employees
	join works_on using (employee_id)
where project_id in (
		select project_id
		from works_on -- din lista tuturor proiectelor la care lucreaza angajati
		MINUS
		-- elimin proiectele la care lucreaza 200
		select project_id
		from works_on
		where employee_id = 200
	);
--11
SELECT employee_id,
	last_name
FROM employees
	join works_on using (employee_id)
WHERE project_id IN (
		select project_id
		from works_on
		where employee_id = 200
	)
	AND employee_id != 200
GROUP BY employee_id,
	last_name
HAVING count(*) = (
		select count(project_id)
		FROM works_on
		where employee_id = 200
	)
MINUS
SELECT employee_id,
	last_name
FROM employees
	JOIN works_on USING(employee_id)
WHERE project_id IN (
		select distinct project_id
		FROM works_on
		where project_id nor in(
				select project_id
				FROM works_on
				where employee_id = 200
			)
	);
--11
select *
from job_grades;
DESC job_grades;
SELECT last_name,
	first_name CASE
		WHEN salary >= 2000
		AND salary <= 5000 THEN 1
		WHEN salary >= 5001
		AND salary < 7001 THEN 2
		WHEN salary >= 7001
		AND salary < 10001 THEN 3
		WHEN salary >= 10001
		AND salary < 13001 THEN 4
		WHEN salary >= 13001
		AND salary < 16001 THEN 5
		WHEN salary >= 16001
		AND salary < 19001 THEN 6
	END "grade"
FROM employees;
-- partea de sql* plus nu intra la examen