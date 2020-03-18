--EXERCITII DIN PDF-UL CU LAB 3
select *
from employees
natural join departments;

SELECT last_name,department_name, location_id
FROM employees e, departments d
where e.department_id = d.department_id --106 rez

--sql3 on
SELECT last_name,department_name,location_id
FROM employees JOIN departments d ON (e.department_id=d.department_id)

--SQL 3 -USING
SELECT last_name, department_name,location_id
FROM employees JOIN departments d using (department_id)

--DORIM SA AFISAM SI ANG FARA DEPARTMENT -> (+)
SELECT last_name,department_name,location_id
FROM employees e, departments d
WHERE e.department_id=d.department_id (+);

--dorim sa afisam TOTI angajatii
SELECT last_name, department_name, location_id
FROM employees e LEFT join departments d ON (e.department_id= d.department_id)

-- dorim sa afisam toate departamentele chiar daca au sau nu angajati
SELECT last_name, department_name, location_id
FROM employees e RIGHT JOIN departments d ON (e.department_id)-- .........:(;




--ex 1
select ang.last_name, to_char(hire_date,'month-yyyy'),gates.last_name
from employees ang join employees gates ON (ang.department_id=gates.department_id)
WHERE initcap(gates.last_name)='Gates' and lower(ang.last_name) like "%a%"
	and ang.last_name != 'Gates';

--ex2
select e.employee_id ,e.last_name,department_id,department_name
from employees e JOIN employees t on (e.department_id = d.department_id)
			JOIN departments d on (e.department_id = d.department_id);
where lower(t.last_name) like'%t%'
order by e.last_name;	-- sau order by 2;		

--ex 3
SELECT e.last_name,e.salary,job_title,city, country_name,k.last_name 
FROM employees e JOIN employees k on(e.manager_id = k.employee_id)
				 JOIN jobs j on (e.job_id = j.job_id)
				 JOIN departments d on (e.department_id = d.department_id)
				 JOIN locations l on (d.location_id = l.locations_id)
				 join countries c on (l.country_id = c.country_id);
WHERE initcap(k.last_name) like 'King';

--ex 4
SELECT d.department_id,department_name, job_id, last_name, to_char(salary,'$99,999.00')
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
where lower(department_name) like '%ti%'
ORDER BY department_name, last_name;

--ex 5
SELECT last_name, department_name, location_id
FROM employees e FULL JOIN departments d ON (e.department_id=d.department_id);

--var 2
SELECT last_name, department_name,location_id
FROM employees e LEFT JOIN departments d ON (e.department_id=d.department_id)

UNION -- elementele comune si necomune luate o singura data

--dorim sa afisam TOATE depart chiar daca au sau nu angajati
SELECT last_name,department_name,location_id
FROM employees e RIGHT JOIN departments d ON(e.department_id = d.department_id);

--ex6
-- operatori pe multimi
SELECT department_id
FROM departments
WHERE lower(department_name) like '%re%'--40,70,120,140,150,250,260

UNION

SELECT department_id
FROM employees
where upper(job_id) like '%SA_REP%'; -- 80,NULL


--join

SELECT d.department_id 
FROM employees e FULL JOIN departments d on (e.department_id = d.department_id)
where lower(department_name) like '%re%' or upper(job_id) like '%SA_REP%';
ORDER by 1; -- prima coloana din selct

--ex 8

--var 1 cu join
SELECT *
from employees e right join departments d on (e.department_id = d.department_id);

--codurile depart in care nu lucreaza nimeni
SELECT d.department_id -- pentru ca in d - departament_id este cheie primara si nu poate fi null
from employees e right join departments d on (e.department_id = d.department_id);
where employee_id is null;

WHERE e.department_id is NULL




--var 2 (!!!!!!*****!!!!!) ex important si util
SELECT department_id "Cod departament"
FROM departments -- din lista tuturor departamentelor(departament_id e pk)

MINUS --scade
SELECT department_id
FROM employees;--departamentele in care lcureaza angajati (department_id este cheie externa)

-- => obtinem departamentele  fara angajati






