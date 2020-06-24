--1
CREATE TABLE angajati_cho(
	cod_ang number(4) constraint p_key_cho primary key,
	nume varchar2(20) constraint ang_nume_cho not null,
	prenume varchar2(20),
	email char(15) unique,
	data_ang date default sysdate,
	job varchar2(10),
	cod_sef number(4),
	salariu number(8, 2) constraint ang_sal_cho not null,
	cod_dep number(2),
	--or , declarare la nivel de tabel
	--constraint p_key_cho primary key(cod_ang)
)
insert into angajati_cho(
		cod_ang,
		nume,
		prenume,
		data_ang,
		job,
		salariu,
		cod_dep
	)
values(
		100,
		'nume1',
		'prenume1',
		null,
		'Director',
		20000,
		10
	);
insert into angajati_cho
values(
		101,
		'nume2',
		'prenume2',
		'nume2',
		to_date('02-02-2004', 'dd-mm-yyyy'),
		'Inginer',
		100,
		10000,
		10
	);
insert into angajati_cho
values(
		102,
		'nume3',
		'prenume3',
		'nume3',
		to_date('05-06-2000', 'dd-mm-yyyy'),
		'Analist',
		101,
		5000,
		20
	);
insert into angajati_cho(
		cod_ang,
		nume,
		prenume,
		data_ang,
		job,
		cod_sef,
		salariu,
		cod_dep
	)
values(
		103,
		'nume4',
		'prenume4',
		null,
		'Inginer',
		100,
		9000,
		20
	);
insert into angajati_cho
values(
		104,
		'nume5',
		'prenume5',
		'nume5',
		null,
		'Analist',
		101,
		3000,
		30
	);
select *
from angajati_cho;
commit;
--3
ALTER TABLE angajati_cho
ADD(comision NUMBER(4, 2));
--4
ALTER TABLE angajati_cho
MODIFY(comision, NUMBER(6, 2));
--5
ALTER TABLE angajati_cho
MODIFY(salariu number(8, 2) default 10);
--6
ALTER TABLE angajati_cho
MODIFY(comision number(10, 2), salariu number(10, 2));
--7
UPDATE angajati_cho
SET comision = 0.1
WHERE upper(job) like 'A%';
--8
ALTER TABLE angajati_cho
MODIFY (email varchar2(15)) --9
ALTER TABLE angajati_cho
ADD(nr_telefon varchar(10) default '112');
--10
ALTER TABLE angajati_cho DROP COLUMN nr_telefon;
--11
CREATE TABLE departamente_cho(
	cod_dep number(2),
	nume varchar2(15) constraint nume_dept_cho not null,
	cod_director number(4)
) --12
INSERT INTO departamente_cho
VALUES(10, 'Administrativ', 100);
INSERT INTO departamente_cho
VALUES(20, 'Proiectare', 101);
INSERT INTO departamente_cho
VALUES(30, 'Programare', NULL);
commit;
--13
ALTER TABLE departamente_cho
ADD CONSTRAINT pk_dep_cho PRIMARY KEY(cod_dep);
--14
ALTER TABLE angajati_cho
ADD CONSTRAINT fk_ang_dep_cho FOREIGN KEY(cod_dep) REFERENCES departamenre_cho(cod_dep);
--sau
CREATE TABLE angajati_cho (
	cod_ang number(4) constraint pk_ang_cho primary key,
	nume varchar2(20) constraint nume_ang_cho not null,
	prenume varchar2(20),
	email char(15) unique,
	data_ang date default sysdate,
	job varchar2(10),
	cod_sef number(4) constraint sef_ang_cho references angajati_cho(cod_ang),
	salariu number(8, 2),
	cod_dep number(2) constraint fk_ang_dep_cho references departamente_cho(cod_dep),
	comision number(2, 2),
	check(cod_dep > 0),
	constraint verif_sal_cho check(salariu > comision * 100),
	constraint num_pren_cho unique(nume, prenume)
);
--15
CREATE TABLE ANGAJATI_cho (
	cod_ang number(4),
	nume varchar2(20) constraint nume_cho not null,
	prenume varchar2(20),
	email char(15),
	data_ang date default sysdate,
	job varchar2(10),
	cod_sef number(4),
	salariu number(8, 2) constraint salariu_cho not null,
	cod_dep number(2),
	comision number(2, 2),
	constraint nume_prenume_unique_cho unique(nume, prenume),
	constraint verifica_sal_cho check(salariu > 100 * comision),
	constraint pk_angajati_cho primary key(cod_ang),
	unique(email),
	constraint sef_cho foreign key(cod_sef) references angajati_cho(cod_ang),
	constraint fk_dep_cho foreign key(cod_dep) references departamente_cho (cod_dep),
	check(cod_dep > 0)
);
--16
INSERT INTO angajati_cho
VALUES(
		100,
		'nume1',
		'prenume1',
		'email1',
		sysdate,
		'Director ',
		null,
		20000,
		10,
		0.1
	);
INSERT INTO angajati_cho
VALUES(
		101,
		'nume2',
		'prenume2',
		'email2',
		to_date('02-02-2004', 'dd-mm- yyyy'),
		'Inginer',
		100,
		10000,
		10,
		0.2
	);
INSERT INTO angajati_cho
VALUES(
		102,
		'nume3',
		'prenume3',
		'email3',
		to_date('05-06-2000', 'dd-mm-yyyy'),
		'Analist',
		101,
		5000,
		20,
		0.1
	);
INSERT INTO angajati_cho
VALUES(
		103,
		'nume4',
		'prenume4',
		'email4',
		sysdate,
		'Inginer ',
		100,
		9000,
		20,
		0.1
	);
INSERT INTO angajati_cho
VALUES(
		104,
		'nume5',
		'prenume5',
		'email5',
		sysdate,
		'Analist',
		101,
		3000,
		30,
		0.1
	);
select *
from angajati_cho;
commit;
--17
SELECT *
FROM tab;
SELECT angajati_cho
FROM user_table;
--18
SELECT constraint_name,
	constraint_type,
	table_name
FROM user_constraints
WHERE lower(table_name) IN ('angajati_cho');
--b
SELECT table_name,
	constraint_name,
	column_name
FROM user_cons_columns
WHERE LOWER(table_name) IN (‘ angajati_cho ’, ‘ departamente_cho ’);
--19
ALTER angajati_cho
MODIFY (email varchar(15) not null);
--20
-- nu am incercat dar nu cred ca exita dep cu codul 50, deci nu are corespondent cheia externa
--21
INSERT INTO departamente_cho
VALUES (60, 'analiza', null);
--22
DELETE FROM departamente_cho
WHERE cod_dep = 20;
-- ORA-02292: integrity constraint (GRUPA43.FK_ANG_DEP_cho) violated - child record found
--23
DELETE FROM departamente_cho
WHERE cod_dep = 60;
SELECT *
FROM departamente_cho;
--24
ALTER TABLE angajati_cho DROP CONSTRAINT FK_ANG_DEP_CHO;
ALTER TABLE angajati_cho
ADD CONSTRAINT fk_ang_dep_cho FOREIGN KEY(cod_dep) REFERENCES departmente_cho(cod_dep) ON DELETE CASCADE;
--25
delete from departamente_cho
WHERE cod_dep = 20;
rollback;
--26
ALTER TABLE departamente_cho
ADD CONSTRAINT cod_director_fk FOREIGN KEY(cod_director) REFERENCES angajati_cho(cod_ang) ON DELETE CASCADE;
--27
ALTER TABLE departamente_cho
ADD CONSTRAINT cod_director_fk FOREIGN KEY(cod_director) REFERENCES angajati_cho (cod_ang) ON DELETE
SET NULL;
UPDATE department_cho
SET cod_director = 102
WHERE cod_dep = 20;
--28
ALTER TABLE angajati_cho
ADD CONSTRAINT v_sal_cho CHECK(salariu <= 30000);
--29
ALTER TABLE angajati_cho disable constraint v_sal_cho;