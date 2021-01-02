--1
CREATE TABLE error_hco(
    cod NUMBER,
    mesaj VARCHAR(100)
    );
DROP TABLE error_hco;
SELECT * FROM error_hco;
SELECT * FROM emp_hco ORDER BY salary;
DECLARE
  numar NUMBER := &numarTastatura;
  numarNegativ EXCEPTION;
begin
    IF(numar<0) THEN
        RAISE numarNegativ;
    END IF;
  DBMS_OUTPUT.PUT_LINE(SQRT(numar));
EXCEPTION
    WHEN numarNegativ THEN
        INSERT INTO ERROR_HCO VALUES (-20001,'Numar mai mic decat 0');
        DBMS_OUTPUT.PUT_LINE('Numar negativ');
end;
/
--2
DECLARE
  salariu emp_hco.salary%TYPE := &salariuCautat;
  numeAng emp_hco.last_name%TYPE;
begin
  select last_name
    into numeAng
    from emp_hco
   where salary = salariu;
   DBMS_OUTPUT.PUT_LINE(numeAng);
exception
  when no_data_found then
    DBMS_OUTPUT.PUT_LINE('Nu am gasit angajat cu salariul introdus');
    insert into error_hco 
    values (-20001,'Nu exista angajati cu salariul '||salariu);
  WHEN too_many_rows THEN
    DBMS_OUTPUT.PUT_LINE('Sunt mai multi angajati cu acest salariu');
    insert into error_hco 
    values (-20001,'Prea multi angajati cu salariul: '||salariu);
end;
/

--3
DECLARE
  cod_dept departments.department_id%TYPE := &dept;
  numarAng NUMBER;
  lucreazaAngajati EXCEPTION;
begin
  SELECT COUNT(*) INTO numarAng FROM emp_hco WHERE department_id = cod_dept;
  IF numarAng > 0 THEN
    RAISE lucreazaAngajati;
  END IF;
exception
  when lucreazaAngajati then
    DBMS_OUTPUT.PUT_LINE('Nu se poate modifica codul unui departament in care lucreaza angajati');
    insert into error_hco 
    values (-20001,'Departament care nu e gol ');
end;
/

--4
DECLARE
  int_start number := &intervalStart;
  int_end number := &intervalEnd;
  numarAng NUMBER;
  numeDept departments.department_name%TYPE;
  inAfaraInterval exception;
begin
select department_name
  into numeDept
  from departments
 where department_id = 10;
  SELECT COUNT(*) INTO numarAng FROM emp_hco WHERE department_id= 10;
  IF numarAng < int_start OR numarAng > int_end THEN
    RAISE inAfaraInterval;
  ELSE
    DBMS_OUTPUT.PUT_LINE(numeDept);
  END IF;
exception
  when inAfaraInterval then
    DBMS_OUTPUT.PUT_LINE('Numarul de ang este in afara intervalului');
    insert into error_hco 
    values (-20001,'In afara intervalului');
end;
/

--5
CREATE TABLE dept_hco AS (SELECT * FROM departments);
DECLARE
  cod_dept dept_hco.department_id%TYPE := &numarDept;
  gasitDept NUMBER;
begin
  select COUNT(*)
    into gasitDept
    from dept_hco
   where department_id = cod_dept;
   IF gasitDept = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exist departamentul cu id-ul introdus');
        INSERT INTO error_hco
        VALUES(-20001,'Dept inexistent');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Am gasit departamentul cu id-ul '|| cod_dept);
        update dept_hco
           set department_name='Nume dept nou'
         where department_id = cod_dept;
    
   END IF;
end;
/

--6
SELECT * FROM dept_hco ORDER by location_id; 
SELECT * FROM locations;
DECLARE
  locatie locations.city%TYPE := '&locatiaDept';
  numeDeptLoc dept_hco.department_name%TYPE;
  codDept dept_hco.department_id%TYPE := &codDeptCautat;
  numeDeptCod dept_hco.department_name%TYPE;
begin
  select department_name  
    into numeDeptLoc
    from locations l  JOIN dept_hco d USING (location_id)
   where l.city = locatie;
    DBMS_OUTPUT.PUT_LINE(numeDeptLoc);
    
    select department_name  
    into numeDeptCod
    from dept_hco WHERE department_id = codDept;
    DBMS_OUTPUT.PUT_LINE(numeDeptCod);
   
exception
  when no_data_found then
    if numeDeptLoc is null then
        DBMS_OUTPUT.PUT_LINE('Fara randuri pentru locatie');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fara randuri pentru id');
    END IF;
end;