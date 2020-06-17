--2
SELECT MAX(salary),
	MIN(salary),
	SUM(salary),
	AVG(salary)
FROM employees;
--3
SELECT MAX(salary),
	MIN(salary),
	SUM(salary),
	AVG(salary)
FROM employees
GROUP BY job_id;
--4
SELECT COUNT(*),
	--poate trebuie facut un join ca sa nu avem valori null
	department_id
FROM employees
GROUP BY department_id;
--5
SELECT COUNT(DISTINCT manager_id) NrManageri
FROM employees;
--6 
SELECT MAX(salary) - MIN(salary) Diferenta
FROM employees;
--7
SELECT department_name,
	city,
	count(employee_id),
	avg(salary)
FROM departments
	JOIN locations USING (location_id)
	JOIN employees USING (employee_id)
GROUP BY department_name,
	city;
-- la GROUP BY punem coloanele care nu fac parte din functiile de agregare
--8
SELECT employee_id,
	last_name
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
	)
ORDER BY salary DESC;
--9
SELECT manager_id,
	MIN(salary)
FROM employees e
WHERE manager_id is not null
GROUP BY manager_id
HAVING MIN(salary) >= 1000;
--10
SELECT department_id,
	department_name,
	MAX(salary)
FROM employees
	JOIN departments USING(department_id)
GROUP BY department_id,
	department_name
HAVING MAX(salary) > 3000;
--11
SELECT MIN(AVG(salary))
FROM employees
GROUP BY job_id;
--12 
SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;
-- 13
SELECT job_id,
	job_title,
	AVG(salary)
FROM jobs
	JOIN employees USING (job_id)
GROUP BY job_id,
	job_title;
--14
SELECT AVG(salary)
FROM employees
HAVING AVG(salary) > 2500;
--15
SELECT department_id,
	job_id,
	SUM(salary)
FROM employees
GROUP BY department_id,
	job_id;
--16
--a)
SELECT department_id,
	department_name,
	COUNT(employee_id)
FROM employees
	JOIN departments USING (department_id)
GROUP BY department_id,
	department_name
HAVING COUNT(employee_id) < 4;
--b
SELECT department_id,
	department_name,
	COUNT(employee_id)
FROM employees
	JOIN departments USING (department_id)
GROUP BY department_id,
	department_name
HAVING COUNT(employee_id) =(
		SELECT MAX(COUNT(employee_id))
		FROM employees
		GROUP BY department_id
	);
);
--17
select last_name,
	hire_date
from employees
where to_char(hire_date, 'dd') = (
		select to_char(hire_date, 'dd')
		from employees
		group by to_char(hire_date, 'dd')
		having count(employee_id) = (
				select max(count(employee_id))
				from employees
				group by to_char(hire_date, 'dd')
			)
	);
--18
SELECT count(count(employee_id))
FROM employees
GROUP BY department_id
HAVING count(employee_id) >= 15;
--19
SELECT department_id,
	SUM(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 10
	AND department_id != 30
ORDER BY 2;
--20
SELECT employee_id,
	count(job_id)
FROM jobs
GROUP BY employee_id
having count(job_id) >= 2;
--21
SELECT AVG(commission_pct)
FROM employees;
--22
SELECT job_id,
	SUM(DECODE(department_id, 30, salary)) Dep30,
	SUM(DECODE(department_id, 50, salary)) Dep50,
	SUM(DECODE(department_id, 80, salary)) Dep80,
	SUM(salary) Total
FROM employees
GROUP BY job_id;
--23
SELECT (
		SELECT COUNT(*)
		FROM employees
	) total,
	(
		SELECT COUNT(*)
		FROM employees
		WHERE to_char(hire_date, 'yyyy') = 1997
	) an1997
from dual;
-- daca aici zic din employees imi face n coloane, asa ace doar una
--24
SELECT d.department_id,
	department_name,
	a.suma
FROM departments d,
	(
		SELECT department_id,
			SUM(salary) suma
		FROM employees
		GROUP BY department_id
	) a
WHERE d.department_id = a.department_id;
--26
SELECT d.department_id,
	department_name,
	a.suma,
	a.nrEm
FROM departments d,
	(
		SELECT department_id,
			SUM(salary) suma,
			COUNT(employee_id) nrEm
		FROM employees
		GROUP BY department_id
	) a
WHERE d.department_id = a.department_id;