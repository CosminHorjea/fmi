--Creez table actori
CREATE TABLE Actors(
  ActorID NUMBER NOT NULL,
  Name VARCHAR2(50) NOT NULL,
  BirthDay DATE NOT NULL);
  
-- pun cheia primara
ALTER TABLE actors ADD (
  CONSTRAINT actorsPK PRIMARY KEY (ActorID));
--creez o seventa care sa se ocupe cu id-urile actorilor
CREATE SEQUENCE actors_seq START WITH 1;

CREATE OR REPLACE TRIGGER actors_trig 
BEFORE INSERT ON actors 
FOR EACH ROW

BEGIN
  SELECT actors_seq.NEXTVAL
  INTO   :new.actorid
  FROM   dual;
END;
/
SELECT * FROM actors;
INSERT INTO Actors(name,birthday) VALUES('Leonardo DiCaprio',TO_DATE('11-11-1974','DD-MM-YYYY'));
INSERT INTO Actors(name,birthday) VALUES('Christian Bale',TO_DATE('30-01-1974','DD-MM-YYYY'));
INSERT INTO Actors(name,birthday) VALUES('Matt Damon',TO_DATE('08-10-1970','DD-MM-YYYY'));
INSERT INTO Actors(name,birthday) VALUES('Robert Pattinson',TO_DATE('13-05-1986','DD-MM-YYYY'));
INSERT INTO Actors(name,birthday) VALUES('Mark Wahlberg',TO_DATE('08-06-1971','DD-MM-YYYY'));
INSERT INTO Actors(name,birthday) VALUES('Jaime Foxx',TO_DATE('13-12-1967','DD-MM-YYYY'));
--Talena Genuri
CREATE TABLE GENRES (
  genreID NUMBER(4) NOT NULL PRIMARY KEY,
  name VARCHAR2(30)
);

insert into GENRES values (1,'Horror');
insert into GENRES values (2,'Action');
insert into GENRES values (3,'Drama');
insert into GENRES values (4,'Animation');
insert into GENRES values (5,'Western');
insert into GENRES values (6,'Documentary');

SELECT * FROM Genres;
--tablea regizori
CREATE TABLE Directors(
  DirectorID NUMBER(10) NOT NULL PRIMARY KEY,
  name VARCHAR2(30)
);
insert into Directors values (1,'Pete Dockter');
insert into Directors values (2,'David O. Russel');
insert into Directors values (3,'Cristopher Nolan');
insert into Directors values (4,'Alexandru Nanau');
insert into Directors values (5,'Bryan Singer');
SELECT * FROM Directors;

CREATE TABLE Movies(
  MovieID NUMBER(10) NOT NULL PRIMARY KEY,
  title VARCHAR2(30),
  duration NUMBER(3),
  released_date DATE,
  genreID NUMBER(5) REFERENCES GENRES,
  DirectorID NUMBER(5) REFERENCES Directors
);

--creez o secventa pe care o folosesc la trigger
CREATE SEQUENCE movies_seq START WITH 1;

CREATE OR REPLACE TRIGGER movies_trig 
BEFORE INSERT ON movies 
FOR EACH ROW

BEGIN
  SELECT movies_seq.NEXTVAL
  INTO   :new.movieID
  FROM   dual;
END;
/

INSERT INTO Movies(title,duration,released_date,genreID,directorID) 
VALUES ('Soul',100,TO_DATE('25-12-2020','DD-MM-YYYY'),4,1);

INSERT INTO Movies(title,duration,released_date,genreID,directorID) 
VALUES ('Tenet',150,TO_DATE('26-08-2020','DD-MM-YYYY'),2,3);

INSERT INTO Movies(title,duration,released_date,genreID,directorID) 
VALUES ('The Usual Suspects',106,TO_DATE('25-01-1995','DD-MM-YYYY'),3,5);

INSERT INTO Movies(title,duration,released_date,genreID,directorID) 
VALUES ('Collective',106,TO_DATE('04-09-2019','DD-MM-YYYY'),6,4);

INSERT INTO Movies(title,duration,released_date,genreID,directorID) 
VALUES ('The Fighter',116,TO_DATE('06-12-2010','DD-MM-YYYY'),3,2);

SELECT * FROm MOVIES;
--
Create Table Actor_movie(
  MovieID NUMBER,
  ActorID NUMBER
);

ALTER TABLE actor_movie
ADD CONSTRAINT fk_actor FOREIGN KEY(ActorID)
REFERENCES Actors(ActorID);

ALTER TABLE Actor_movie
ADD CONSTRAINT fk_moview FOREIGN KEY(MovieID)
REFERENCES Movies(MovieID);

SELECT * FROM actors;
SELECT * FROM movies;

INSERT INTO ACTOR_MOVIE VALUES (5,3);
INSERT INTO ACTOR_MOVIE VALUES (5,1);
INSERT INTO ACTOR_MOVIE VALUES (5,2);
INSERT INTO ACTOR_MOVIE VALUES (3,2);
INSERT INTO ACTOR_MOVIE VALUES (3,4);
INSERT INTO ACTOR_MOVIE VALUES (3,5);
INSERT INTO ACTOR_MOVIE VALUES (1,2);
INSERT INTO ACTOR_MOVIE VALUES (1,4);
INSERT INTO ACTOR_MOVIE VALUES (1,5);
INSERT INTO ACTOR_MOVIE VALUES (2,4);

SELECT * FROM ACTOR_MOVIE;

SELECT * FROM movies join ACTOR_MOVIE USING(MovieID) JOIN actors USING (ActorID);

SELECT * FROM CINEMAS;
--
CREATE TABLE CINEMAS(
  CinemaID NUMBER PRIMARY KEY NOT NULL,
  Name VARCHAR2(30),
  AdressID NUMBER
);
insert into CINEMAS values (1,'AFI Palace',1);
insert into CINEMAS values (2,'Lumea Noua',2);
insert into CINEMAS values (3,'Orizont',3);
--
CREATE TABLE ADRESSES(
  AdressID NUMBER PRIMARY KEY NOT NULL,
  City VARcHAR2(30),
  Street VARCHAR(30)
);

insert into ADRESSES values (1,'Bucuresti','Militari');
insert into ADRESSES values (2,'Timisoara','Centrala');
insert into ADRESSES values (3,'Brasov','Mihai Viteazul');
SELECT * FROM ADRESSES; 

ALTER TABLE CINEMAS ADD CONSTRAINT fk_adress 
FOREIGN KEY (AdressID) REFERENCES ADRESSES(AdressID);
--
CREATE TABLE Employees(
  EmployeeID NUMBER PRIMARY KEY NOT NULL,
  Name VARCHAR2(30),
  salary NUMBER,
  roleID NUMBER,
  workInCinema NUMBER 
);

INSERT INTO Employees VALUES (1, 'Costel Vancica',2000,1,1);
INSERT INTO Employees VALUES (2, 'Petrica Robert',2100,4,2);
INSERT INTO Employees VALUES (3, 'Daniel Robert',2500,2,1);
INSERT INTO Employees VALUES (4, 'Bogdan Toader',1800,3,3);
SELECT * FROM EMPLOYEES;

ALTER TABLE EMPLOYEES ADD CONSTRAINT fk_workIn 
FOREIGN KEY (workInCinema) REFERENCES CINEMAS(CinemaID);
--
CREATE TABLE ROLES(
  RoleID NUMBER PRIMARY KEY NOT NULL,
  description VARCHAR2(30)
);

INSERT INTO ROLES VALUES (1,'Casier');
INSERT INTO ROLES VALUES (2,'Manager');
INSERT INTO ROLES VALUES (3,'Validator Bilete');
INSERT INTO ROLES VALUES (4,'Gardian');

SELECT * FROM ROLES;

ALTER TABLE employees ADD CONSTRAINT fk_role
FOREIGN KEY (roleID) REFERENCES ROLES(roleID);

--
CREATE TABLE Rooms(
  RoomID NUMBER PRIMARY KEY NOT NULL,
  CinemaID NUMBER,
  RoomNumber NUMBER, 
  seats NUMBER
);

ALTER TABLE Rooms ADD CONSTRAINT fk_cinema 
FOREIGN KEY (CinemaID) REFERENCES CINEMAS(CINEMAID);

INSERT INTO Rooms VALUES (1,2,13,45);
INSERT INTO Rooms VALUES (2,1,22,20);
INSERT INTO Rooms VALUES (3,2,12,50);
INSERT INTO Rooms VALUES (4,3,20,25);
INSERT INTO Rooms VALUES (5,1,10,30);

SELECT * FROM Rooms;
--
CREATE TABLE Schedule(
  ScheduleID NUMBER PRIMARY KEY not null,
  MovieID NUMBER,
  RoomID NUMBER,
  startTime TIMESTAMP
);

ALTER TABLE SCHEDULE ADD CONSTRAINT fk_room FOREIGN KEY (RoomID) REFERENCES ROOMS(ROomID);
ALTER TABLE SCHEDULE ADD CONSTRAINT fk_movie FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

INSERT INTO Schedule VALUES (1,1,3,TIMESTAMP '2021-01-12 14:00:00 +02:00');
INSERT INTO Schedule VALUES (2,1,4,TIMESTAMP '2021-01-12 16:00:00 +02:00');
INSERT INTO Schedule VALUES (3,2,1,TIMESTAMP '2021-01-13 14:00:00 +02:00');
INSERT INTO Schedule VALUES (4,2,2,TIMESTAMP '2021-01-13 15:00:00 +02:00');
INSERT INTO Schedule VALUES (5,3,5,TIMESTAMP '2021-01-14 17:00:00 +02:00');

SELECT * FROM SCHEDULE;

--
CREATE TABLE Tickets(
  TicketID NUMBER PRIMARY KEY NOT NULL,
  ScheduleID NUMBER,
  PriceID NUMBER,
  SeatNumber NUMBER 
);

ALTER TABLE Tickets ADD CONSTRAINT fk_schedule
FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID);

INSERT INTO TICKETS VALUES (1,1,1,3);
INSERT INTO TICKETS VALUES (2,1,2,4);
INSERT INTO TICKETS VALUES (3,1,3,5);
INSERT INTO TICKETS VALUES (4,3,4,1);
INSERT INTO TICKETS VALUES (5,3,4,2);
INSERT INTO TICKETS VALUES (6,3,2,3);
INSERT INTO TICKETS VALUES (7,4,3,3);
INSERT INTO TICKETS VALUES (8,4,1,4);
INSERT INTO TICKETS VALUES (9,4,2,5);
INSERT INTO TICKETS VALUES (10,5,3,6);

SELECT * FROM TICKETS;
--
CREATE TABLE PRICES(
  PriceID NUMBER PRIMARY KEY NOT NULL,
  CategoryDescription VARCHAR2(30),
  Price NUMBER
);
INSERT INTO PRICES VALUES (1,'Student',12);
INSERT INTO PRICES VALUES (2,'Adult',20);
INSERT INTO PRICES VALUES (3,'Pensionar',15);
INSERT INTO PRICES VALUES (4,'Copil',0);

SELECT * FROM PRICES;

ALTER TABLE Tickets ADD CONSTRAINT fk_price 
FOREIGN KEY (PriceID) REFERENCES Prices(PriceID);


SELECT * FROM TICKETS;
select * from Schedules;
SELECT * FROM movies;
select * from Employees;

--EXERCITII
-- 6 Sa se defineasca o procedure astfel incat pentru fiecare regizor, 
-- sa se afiseze genurile de film pe care le-a regizat

--introduc un regizor nou care nu are filme in tabela cinematografe
insert into Directors values (6,'Steven Spielberg');


Create or replace procedure ex6 IS
  TYPE tablou_regizori IS TABLE OF DIRECTORS%ROWTYPE;
  regizori tablou_regizori;
  
  TYPE filmGen IS RECORD(directorID movies.directorID%TYPE,descriere genres.name%TYPE);
  TYPE tablou_film_gen IS TABLE OF filmGen;
  filme_gen tablou_film_gen;
    
  amgasitFilm NUMBER :=0;
BEGIN
  SELECT * BULK COLLECT INTO regizori FROM Directors;
  
  SELECT m.directorID, g.name BULK COLLECT INTO filme_gen 
  FROM Movies m JOIN GENRES g USING(GenreID) GROUP BY m.directorID,g.name;
  
  FOR i in regizori.FIRST..regizori.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(regizori(i).name|| ' regizeaza filme de genul: ');
    FOR j in filme_gen.FIRST..filme_gen.LAST LOOP
      if filme_gen(j).directorID = regizori(i).directorID THEN
        amGasitFilm :=1;
        DBMS_OUTPUT.PUT_LINE(filme_gen(j).descriere);
      END IF;
    END LOOP;
    IF amGasitFilm =0 THEN 
        DBMS_OUTPUT.PUT_LINE('Nu am gasit filme de acest regizor');
      END IF;
      amGasitFilm:=0;
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
  END LOOP;
END ex6;
/

BEGIN
 ex6();
END;
/
SELECT * FROM MOVIES;
SELECT * FROM GENRES;
  
--7 Sa se afiseze fiecare film programat in fiecare Cinematograf

INSERT INTO cinemas VALUES(4,'Timpuri Noi',1);

Create or replace procedure ex7 IS
    cursor cinemasCursor IS
      select CINEMAID, name
        from cinemas;
    cursor MovieCursor (idCinema NUMBER) IS
      SELECT m.title
      FROM Rooms r JOIN Schedule s USING(RoomID) JOIN Movies m USING(MOVIEID)
      where r.cinemaID = idCinema AND s.startTime > SYSDATE
      GROUP BY m.title;

    TYPE cinematograf IS RECORD(cinemaID cinemas.CINEMAID%TYPE, cinemaName CINEMAS.name%TYPE);
    v_cinema cinematograf;
    areProgram NUMBER :=1;
begin
  open cinemasCursor;
  LOOP 
    FETCH cinemasCursor INTO v_cinema;
    EXIT WHEN cinemasCursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('In cinematograful '|| v_cinema.cinemaName || ' ruleaza filmele ');
    FOR i in MovieCursor(v_cinema.cinemaID) LOOP
      DBMS_OUTPUT.PUT_LINE(i.title);
      areProgram :=1;
    END LOOP;
    
    IF areProgram = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Acest cinema nu are nimic in program');
    END IF;
    arePRogram :=0;
    DBMS_OUTPUT.PUT_LINE('________________');
  END LOOP;
end ex7;
/

BEGIN
 ex7();
END;
/

--8 Creeati o functie care intoarce incasarile unui anumit film dat ca parametru
SELECT * FROm MOVIES;
CREATE OR REPLACE FUNCTION ex8(numeFilm Movies.title%TYPE)
  RETURN Prices.Price%TYPE IS
  idFilm Movies.MovieID%TYPE;

  incasari Prices.Price%TYPE;
BEGIN
    SELECT MovieID INTO idFilm FROM MOVIES WHERE UPPER(title) = UPPER(numeFilm);

    SELECT SUM(pr.price) INTO incasari
    FROM Schedule p JOIN TICKETS t USING(ScheduleID)
    JOIN PRICES pr USING (PriceID) WHERE p.MovieID = idFilm;

    RETURN incasari;

  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Sunt mai multe filme cu numele specificat');
       RAISE_APPLICATION_ERROR(-20000,'Sunt mai multe filme cu numele specificat');
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nu exista film cu numele specificat');
       RAISE_APPLICATION_ERROR(-20000,'Nu exista film cu numele specificat');
        
END;
/


BEGIN
    DBMS_OUTPUT.PUT_LINE('Filmul Tenet a incasat : '||ex8('Tenet')|| 'lei');
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Filmul Avatar a incasat : '||ex8('avatar')|| 'lei');
END;
/


--9 sa se afle cate bilete a vandut fiecare regizor prin filmele lui
--sa se scrie o procedura care prentru fiecare actor arata cate bilete au vandut toate filmele in care a jucat
Create or replace procedure ex9 IS
  TYPE actortickets IS RECORD(numeActor Actors.name%TYPE,numarBilete NUMBER);
  TYPE tablou_actorTickets IS Table OF actorTickets;
  v_actorTickets tablou_actorTickets;
BEGIN
  SELECT a.name, COUNT(t.ticketID)
  BULK COLLECT INTO v_actorTickets
  FROM actors a LEFT JOIN ACTOR_MOVIE am USING(ActorID) LEFT JOIN MOvies m USING (MovieID)
  LEFT JOIN Schedule s USING (movieID) LEFT JOIN Tickets t  USING(ScheduleID) GROUP BY a.name;

  FOR i in v_actorTickets.FIRST..v_actorTickets.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Actorul '||v_actorTickets(i).numeActor || ' a vandut '|| v_actorTickets(i).numarBilete || ' bilete');
  END LOOP;
END;
/
BEGIN
    ex9();
END;
/

--ex 10 Sa se scrie un declansator la nivel de comanda care restrictioneaza 
-- accesul la tabela Cinematografe doar unilizatorului 'SYSTEM'
CREATE OR REPLACE TRIGGER trig_ex10
    BEFORE INSERT OR UPDATE OR DELETE ON CINEMAS
BEGIN
    IF UPPER(USER) <> UPPER('SYSTEM') THEN
         raise_application_error(-20000, ' Nu aveti dreptul de a sterge entitati');
    END IF;
END;
/

--daca incercam de pe system
UPDATE CINEMAS
SET name='Timpuri Vechi'
WHERE cinemaid=4;
SELECT * FROM CINEMAS;

SELECT * FROM CINEMAS;

create user testsgbd identified by testsgbd;
grant connect, resource to testsgbd;
grant select on cinemas to testsgbd;
grant update on cinemas to testsgbd;


SELECT * FROm Schedule;
--11 Sa se defineasca un trigger la nivel de linie care nu lasa programare filmelor in intervalul orar 23:00-11:00
CREATE OR REPLACE TRIGGER trig_ex11
 BEFORE UPDATE OR INSERT ON Schedule
 FOR EACH ROW
BEGIN
  IF UPDATING THEN
    if to_number(EXTRACT(HOUR FROM :new.starttime)) >= 23 OR to_number(EXTRACT(HOUR FROM :new.starttime)) < 11 THEN
      RAISE_APPLICATION_ERROR(-20001,'TImpul de inceput este inadecvat');
    END IF;
  ELSIF INSERTING THEN
     if to_number(EXTRACT(HOUR FROM :new.starttime)) >= 23 OR to_number(EXTRACT(HOUR FROM :new.starttime)) < 11 THEN
        RAISE_APPLICATION_ERROR(-20001,'Timpul de inceput este inadecvat');
      END IF;
  END IF;
END;
/

SELECT * FROM Schedule;
UPDATE Schedule
SET startTime = TIMESTAMP '2021-12-12 23:30:00 '
WHERE scheduleID=1;

SELECT * FROM Schedule;

UPDATE Schedule
SET startTime = TIMESTAMP '2021-12-12 12:30:00 '
WHERE scheduleID=1;

SELECT * FROM Schedule;

--12 Creati un trigger care introduce erorile din baza de date intr-o tabela
CREATE TABLE errorsOnDb(
    userCurent VARCHAR2(40),
    numeDb VARCHAR2(40),
    erroare VARCHAR2(3000),
    dataErroare TIMESTAMP(3)
);

CREATE OR REPLACE TRIGGER trig_ex12
    AFTER SERVERERROR ON SCHEMA
BEGIN
    INSERT INTO errorsOnDb
    VALUES(SYS.LOGIN_USER,SYS.DATABASE_NAME,DBMS_UTILITY.FORMAT_ERROR_STACK,SYSTIMESTAMP);
END;
/

DELETE FROM errorsOnDb;
SELECT * FROM Schedule;
UPDATE Schedule
SET startTime = TIMESTAMP '2021-12-12 23:30:00 '
WHERE scheduleID=1;
SELECT * fROM ErrorsOnDb;

SELECT * FROM antartica;

--13
CREATE OR REPLACE PACKAGE pachet_ex13 AS

  PROCEDURE ex6;
  PROCEDURE ex7;
  FUNCTION ex8(numeFilm Movies.title%TYPE)
  RETURN Prices.Price%TYPE;
  PROCEDURE ex9;

END pachet_ex13;
/ 

CREATE OR REPLACE PACKAGE BODY pachet_ex13 AS
  PROCEDURE ex6 IS
  TYPE tablou_regizori IS TABLE OF DIRECTORS%ROWTYPE;
  regizori tablou_regizori;
  
  TYPE filmGen IS RECORD(directorID movies.directorID%TYPE,descriere genres.name%TYPE);
  TYPE tablou_film_gen IS TABLE OF filmGen;
  filme_gen tablou_film_gen;
    
  amgasitFilm NUMBER :=0;
  BEGIN
    SELECT * BULK COLLECT INTO regizori FROM Directors;
    
    SELECT m.directorID, g.name BULK COLLECT INTO filme_gen 
    FROM Movies m JOIN GENRES g USING(GenreID) GROUP BY m.directorID,g.name;
    
    FOR i in regizori.FIRST..regizori.LAST LOOP
      DBMS_OUTPUT.PUT_LINE(regizori(i).name|| ' regizeaza filme de genul: ');
      FOR j in filme_gen.FIRST..filme_gen.LAST LOOP
        if filme_gen(j).directorID = regizori(i).directorID THEN
          amGasitFilm :=1;
          DBMS_OUTPUT.PUT_LINE(filme_gen(j).descriere);
        END IF;
      END LOOP;
      IF amGasitFilm =0 THEN 
          DBMS_OUTPUT.PUT_LINE('Nu am gasit filme de acest regizor');
        END IF;
        amGasitFilm:=0;
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    END LOOP;
  END ex6;

  procedure ex7 IS
    cursor cinemasCursor IS
      select CINEMAID, name
        from cinemas;
    cursor MovieCursor (idCinema NUMBER) IS
      SELECT m.title
      FROM Rooms r JOIN Schedule s USING(RoomID) JOIN Movies m USING(MOVIEID)
      where r.cinemaID = idCinema AND s.startTime > SYSDATE
      GROUP BY m.title;

    TYPE cinematograf IS RECORD(cinemaID cinemas.CINEMAID%TYPE, cinemaName CINEMAS.name%TYPE);
    v_cinema cinematograf;
    areProgram NUMBER :=1;
    begin
      open cinemasCursor;
      LOOP 
        FETCH cinemasCursor INTO v_cinema;
        EXIT WHEN cinemasCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('In cinematograful '|| v_cinema.cinemaName || ' ruleaza filmele ');
        FOR i in MovieCursor(v_cinema.cinemaID) LOOP
          DBMS_OUTPUT.PUT_LINE(i.title);
          areProgram :=1;
        END LOOP;
        
        IF areProgram = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Acest cinema nu are nimic in program');
        END IF;
        arePRogram :=0;
        DBMS_OUTPUT.PUT_LINE('________________');
      END LOOP;
    end ex7;

  FUNCTION ex8(numeFilm Movies.title%TYPE)
    RETURN Prices.Price%TYPE IS
    idFilm Movies.MovieID%TYPE;

    incasari Prices.Price%TYPE;
  BEGIN
      SELECT MovieID INTO idFilm FROM MOVIES WHERE UPPER(title) = UPPER(numeFilm);

      SELECT SUM(pr.price) INTO incasari
      FROM Schedule p JOIN TICKETS t USING(ScheduleID)
      JOIN PRICES pr USING (PriceID) WHERE p.MovieID = idFilm;

      RETURN incasari;

    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
          DBMS_OUTPUT.PUT_LINE('Sunt mai multe filme cu numele specificat');
        RAISE_APPLICATION_ERROR(-20000,'Sunt mai multe filme cu numele specificat');
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista film cu numele specificat');
        RAISE_APPLICATION_ERROR(-20000,'Nu exista film cu numele specificat');
          
  END ex8;

  procedure ex9 IS
  TYPE actortickets IS RECORD(numeActor Actors.name%TYPE,numarBilete NUMBER);
  TYPE tablou_actorTickets IS Table OF actorTickets;
  v_actorTickets tablou_actorTickets;
  BEGIN
    SELECT a.name, COUNT(t.ticketID)
    BULK COLLECT INTO v_actorTickets
    FROM actors a LEFT JOIN ACTOR_MOVIE am USING(ActorID) LEFT JOIN MOvies m USING (MovieID)
    LEFT JOIN Schedule s USING (movieID) LEFT JOIN Tickets t  USING(ScheduleID) GROUP BY a.name;

    FOR i in v_actorTickets.FIRST..v_actorTickets.LAST LOOP
      DBMS_OUTPUT.PUT_LINE('Actorul '||v_actorTickets(i).numeActor || ' a vandut '|| v_actorTickets(i).numarBilete || ' bilete');
    END LOOP;
  END ex9;



END pachet_ex13;
/
BEGIN
   pachet_ex13.ex6;
END;
/
BEGIN
   pachet_ex13.ex7;
END;
/
BEGIN
   DBMS_OUTPUT.PUT_LINE('Filmul Tenet a incasat '||pachet_ex13.ex8('TENET')||' Lei');
END;
/
BEGIN
   pachet_ex13.ex9;
END;
/

--14 Am facut un pachet care permite cumpararea biletelor la filme
select * from movies;
--fac o secventa pentu introducerea in tabela
CREATE SEQUENCE tickets_seq START WITH 11;

CREATE OR REPLACE PACKAGE pachet_ex14 AS

  FUNCTION gasesteCinema(numeCinema cinemas.name%TYPE)
    return cinemas.CINEMAID%TYPE;

  FUNCTION gasesteFilm(numeFilm movies.title%TYPE)
    return movies.movieID%TYPE;

  FUNCTION gasesteProgram(idCinema cinemas.CinemaID%TYPE, idFilm Movies.MovieID%TYPE)
    RETURN Schedule.ScheduleID%TYPE;

  FUNCTION gasesteScauGol(idProgram Schedule.ScheduleID%TYPE)
    RETURN Tickets.SeatNUmber%TYPE;

  FUNCTION gasesteCateg(categorieDePret Prices.CategoryDescription%TYPE)
    RETURN Prices.PriceID%TYPE;

  PROCEDURE cumparaBilet(film movies.Title%TYPE,cinema cinemas.name%TYPE,categorieDePret Prices.CategoryDescription%TYPE );
END pachet_ex14;
/
CREATE OR REPLACE package body pachet_ex14 AS
  FUNCTION gasesteCinema(numeCinema cinemas.name%TYPE)
    RETURN cinemas.CINEMAID%TYPE IS
    idCinema cinemas.CinemaID%TYPE;
  BEGIN
    SELECT cinemaID INTO idCinema
    FROM cinemas
    where UPPER(name) = UPPER(numeCinema);

    return idCinema;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista cinematograf cu numele dat');
        RAISE_APPLICATION_ERROR(-20000,'Nu exista cinematograf cu numele dat');
  END gasesteCinema;

  FUNCTION gasesteFilm(numeFilm movies.title%TYPE)
    return movies.movieID%TYPE IS
    idFilm movies.MovieID%TYPE;
  BEGIN
    SELECT movieID INTO idFilm
    FROM movies
    where UPPER(title) = UPPER(numeFilm);

    return idFilm;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista film cu numele dat');
        RAISE_APPLICATION_ERROR(-20000,'Nu exista film cu numele dat');
  END gasesteFilm;

  FUNCTION gasesteProgram(idCinema cinemas.CinemaID%TYPE, idFilm Movies.MovieID%TYPE)
    RETURN Schedule.ScheduleID%TYPE IS
    idProgram Schedule.ScheduleID%TYPE;
  BEGIN
    SELECT s.ScheduleID INTO idProgram FROM Schedule s JOIN ROOMS r USING (RoomID)
    WHERE cinemaID = idCinema AND MovieID = idFilm and s.startTime>sysdate AND ROWNUM<=1;

    return idProgram;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu este inca programat acest film in aces cinema');
        RAISE_APPLICATION_ERROR(-20000,'Nu este inca programat acest film in aces cinema');
  END gasesteProgram;

  FUNCTION gasesteScauGol(idProgram Schedule.ScheduleID%TYPE)
    RETURN Tickets.SeatNumber%TYPE IS
    nrMax rooms.seats%TYPE;
    cautScaun Tickets.Seatnumber%TYPE;   
    salaPlina EXCEPTION;
  BEGIN
    SELECT seats INTO nrMax FROM Schedule JOIN rooms using (Roomid)
    where scheduleID = idProgram;

    FOR i in 1..nrMax LOOP
      SELECT COUNT(*) INTO cautScaun
      FROM TICKETS WHERE SeatNUmber = i AND scheduleID = idProgram;

      if cautScaun = 0 THEN
        return i;
      END IF;
    END LOOP;
    RAISE salaPlina;
    EXCEPTION
    WHEN salaPlina THEN
        DBMS_OUTPUT.PUT_LINE('Sala este plina');
        RAISE_APPLICATION_ERROR(-20000,'Sala este plina');
  END gasesteScauGol;

  FUNCTION gasesteCateg(categorieDePret Prices.CategoryDescription%TYPE)
    RETURN Prices.PriceID%TYPE AS
    idCateg Prices.PriceID%TYPE;
  BEGIN
    SELECT PriceID INTO idCateg
    FROM PRICES WHERE UPPER(CategoryDescription) = UPPER(categorieDePret);

    return idCateg;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista aceasta categorie de pret');
        RAISE_APPLICATION_ERROR(-20000,'Nu exista aceasta categorie de pret');
  END gasesteCateg;


  PROCEDURE cumparaBilet(film movies.Title%TYPE,cinema cinemas.name%TYPE, categorieDePret Prices.CategoryDescription%TYPE) IS
    idFilm movies.movieID%TYPE;
    idCinema cinemas.cinemaID%TYPE;
    idProgram Schedule.ScheduleID%TYPE;
    numarScaun Tickets.SeatNumber%type;
    idCategPret Prices.PriceID%TYPE;
  BEGIN
    idCinema := gasesteCinema(cinema);
    idFilm := gasesteFilm(film);
    idProgram := gasesteProgram(idCinema,idFilm);
    numarScaun :=gasesteScauGol(idProgram);
    idCategPret := gasesteCateg(categorieDePret);

    INSERT INTO TICKETS VALUES (tickets_seq.NEXTVAL,idProgram,idCategPret,numarScaun);
  END cumparaBilet;
  
END pachet_ex14;
/

SELECT * FROM TICKETS;
BEGIN
   pachet_ex14.cumparaBilet('Soul','Lumea Noua','Student');
END;
/

BEGIN
   pachet_ex14.cumparaBilet('Collective','Lumea Noua','Student');
END;
/

SELECT * FROM TICKETS;

