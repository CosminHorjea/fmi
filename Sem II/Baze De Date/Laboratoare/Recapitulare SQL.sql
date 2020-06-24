--RECAPITULARE SQL

select * from timbru;

select * from soc_asigurare;

select * from ESTE_ASIGURAT;

1. Sa se obtina societatile de asigurari (cod, nume) care au asigurat TOATE timbrele emise in anul 2017.

select sa.cod_asigurator, nume_societate
from soc_asigurare sa join este_asigurat ea on (sa.cod_asigurator = ea.cod_asigurator)
where cod_timbru in (select cod_timbru
                     from timbru
                     where to_char(data_emitere, 'yyyy') = 2017 
                     ) -- 10, 20, 60 timbre emise in 2017
group by sa.cod_asigurator, nume_societate
having count(cod_timbru) = (select count(cod_timbru)
                            from timbru
                            where to_char(data_emitere, 'yyyy') = 2017 
                            );

/*
to_char
to_date
to_number;
*/


2. Creati tabelele TIMBRU_PNU, VINDE_PNU si VANZATOR_PNU 
prin copierea structurii si continutului tabelelor TIMBRU, VINDE si VANZATOR.
Atentie la constrangerile de integritate.

select * from timbru;

select * from vinde;

select * from vanzator;

create table timbru_pnu1 as
    select * from timbru;
    
create table vinde_pnu1 as
    select * from vinde;
    
create table vanzator_pnu1 as
    select * from vanzator;
    

select * from timbru_pnu1;

desc timbru;
desc timbru_pnu1;

select * from user_constraints
where lower(table_name) = 'timbru';

select * from user_constraints
where lower(table_name) = 'timbru';

select * from user_constraints
where lower(table_name) = 'timbru_pnu1';

select * from user_constraints
where lower(table_name) = 'vanzator_pnu1';

select * from user_constraints
where lower(table_name) = 'vinde';

select * from user_constraints
where lower(table_name) = 'vinde_pnu1';

alter table timbru_pnu1
add constraint pk_timbru_pnu1 primary key(cod_timbru);

alter table vanzator_pnu1
add constraint pk1_vanzator_pnu1 primary key(cod_vanzator);

alter table vinde_pnu1
add constraint fk1_timbru_pnu1 foreign key(cod_timbru) references timbru_pnu1(cod_timbru);

alter table vinde_pnu1
add constraint fk_vanzator_pnu1 foreign key(cod_vanzator) references vanzator_pnu1(cod_vanzator);

alter table vinde_pnu1
add constraint pk_compus_pnu1 primary key(cod_timbru, cod_vanzator);

alter table vinde_pnu1
drop constraint FK_TIMBRU_PNU1;


3. Actualizati coloana “timbre_vandute” a tabelului VANZATOR_PNU 
(OBS: trebuie sa rezolvati acest exercitiu folosind tabelele create la exercitiul anterior), 
astfel incat aceasta sa contina numarul de timbre vandute de fiecare vanzator;

select * from vanzator;

select * from vinde;

update vanzator v
set timbre_vandute = (select count(cod_timbru)
                      from vinde
                      where cod_vanzator = v.cod_vanzator);
           


4. Creati tabelul “valoare_totala_pnu” care sa contina codul timbrului, 
codul vanzatorului, numele timbrului, numele vanzatorului, numarul total de timbre si 
suma totala vanduta pentru fiecare timbru in parte

Coloanele se vor numi: cod_timbru, cod_vanzator, nume_timbru, nume_vanzator, numar_total_timbre, suma_vanduta

desc timbru;
desc vanzator;

create table valoare_totala_pnu
    (cod_timbru NUMBER(5),
     cod_vanzator NUMBER(5),
     nume_timbru VARCHAR2(20) NOT NULL,
     nume_vanzator VARCHAR2(20) NOT NULL,
     numar_total_timbre NUMBER(5) NOT NULL,
     suma_vanduta NUMBER(10) NOT NULL,
     primary key (cod_timbru, cod_vanzator)
    );

insert into valoare_totala_pnu (cod_timbru, cod_vanzator, nume_timbru, nume_vanzator, numar_total_timbre, suma_vanduta)
    (select t.cod_timbru CodTimbru, vanz.cod_vanzator, t.nume NumeTimbru, vanz.nume NumeVanzator,
            (select count(cod_timbru)
             from vinde
             where cod_timbru = t.cod_timbru) "Total timbre",
             
             (select sum(val_cumparare)
              from vinde
              where cod_timbru = t.cod_timbru) as "Suma vanduta"
              
     from vanzator vanz join vinde v on (vanz.cod_vanzator = v.cod_vanzator)
                        join timbru t on (v.cod_timbru = t.cod_timbru)
    );

select * from valoare_totala_pnu;

5. Sa se creeze o vizualizare “info_pnu” care contine informatii despre vanzatorii 
(nume, cod) si timbrele vandute de acestia (cod, nume, data_emitere)
care au fost emise in anul 2018. Care sunt coloanele actualizabile ale acestei vizualizari? Justificati;

create or replace view info_pnu 
   as (select vanz.nume as NumeVanz, vanz.cod_vanzator, t.cod_timbru, t.nume as NumeTimbru, t.data_emitere
       from vanzator vanz join vinde v on (vanz.cod_vanzator = v.cod_vanzator)
                          join timbru t on (v.cod_timbru = t.cod_timbru)
       where to_char(data_emitere, 'yyyy') = 2018);

select * from info_pnu;
select * from user_updatable_columns
where LOWER(table_name) = 'info_pnu'; 

--6
create table student_pnu
    (cod number(5) constraint pk primary key,
     nume varchar2(20) not null,
     prenume varchar2(20) not null,
     email varchar2(20) unique
     );
     
create table curs_pnu
    (cod number(5) primary key,
     denumire varchar2(20) not null,
     an_desfasurare varchar2(5) not null
     );
     
create table participa_pnu
    (cod_stud number(5) references student_pnu(cod),
     cod_curs number(5) constraint fk references curs_pnu(cod),
     data_participarii date not null,
     primary key(cod_stud, cod_curs),
     );
     
insert into student_pnu values (10, 'nume10', 'pren10', 'email10');
insert into student_pnu values (20, 'nume20', 'pren20', 'email20');
insert into student_pnu values (30, 'nume30', 'pren30', 'email30');

insert into curs_pnu values (100, 'curs100', 'I');
insert into curs_pnu values (200, 'curs200', 'II');
insert into curs_pnu values (300, 'curs300', 'III');
insert into curs_pnu values (400, 'curs400', 'II');


insert into participa_pnu values (10, 100, to_date('12/06/2020', 'dd/mm/yyyy'));
insert into participa_pnu values (10, 200, to_date('12/06/2020', 'dd/mm/yyyy'));
insert into participa_pnu values (20, 300, to_date('12/06/2020', 'dd/mm/yyyy'));
insert into participa_pnu values (30, 400, to_date('12/06/2020', 'dd/mm/yyyy'));
insert into participa_pnu values (20, 100, to_date('12/06/2020', 'dd/mm/yyyy'));

commit;

select * from student_pnu;

select * from curs_pnu;

select * from participa_pnu;

delete from student_pnu
where cod = 10;

delete from curs_pnu
where cod = 300;

alter table participa_pnu
drop constraint FK;

select * from user_constraints
where lower(table_name) = 'participa_pnu';

alter table participa_pnu
drop constraint FK;

alter table participa_pnu
drop constraint SYS_C00362865;

alter table participa_pnu
add constraint fk_curs foreign key(cod_curs) references curs_pnu(cod) on delete cascade;

alter table participa_pnu
add constraint fk_stud foreign key(cod_stud) references student_pnu(cod) on delete cascade;

delete from student_pnu
where cod = 10;

delete from curs_pnu
where cod = 300;

8. Sa se afiseze vanzatorii care au vandut cel mult aceleasi timbre ca si vanzatorul 1.

vanz 1 -> 10, 30, 80 
vanz 3 -> 10, 80
vanz 5 -> 10, 80
select * from vinde;
select * from vanzator;

select vanz.cod_vanzator, vanz.nume
from vanzator vanz join vinde vi on (vanz.cod_vanzator = vi.cod_vanzator)
where cod_timbru in (select cod_timbru
                     from vinde
                     where cod_vanzator = 1
                     )
     and vanz.cod_vanzator != 1
group by vanz.cod_vanzator, vanz.nume
having count(cod_timbru) <= (select count(cod_timbru)
                             from vinde
                             where cod_vanzator = 1)        
             
MINUS

select vanz.cod_vanzator, vanz.nume
from vanzator vanz join vinde vi on (vanz.cod_vanzator = vi.cod_vanzator)
where cod_timbru not in (select cod_timbru
                         from vinde
                         where cod_vanzator = 1
                        );




