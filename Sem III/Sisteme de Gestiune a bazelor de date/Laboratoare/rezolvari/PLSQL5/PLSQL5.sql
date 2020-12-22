SELECT * from emp_hco;
SELECT * FROM job_history;
CREATE SEQUENCE secv_hco
  MINVALUE 1
  START WITH 207
  INCREMENT BY 1
  CACHE 20;
  
CREATE OR REPLACE PACKAGE pachet_hco AS
    --a)
    
    PROCEDURE adauga_ang(nume emp_hco.last_name%TYPE,
                         prenume emp_hco.first_name%TYPE,
                         email emp_hco.email%TYPE,
                         telefon emp_hco.phone_number%TYPE,
                         nume_job jobs.job_title%TYPE,
                         nume_mng emp_hco.last_name%TYPE,
                         prenume_mng emp_hco.first_name%TYPE,
                         nume_dept departments_hco.department_name%TYPE
                         );

    FUNCTION celMaiMicSalariu(codDept emp_hco.department_id%TYPE)
    RETURN emp_hco.salary%TYPE;-- intorc cel mai mic salariu dintr-un job dat
    
    FUNCTION gasesteManager(nume emp_hco.last_name%TYPE,prenume emp_hco.first_name%TYPE)
    RETURN emp_hco.employee_id%TYPE; -- gasesc id-ul unui angajat dupa nume si prenume
    
    FUNCTION gasesteCodDept(nume_dept departments_hco.department_name%TYPE)
    return departments_hco.department_id%TYPE; -- introc codul departamentului cu numele din param
    
    FUNCTION gasesteCodJob(nume_job jobs.job_title%TYPE)
    RETURN jobs.job_id%TYPE;-- intoarce codul unui job care are numele dat
    
    --b)
    PROCEDURE mutaAngajat(nume emp_hco.last_name%TYPE,
                         prenume emp_hco.first_name%TYPE,
                         nume_dept departments_hco.department_name%TYPE,
                         nume_job jobs.job_title%TYPE,
                         nume_mng emp_hco.last_name%TYPE,
                         prenume_mng emp_hco.first_name%TYPE);
    --c)
    FUNCTION calculeazaNumarSubalterni(nume emp_hco.last_name%TYPE , prenume emp_hco.first_name%TYPE)
        RETURN NUMBER;
    --d)
    PROCEDURE promoveazaAngajat(codAng emp_hco.employee_id%TYPE);

    --e)
    PROCEDURE actualizeazaSalariu(nume emp_hco.last_name%TYPE,salariu_nou emp_hco.salary%TYPE);

    --f)
    CURSOR listaAng(codJob emp_hco.job_id%TYPE) RETURN emp_hco%ROWTYPE;

    --g)
    CURSOR toateJoburile RETURN jobs%ROWTYPE;

    --h)
    PROCEDURE listaAngJob;



END pachet_hco;
/

CREATE OR REPLACE PACKAGE BODY pachet_hco AS

    --f)
    CURSOR listaAng(codJob emp_hco.job_id%TYPE) RETURN emp_hco%ROWTYPE
        IS
        SELECT * FROM emp_hco WHERE job_id=codJob;
    
    --g)
    CURSOR toateJoburile RETURN jobs%ROWTYPE
        IS
        SELECT * FROM jobs;
   
    PROCEDURE adauga_ang(nume emp_hco.last_name%TYPE,
                         prenume emp_hco.first_name%TYPE,
                         email emp_hco.email%TYPE,
                         telefon emp_hco.phone_number%TYPE,
                         nume_job jobs.job_title%TYPE,
                         nume_mng emp_hco.last_name%TYPE,
                         prenume_mng emp_hco.first_name%TYPE,
                         nume_dept departments_hco.department_name%TYPE
                         )
                         AS
            mng_id emp_hco.employee_id%TYPE := gasesteManager(nume_mng,prenume_mng);
            codJob emp_HCO.job_id%TYPE := gasesteCodJob(nume_job);
            salariuNou emp_HCO.salary%TYPE := celMaiMicSalariu(codJob);
            codDept emp_hco.department_id%TYPE := gasesteCodDept(nume_dept);
    BEGIN
            insert into emp_hco
            values (secv_hco.NEXTVAL,prenume,nume,email,telefon,SYSDATE,codJob,salariuNou,NULL,mng_id,codDept);
            DBMS_OUTPUT.PUT_LINE('Angajatul a fost adaugat!');
    END adauga_ang;
    
     FUNCTION celMaiMicSalariu(codDept emp_hco.department_id%TYPE)
        RETURN emp_hco.salary%TYPE
    IS
        salariu emp_hco.salary%TYPE;
    BEGIN   
        SELECT MIN(salary) INTO salariu
        FROM emp_HCO where department_id = codDept;
    return salariu;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista departamentul specificat');
    END celMaiMicSalariu;
    
    FUNCTION gasesteManager(nume emp_hco.last_name%TYPE,prenume emp_hco.first_name%TYPE)
        RETURN emp_hco.employee_id%TYPE
    IS
        mng_id emp_hco.employee_id%TYPE;
    BEGIN
        SELECT employee_id into mng_id FROM emp_hco
        WHERE last_name = nume AND first_name = prenume;
        
        RETURN mng_id;
    EXCEPTION
        WHEN NO_DATA_FOUND then
            dbms_output.put_line('Nu exista manger cu numele introdus');
    
    END gasesteManager;

    FUNCTION gasesteCodDept(nume_dept departments_hco.department_name%TYPE)
        RETURN departments_hco.department_id%TYPE
    IS  
        codDept departments_hco.department_id%TYPE;
    BEGIN   
        SELECT department_id INTO codDept FROM departments_hco
        WHERE UPPER(department_name) = UPPER(nume_dept);
        RETURN codDept;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista departament cu numele specificat');
    END gasesteCodDept;

    FUNCTION gasesteCodJob(nume_job jobs.job_title%TYPE)
        RETURN jobs.job_id%TYPE
    IS
        codJob emp_hco.job_id%TYPE;
    BEGIN
        SELECT job_id INTO codJob
        FROM jobs
        WHERE UPPER(job_title) = UPPER(nume_job);

        RETURN codJob;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('Nu exista job cu numele specificat');
    END gasesteCodJob;

    --b)
    PROCEDURE mutaAngajat(nume emp_hco.last_name%TYPE,
                         prenume emp_hco.first_name%TYPE,
                         nume_dept departments_hco.department_name%TYPE,
                         nume_job jobs.job_title%TYPE,
                         nume_mng emp_hco.last_name%TYPE,
                         prenume_mng emp_hco.first_name%TYPE)
    AS
        codAng emp_hco.employee_id%TYPE;
        dataAngAnterioara emp_hco.hire_date%TYPE;
        codDept emp_hco.department_id%TYPE := gasesteCodDept(nume_dept);
        codDeptVechi emp_hco.department_id%TYPE ;
        codJob emp_hco.job_id%TYPE := gasesteCodJob(nume_job);
        codJobVechi emp_hco.job_id%TYPE ;
        codMng emp_hco.employee_id%TYPE := gasesteManager(nume_mng,prenume_mng);
        salariuDeptNou emp_hco.salary%TYPE := celMaiMicSalariu(codDept);
        salariuAdevarat emp_hco.salary%TYPE;
        comision emp_hco.commission_pct%TYPE;
    begin
        --gasesc id-ul
        SELECT employee_id INTO codAng
        FROM emp_hco WHERE last_name = nume and first_name = prenume;
        --gasesc data de angajare
        SELECT hire_date INTO dataAngAnterioara
        FROM emp_hco WHERE employee_id = codAng;

        SELECT job_id INTO codJobVechi
        FROM emp_hco WHERE employee_id = codAng;

        SELECT job_id INTO codDeptVechi
        FROM emp_hco WHERE employee_id = codAng;
        --adaug o intrare in job_history
        insert into job_history 
        values (codAng,dataAngAnterioara,SYSDATE,codJobVechi,codDeptVechi);

        --gasesc salariul
        SELECT salary INTO salariuAdevarat
        FROM emp_hco WHERE employee_id = codAng;
        IF salariuAdevarat < salariuDeptNou THEN
            salariuAdevarat := salariuDeptNou;
        END IF;

        --gasesc comisionul
        SELECT MIN(commission_pct) INTO comision 
        FROM emp_hco
        WHERE department_id=codDept AND job_id = codJob;

        update emp_hco
           set department_id=codDept,
               job_id=codJob,
               manager_id=codMng,
               salary=salariuAdevarat,
               commission_pct=comision,
               hire_date = SYSDATE
         where employee_id=codAng;

    end mutaAngajat;

    --c)
    FUNCTION calculeazaNumarSubalterni(nume emp_hco.last_name%TYPE , prenume emp_hco.first_name%TYPE)
        RETURN NUMBER
    AS
        numarSubalterni NUMBER;
        codAng emp_HCO.employee_id%TYPE;
    begin
        SELECT employee_id INTO codAng
        FROM emp_hco WHERE last_name = nume and first_name = prenume;

        SELECT COUNT(*) INTO numarSubalterni
        FROM emp_hco e
        START WITH e.manager_id = codAng
        CONNECT BY PRIOR e.employee_id=e.manager_id;
        
        return numarSubalterni;
    end calculeazaNumarSubalterni;
        
    --d)
    PROCEDURE promoveazaAngajat(codAng emp_hco.employee_id%TYPE)
    AS
        codMng emp_hco.manager_id%TYPE;
        codMngNou emp_hco.manager_id%TYPE;
        codMngColeg emp_hco.employee_id%TYPE;
    begin
        --managerul care conduce angajatul dat ca param.
        SELECT manager_id INTO codMng
        FROM emp_hco WHERE employee_id = codAng;
        IF codMng IS NULL THEN    
            RAISE_APPLICATION_ERROR(-20000,'Angajatul nu are superior');
        END IF;

        --managerul care o sa-l conduca pe angajatul din param 
        SELECT manager_id INTO codMngNou
        FROM emp_hco WHERE employee_id = codMng;
        
        -- un alt angajat pe acelasi nivel al ierarhiei
        SELECT employee_id INTO codMngColeg
        FROM emp_hco WHERE employee_id != codAng AND manager_id = codMng;

        -- angajatii care erau supervizati de angajatul din param. o sa fie supervizati de un coelg de-al acestuia
        update emp_hco
           set manager_id=codMngColeg
         where manager_id=codAng;

        -- angajatul urca in ierarhie
        update emp_hco
           set manager_id=codMngNou
         where employee_id = codAng;

    end promoveazaAngajat;

    --e)
    PROCEDURE actualizeazaSalariu(nume emp_hco.last_name%TYPE,salariu_nou emp_hco.salary%TYPE)
    AS
        numarAngajati NUMBER;
        codAng  emp_hco.employee_id%TYPE;
        codJob emp_hco.job_id%TYPE;
        salariuMax emp_HCO.salary%TYPE;
        salariuMin emp_HCO.salary%TYPE;
    begin
        SELECT count(*) INTO numarAngajati 
        FROM emp_hco where last_name = nume;

        IF numarAngajati = 1 THEN
            SELECT employee_id,job_id INTO codAng,codJob FROM emp_hco
            WHERE last_name = nume;

            select MAX(salary),MIN(salary)
              into salariuMax, salariuMin
              from emp_hco
             where job_id = codJob;
            
            if salariu_nou >= salariuMin AND salariu_nou<= salariuMax THEN
                update emp_hco
                   set salary = salariu_nou
                 where employee_id = codAng;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Salariul nu respecta constrangerile');
                raise_application_error(-20000, 'Salariul invalid');
            END IF;

        ELSIF numarAngajati > 1 THEN
            DBMS_OUTPUT.PUT_LINE('Angajatii cu numele: '|| nume);
            FOR angajat IN (SELECT * FROM emp_hco where last_name = nume) loop
              DBMS_OUTPUT.PUT_LINE(angajat.first_name || ' ' || angajat.last_name);
            end loop;
        END IF;
      
    exception
      when NO_DATA_FOUND then
        DBMS_OUTPUT.Put_LINE('Nu exista angajati cu numele dat');
    end actualizeazaSalariu;

    

    --h)
    PROCEDURE listaAngJob 
    IS
        aMaiLucrat NUMBER := 0;
    BEGIN
        FOR job IN toateJoburile loop
            DBMS_OUTPUT.PUT_LINE(job.job_title);
          FOR ang IN listaAng(job.job_id)loop
            DBMS_OUTPUT.PUT(ang.last_name||ang.first_name|| ' ');
            SELECT COUNT(*) INTO aMaiLucrat FROM job_history WHERE employee_id = ang.employee_id AND job_id=job.job_id;
            
            IF aMaiLucrat = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Nu a mai lucrat in acest job');
            ELSE
                DBMS_OUTPUT.PUT_LINE('A mai lucrat in acest job');
            END IF;
          end loop;
          DBMS_OUTPUT.PUT_LINE('');
        end loop;
    END listaAngJob;

END pachet_hco;
/

BEGIN
    pachet_hco.listaAngjob();
END;
/
SELECt * from emp_hco;

  



