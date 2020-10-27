--1
SET SERVEROUTPUT ON;
DECLARE
    numar number(3) :=100;
    mesaj1 varchar2(255) :='text 1';
    mesaj2 varchar2(255) :='text 2';
BEGIN
    DECLARE
        numar number(3) :=1;
        mesaj1 varchar2(255):='text 2';
        mesaj2 varchar2(255):='text 3';
    BEGIN
        numar:=numar+1;
        mesaj2:=mesaj2||' adaugat in sub-blooc';
        DBMS_OUTPUT.PUT_LINE(numar);
        DBMS_OUTPUT.PUT_LINE(mesaj1);
        DBMS_OUTPUT.PUT_LINE(mesaj2);
    END;
    numar:=numar+1;
    mesaj1:=mesaj1||' adaugat in blocul principal';
    mesaj2:=mesaj2||' adaugat in blocul principal';
    DBMS_OUTPUT.PUT_LINE(numar);
    DBMS_OUTPUT.PUT_LINE(mesaj1);
    DBMS_OUTPUT.PUT_LINE(mesaj2);
END;
/

-- a) 2
-- b) text 2
-- c) text 3 adaugat in sub-bloc
-- d) 101
-- e) text 1 adaugat in bloc principal
-- f) text 2 adaugat in bloc principal

--2 (Doar partea cu tabelul cu datele dintr-o luna)
CREATE TABLE OCTOMBRIE_SUS(
    id int primary key not null,
    data date default sysdate
);
SELECT * FROM OCTOMBRIE_SUS;
DELETE FROM OCTOMBRIE_SUS;
DECLARE
    contor   NUMBER(6) := 1;
    v_data   DATE;
    maxim    DATE := last_day(sysdate) ;
BEGIN
LOOP v_data := last_day(sysdate-31) + contor;
INSERT
    INTO OCTOMBRIE_SUS VALUES (
    contor,
    v_data
);
    contor := contor + 1;
    EXIT WHEN v_data = maxim;
END LOOP;
END;

--3
DECLARE
    nume_cautat  member.first_name%TYPE:='&numele';
    id_cautat  member.member_id%TYPE;
    numar_imprumuturi number(3);
BEGIN
    SELECT member_id INTO id_cautat
    FROM member
    where first_name = nume_cautat;
    SELECT COUNT(*) INTO numar_imprumuturi
    FROM rental
    WHERE member_id = id_cautat;
    DBMS_OUTPUT.PUT_LINE(numar_imprumuturi);
EXCEPTION
    WHEN NO_DATA_FOUND then
        raise_application_error(-20000,'Nu am gasit acest nume');
    WHEN TOO_MANY_ROWS then
        raise_application_error(-20000,'Exista mai multi oameni cu acelasi nume');
END;
/  

--4
DECLARE
    nume_cautat  member.first_name%TYPE:='&numele';
    id_cautat  member.member_id%TYPE;
    numar_imprumuturi number(3);
    categorie member.first_name%TYPE;
    numar_filme number(3);
BEGIN
    SELECT member_id INTO id_cautat
    FROM member
    where first_name = nume_cautat;
    
    SELECT COUNT(DISTINCT title_id) INTO numar_imprumuturi
    FROM rental
    WHERE member_id = id_cautat;
    
    DBMS_OUTPUT.PUT_LINE(numar_imprumuturi);
    
    SELECT COUNT(DISTINCT title_id) INTO numar_filme
    FROM title;
    
    CASE WHEN numar_imprumuturi >= 0.75 * numar_filme
            THEN categorie:='Categorie 1';
         WHEN numar_imprumuturi >= 0.5 * numar_filme
            THEN categorie:='Categorie 2'; 
         WHEN numar_imprumuturi >= 0.25 * numar_filme
            THEN categorie:='Categorie 3'; 
         ELSE categorie:='Categorie 4';
    END CASE;
         
    DBMS_OUTPUT.PUT_LINE(categorie);

EXCEPTION
    WHEN NO_DATA_FOUND then
        raise_application_error(-20000,'Nu am gasit acest nume');
    WHEN TOO_MANY_ROWS then
        raise_application_error(-20000,'Exista mai multi oameni cu acelasi nume');
END;
/  

--5
CREATE TABLE member_hco as SELECT * FROM member;
 
select * from member_hco;

ALTER TABLE member_hco
ADD Discount number DEFAULT 0;
 SET SERVEROUT ON;
 DECLARE
    id_cautat  member.member_id%TYPE:=&id_input;
    numar_imprumuturi number(3);
    categorie member.first_name%TYPE;
    numar_filme number(3);
BEGIN
    SELECT COUNT(DISTINCT title_id) INTO numar_imprumuturi
    FROM rental
    WHERE member_id = id_cautat;
  
    SELECT COUNT(DISTINCT title_id) INTO numar_filme
    FROM title;
 
    CASE WHEN numar_imprumuturi >= 0.75 * numar_filme
            THEN UPDATE member_sus SET discount = 10 WHERE member_id =id_cautat;
         WHEN numar_imprumuturi >= 0.5 * numar_filme
            THEN UPDATE member_sus SET discount =  5 WHERE member_id =id_cautat;
         WHEN numar_imprumuturi >= 0.25 * numar_filme
            THEN UPDATE member_sus SET discount = 3 WHERE member_id =id_cautat;
         ELSE UPDATE member_sus SET discount = 0 WHERE member_id =id_cautat;
    END CASE;

 
    DBMS_OUTPUT.PUT_LINE('Tabelul s-a modificat');
 
EXCEPTION
    WHEN NO_DATA_FOUND then
        raise_application_error(-20000,'Nu am gasit acest id');
    WHEN TOO_MANY_ROWS then
        raise_application_error(-20000,'Exista mai multi oameni cu acelasi nume');
END;
/
