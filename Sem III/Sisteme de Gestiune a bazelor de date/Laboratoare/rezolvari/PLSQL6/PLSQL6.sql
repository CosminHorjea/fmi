--ex1
CREATE OR REPLACE TRIGGER trig1_hco
  BEFORE DELETE ON emp_hco
begin
  IF UPPER(USER) <> UPPER('SCOTT') then  
    raise_application_error(-20000, ' Nu aveti dreptul de a sterge entitati');
  END IF;
end;
/
--ex2
CREATE OR REPLACE TRIGGER trig2_hco
  BEFORE UPDATE OF commission_pct ON emp_hco
  FOR EACH ROW
begin
  if(:NEW.commission_pct > 0.5) then
    raise_application_error(-20000, 'Comisionul este prea mare');
  END IF;
end;
/

--ex 3
ALTER TABLE info_dept_hco
ADD numar NUMBER(5);

update info_dept_hco d
   set numar=(SELECT COUNT(employee_id) FROM emp_hco e WHERE e.department_id = d.id);

CREATE OR REPLACE TRIGGER trig3_hco
  AFTER DELETE OR UPDATE OR INSERT ON info_emp_hco 
  FOR EACH ROW
BEGIN
  IF inserting then
    update info_dept_hco
       set numar=numar+1
     where id=:NEW.id_dept;
  elsif DELETING then
    update info_dept_hco
       set numar=numar-1
     where id=:OLD.id_dept;
  elsif UPDATING then
    IF(:NEW.id_dept != :OLD.id_dept) then
      update info_dept_hco
       set numar=numar+1
     where id=:NEW.id_dept;
     update info_dept_hco
       set numar=numar-1
     where id=:OLD.id_dept;
    end if; 
  END IF;
END;
/

--ex 4
CREATE OR REPLACE TRIGGER trig4_hco
  BEFORE INSERT ON emp_hco
  FOR EACH ROW
DECLARE
    numarAng NUMBER(3);
begin
    SELECT COUNT(*) INTO numarAng FROM emp_hco WHERE department_id = :NEW.department_id;
  IF numarAng = 45 then
    raise_application_error(-20000, 'Prea multi angajati intr-un departament');
  END IF;
end;
/

--ex5
CREATE TABLE emp_test_hco(
  employee_id NUMBER(3) PRIMARY KEY,
  last_name VARCHAR2(20),
  first_name VARCHAR2(20),
  department_id NUMBER(3) REFERENCES dept_test_hco
);
CREATE TABLE dept_test_hco(
  department_id NUMBER(3) PRIMARY KEY,
  department_name VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trig5_hco
  AFTER DELETE OR UPDATE ON dept_test_hco
  FOR EACH ROW
begin
  IF DELETING THEN
    delete from emp_test_hco
    where department_id = :OLD.department_id;
  ELSIF UPDATING then
    update emp_test_hco
       set department_id=:NEW.department_id
     where department_id = :OLD.department_id;
  END IF;
end;
/
--6
CREATE TABLE erori_hco(
  user_id VARCHAR2(20),
  nume_bd VARCHAR2(20),
  erori NUMBER,
  data DATE
);
CREATE OR REPLACE TRIGGER trig6_hco
  AFTER SERVERERROR ON SCHEMA
begin
  insert into erori_hco 
  values (SYS.LOGIN_USER,SYS.DATABASE_NAME,DBMS_UTILITY.FORMAT_ERROR_STACK,SYSDATE);
end;
/
--ex din lab

CREATE TABLE info_emp_hco(
  id NUMBER(3) PRIMARY KEY,
  nume VARCHAR2(20),
  prenume VARCHAR2(20),
  salariu NUMBER(10),
  id_dept NUMBER(5) REFERENCES info_dept_hco
);

insert into info_emp_hco (SELECT employee_id,first_name,salary,department_id);

CREATE OR REPLACE PROCEDURE modific_plati_hco
  (v_codd info_dept_hco.id%TYPE,
   v_plati info_dept_hco.plati%TYPE) AS
begin
  update info_dept_hco
     set plati=NVL(plati,0) + v_plati
   where id=v_codd;
end;
/

CREATE OR REPLACE TRIGGER trig4_hco
  AFTER DELETE OR update or INSERT OF salary on emp_hco
  FOR EACH ROW
begin
  IF DELETING then
    modific_plati_hco(:OLD.department_id, -1*:OLD.salary);
  elsif UPDATING then
    modific_plati_hco(:OLD.department_id,:NEW.salary-:OLD.salary);
  ELSE
    modific_plati_hco(:NEW.department_id,:NEW.salary);
  END IF;
    
end;
/
CREATE TABLE info_dept_hco(
    id NUMBER(5) PRIMARY KEY,
    nume_dept VARCHAR2(15) NOT NULL,
    plati NUMBER(10)
);

insert into info_dept_hco 
(SELECT d.department_id, d.department_name, 
        (select nvl(sum(salary),0) 
        from employees 
        where department_id = d.department_id) 
from departments d)


CREATE OR REPLACE TRIGGER trig1_hco
  BEFORE INSERT OR UPDATE OR DELETE ON emp_hco
begin
  if (TO_CHAR(SYSDATE,'D') = 1) OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 and 20)then
    raise_application_error(-20000, 'tabelul nu poate fi actualizat');
  end if;
end;
/
DROP TRIGGER trig1_hco;