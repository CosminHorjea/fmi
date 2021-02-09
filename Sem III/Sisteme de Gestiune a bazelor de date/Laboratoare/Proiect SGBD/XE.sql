CREATE TABLE Actors (--
  ActorID           NUMBER(10)    NOT NULL,
  Name  VARCHAR2(50)  NOT NULL,
  BirthDay DATE NOT NULL);

ALTER TABLE actors ADD (
  CONSTRAINT actorsPK PRIMARY KEY (ActorID));

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

CREATE TABLE GENRES (--
  genreID NUMBER(4) NOT NULL PRIMARY KEY,
  name VARCHAR2(30)
)

insert into GENRES values (1,'Horror');
insert into GENRES values (2,'Action');
insert into GENRES values (3,'Drama');
insert into GENRES values (4,'Animation');
insert into GENRES values (5,'Western');
insert into GENRES values (6,'Documentary');

CREATE TABLE Directors(--
  DirectorID NUMBER(10) NOT NULL PRIMARY KEY,
  name VARCHAR2(30)
);
SELECT * FROM Directors;
insert into Directors values (1,'Pete Dockter');
insert into Directors values (2,'David O. Russel');
insert into Directors values (3,'Cristopher Nolan');
insert into Directors values (4,'Alexandru Nanau');
insert into Directors values (5,'Bryan Singer');

CREATE TABLE Movies(
  MovieID NUMBER(10) NOT NULL PRIMARY KEY,
  title VARCHAR2(30),
  duration NUMBER(3),--minutes
  released_date DATE,
  genreID NUMBER(5) REFERENCES GENRES,
  DirectorID NUMBER(5) REFERENCES Directors
)

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
SELECT * FROm MOVIES;

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

Create Table Actor_movie(--
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

CREATE TABLE CINEMAS(--
  CinemaID NUMBER PRIMARY KEY NOT NULL,
  Name VARCHAR2(30),
  AdressID NUMBER,
  ManagerID NUMBER
);
insert into CINEMAS values (1,'AFI Palace',1,3);
insert into CINEMAS values (2,'Lumea Noua',2,1);
insert into CINEMAS values (3,'Orizont',3,2);

CREATE TABLE ADRESSES(--
  AdressID NUMBER PRIMARY KEY NOT NULL,
  City VARcHAR2(30),
  Street VARCHAR(30)
);

insert into ADRESSES values (1,'Bucuresti','Militari');
insert into ADRESSES values (2,'Timisoara','Centrala');
insert into ADRESSES values (3,'Brasov','Mihai Viteazul');



CREATE TABLE Employees(--
  EmployeeID NUMBER PRIMARY KEY NOT NULL,
  Name VARCHAR2(30),
  salary NUMBER,
  roleID NUMBER, -- referinta la tabel de roluri
  workInCinema NUMBER --referinta la cinemas
);

INSERT INTO Employees VALUES (1, 'Costel Vancica',2000,1,1);
INSERT INTO Employees VALUES (2, 'Petrica Robert',2100,4,2);
INSERT INTO Employees VALUES (3, 'Daniel Robert',2500,2,1);
INSERT INTO Employees VALUES (4, 'Bogdan Toader',1800,3,3);

-- ALTER TABLE Employees
-- RENAME COLUMN role TO ROleID;
ALTER TABLE EMPLOYEES ADD CONSTRAINT fk_workIn FOREIGN KEY (workInCinema) REFERENCES CINEMAS(CinemaID);

CREATE TABLE ROLES(--
  RoleID NUMBER PRIMARY KEY NOT NULL,
  Denumire VARCHAR2(30)
);

ALTER TABLE employees ADD CONSTRAINT fk_role FOREIGN KEY (roleID) REFERENCES ROLES(roleID);
INSERT INTO ROLES VALUES (1,'Casier');
INSERT INTO ROLES VALUES (2,'Manager');
INSERT INTO ROLES VALUES (3,'Validator Bilete');
INSERT INTO ROLES VALUES (4,'Gardian');

CREATE TABLE Rooms(--
  RoomID NUMBER PRIMARY KEY NOT NULL,
  CinemaID NUMBER,
  RoomNumber NUMBER, 
  seats NUMBER
);

ALTER TABLE Rooms ADD CONSTRAINT fk_cinema FOREIGN KEY (CinemaID) REFERENCES CINEMAS(CINEMAID);

INSERT INTO Rooms VALUES (1,2,13,45);
INSERT INTO Rooms VALUES (2,1,22,20);
INSERT INTO Rooms VALUES (3,2,12,50);
INSERT INTO Rooms VALUES (4,3,20,25);
INSERT INTO Rooms VALUES (5,1,10,30);

CREATE TABLE Schedule(--
  ScheduleID NUMBER PRIMARY KEY not null,
  MovieID NUMBER, --referinta la Movie
  RoomID NUMBER,
  startTime TIMESTAMP
);

ALTER TABLE SCHEDULE ADD CONSTRAINT fk_room FOREIGN KEY (RoomID) REFERENCES ROOMS(ROomID);
ALTER TABLE SCHEDULE ADD CONSTRAINT fk_movie FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

INSERT INTO Schedule VALUES (1,1,3,TIMESTAMP '2021-01-12 2:00:00 +02:00');
INSERT INTO Schedule VALUES (2,1,4,TIMESTAMP '2021-01-12 4:00:00 +02:00');
INSERT INTO Schedule VALUES (3,2,1,TIMESTAMP '2021-01-13 2:00:00 +02:00');
INSERT INTO Schedule VALUES (4,2,2,TIMESTAMP '2021-01-13 3:00:00 +02:00');
INSERT INTO Schedule VALUES (5,3,5,TIMESTAMP '2021-01-14 5:00:00 +02:00');

CREATE TABLE Tickets(--
  TicketID NUMBER PRIMARY KEY NOT NULL,
  ScheduleID NUMBER,--referinta Schedule
  PriceID NUMBER,
  SeatNumber NUMBER --o sa verific daca deja este rezervat locul
);
DROP TABLE TICKETS;

ALTER TABLE Tickets ADD CONSTRAINT fk_schedule FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID);
ALTER TABLE Tickets ADD CONSTRAINT fk_price FOREIGN KEY (PriceID) REFERENCES Prices(PriceID);

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

CREATE TABLE PRICES(--
  PriceID NUMBER PRIMARY KEY NOT NULL,
  CategoryDescription VARCHAR2(30),
  Price NUMBER
);
INSERT INTO PRICES VALUES (1,'Student',12);
INSERT INTO PRICES VALUES (2,'Adult',20);
INSERT INTO PRICES VALUES (3,'Pensionar',15);
INSERT INTO PRICES VALUES (4,'Copil',0);

SELECT * FROM TICKETS;
select * from Schedules;
SELECT * FROM movies;
select *
  from Employees;

--EXERCITII
-- 6 PEntru fiecare regizor, sa s e afiseze genurile de film pe care le-a regizat
SELECT d.name, g.name
FROM Directors d, GENRES g, Movies m
WHERE d.DirectorID = m.DirectorID AND m.genreID = g.genreID;

DECLARE
  TYPE tablou_regizori IS TABLE OF DIRECTORS%ROWTYPE;
  regizori tablou_regizori;
  
  TYPE filmGen IS RECORD(directorID movies.directorID%TYPE,descriere genres.name%TYPE);
  TYPE tablou_film_gen IS TABLE OF filmGen;
  filme_gen tablou_film_gen;
  
begin
  SELECT * BULK COLLECT INTO regizori FROM Directors;
  
  SELECT m.directorID, g.name BULK COLLECT INTO filme_gen 
  FROM Movies m JOIN GENRES g USING(GenreID) GROUP BY m.directorID,g.name;
  
  FOR i in regizori.FIRST..regizori.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(regizori(i).name);
  END LOOP;
  
  FOR i in regizori.FIRST..regizori.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(regizori(i).name|| ' regizeaza filme de genul: ');
    FOR j in filme_gen.FIRST..filme_gen.LAST LOOP
      if filme_gen(j).directorID = regizori(i).directorID THEN
        DBMS_OUTPUT.PUT_LINE(filme_gen(j).descriere);
      END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');

  END LOOP;
  
end;
/

SELECT * FROM MOVIES;
SELECT * FROM GENRES;

SELECT m.title, m.directorID, g.name FROM Movies m JOIN GENRES g USING(GenreID);

SELECT m.directorID, g.name
  FROM Movies m JOIN GENRES g USING(GenreID) GROUP BY m.directorID,g.name;
  
--7 Sa se afiseze fiecare film programat in fiecare CInematograf
DECLARE
cursor cinemasCursor IS
  select CINEMAID, CinemaName
    from cinemas
cursor MovieCursor (CinemaID NUMBER) IS
  SELECT 
  FROM Rooms r JOIN Schedule USING(RoomID) JOIN Movies USING()
begin
  
end;



--some refs
SELECT CAST( TIMESTAMP '2000-01-01 12:00:00' AS DATE ) FROM DUAL;

SELECT TO_DATE( '2000-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS' ) FROM DUAL;

SELECT TO_CHAR(SYSDATE + (5/24), 'YYYY-MM-DD HH24:MI:SS') AS five_hours_from_now FROM dual;

