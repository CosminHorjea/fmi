--Laborator 1
--1
--a falsa
DESC employees;
--b adevarat
--c falsa

--2
--a falsa
--b PRIMARY KEY(COL1, COL2) falsa
--c falsa
--d adevarata

--3
--a adevarata
--b adevarata
--c falsa
--d adevarata

--4 d

--5 c

--6 a
SELECT (SELECT first_name
        FROM employees
        WHERE employee_id = 100)
FROM DUAL;

--7 a

--8 c

--9 c

--10 d

--11
CREATE TABLE emp_prof
AS SELECT * FROM employees;

COMMENT ON TABLE emp_prof IS 'Informa?ii despre angajati';

--12
DESC user_tab_comments;

SELECT *
FROM user_tab_comments
WHERE INITCAP(table_name) = INITCAP('emp_prof');

--13
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY HH24:mi:ss';

SELECT SYSDATE
FROM DUAL;

--14
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual;

--15
SELECT EXTRACT(MONTH FROM SYSDATE)
FROM dual;

SELECT EXTRACT(DAY FROM SYSDATE)
FROM dual;

--16
SELECT *
FROM user_tables
WHERE UPPER(table_name) LIKE UPPER('%PRoF');

--17-22
SET FEEDBACK OFF;
SET PAGESIZE 0;
SPOOL sterg_tabele.sql
SELECT 'DROP TABLE ' || table_name || ' cascade constraint; '
FROM user_tables
WHERE UPPER(table_name) LIKE UPPER('%PRoF');
SPOOL OFF

--23 TEMA
SPOOL E:\insert_in_tabel.sql
SELECT 'INSERT INTO ' || table_name || ' SELECT * from departments '
FROM user_tables
WHERE UPPER(table_name) LIKE UPPER('%HCO');
SPOOL OFF
