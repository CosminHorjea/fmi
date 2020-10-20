--Laborator 2 SGBD
--1
SELECT *
FROM rental;

-- member (member_id)
--title (title_id)
--title_copy (copy_id si title_id)
--rental (book_date, copy_id, member_id, title_id)
--reservation (res_date, member_id, title_id)

--4
SELECT ti.title_id, title, copy_id
FROM title_copy ti JOIN title t ON (ti.title_id = t.title_id)
WHERE category = (SELECT category
                  FROM rental r JOIN title t ON (r.title_id = t.title_id)
                  GROUP BY category
                  HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                                     FROM rental r JOIN title t ON (r.title_id = t.title_id)
                                     GROUP BY category));

--5
SELECT *
FROM rental;

SELECT *
FROM title_copy;

SELECT title_id, COUNT(copy_id) AS "CARTI DISP"
FROM (SELECT copy_id, title_id
     FROM title_copy
     MINUS
     SELECT copy_id, title_id
     FROM rental
     WHERE act_ret_date IS NULL)
GROUP BY title_id;

--6
--metoda 1
SELECT t.title_id, title, copy_id, status, 'RENTED' status_corect
FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
WHERE (t.title_id, copy_id) IN (select title_id, copy_id
                                FROM rental
                                WHERE act_ret_date IS NULL)
UNION
SELECT t.title_id, title, copy_id, status, 'AVAILABLE' status_corect
FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
WHERE (t.title_id, copy_id) IN (SELECT title_id, copy_id
                                FROM title_copy
                                MINUS
                                SELECT title_id, copy_id
                                FROM rental
                                WHERE act_ret_date IS NULL);
--metoda 2 (CASE)

--7
--a
SELECT COUNT(*)
FROM (SELECT t.title_id, title, copy_id, status, 'RENTeD' status_corect
      FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
      WHERE (t.title_id, copy_id) IN (select title_id, copy_id
                                      FROM rental
                                      WHERE act_ret_date IS NULL)
      UNION
      SELECT t.title_id, title, copy_id, status, 'AVAIlABLE' status_corect
      FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
      WHERE (t.title_id, copy_id) IN (SELECT title_id, copy_id
                                      FROM title_copy
                                      MINUS
                                      SELECT title_id, copy_id
                                      FROM rental
                                      WHERE act_ret_date IS NULL))
WHERE status <> UPPER(status_corect);

--b
UPDATE title_copy tr
SET status = (SELECT UPPER(status_corect)
              FROM (SELECT t.title_id, title, copy_id, status, 'RENTeD' status_corect
                    FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
                    WHERE (t.title_id, copy_id) IN (select title_id, copy_id
                                                    FROM rental
                                                    WHERE act_ret_date IS NULL)
                    UNION
                    SELECT t.title_id, title, copy_id, status, 'AVAIlABLE' status_corect
                    FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
                    WHERE (t.title_id, copy_id) IN (SELECT title_id, copy_id
                                                    FROM title_copy
                                                    MINUS
                                                    SELECT title_id, copy_id
                                                    FROM rental
                                                    WHERE act_ret_date IS NULL))
                WHERE tr.title_id = title_id
                AND tr.copy_id = copy_id)
WHERE (title_id, copy_id) IN (SELECT title_id, copy_id
                              FROM (SELECT t.title_id title_id, title, copy_id, status, 'RENTeD' status_corect
                                    FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
                                    WHERE (t.title_id, copy_id) IN (select title_id, copy_id
                                                    FROM rental
                                                    WHERE act_ret_date IS NULL)
                    UNION
                    SELECT t.title_id title_id, title, copy_id, status, 'AVAIlABLE' status_corect
                    FROM title t JOIN title_copy ti ON t.title_id = ti.title_id
                    WHERE (t.title_id, copy_id) IN (SELECT title_id, copy_id
                                                    FROM title_copy
                                                    MINUS
                                                    SELECT title_id, copy_id
                                                    FROM rental
                                                    WHERE act_ret_date IS NULL))
                                WHERE status <> UPPER(status_corect));
ROLLBACK;

SELECT *
FROM title_copy;

--8
SELECT *
FROM reservation;

SELECT r.member_id, r.title_id, DECODE(r.res_date, re.book_date, 'Da', 'Nu') imp_ac_zi
FROM reservation r JOIN rental re ON (r.title_id = re.title_id AND r.member_id = re.member_id);

SELECT r.member_id, r.title_id, CASE 
                                    WHEN r.res_date <> re.book_date THEN 'Nu'
                                    ELSE 'Da'
                                END imp_ac_zi
FROM reservation r JOIN rental re ON (r.title_id = re.title_id AND r.member_id = re.member_id);

SELECT r.member_id, r.title_id, CASE r.res_date
                                    WHEN re.book_date THEN 'Da'
                                    ELSE 'Nu'
                                END imp_ac_zi
FROM reservation r JOIN rental re ON (r.title_id = re.title_id AND r.member_id = re.member_id);

--9
SELECT m.member_id, first_name, last_name, title, COUNT(copy_id)
FROM member m JOIN rental r ON m.member_id = r.member_id
              JOIN title t ON t.title_id = r.title_id
GROUP BY m.member_id, r.title_id, first_name, last_name, title;

SELECT m.member_id, MAX(first_name), MAX(last_name), MAX(title), COUNT(copy_id)
FROM member m JOIN rental r ON m.member_id = r.member_id
              JOIN title t ON t.title_id = r.title_id
GROUP BY m.member_id, r.title_id;

--TEMA 2, 3, 6 (alte rezolvari), 10, 11, 12

--6
SELECT title, t.title_id, tc.copy_id, tc.status, 
  (CASE WHEN status = 'RENTED' AND act_ret_date IS NULL THEN 'RENTED'
       ELSE 'AVAILABLE'
  END) AS "Status corect"
FROM title t, title_copy tc, rental r
WHERE t.title_id = tc.title_id AND r.copy_id = tc.copy_id AND r.title_id = t.title_id;

--10
SELECT m.last_name, m.first_name, r.copy_id,t.title_id, count(*)
FROM rental r join member m on (r.member_id = m.member_id)
               join title t on (t.title_id = r.title_id)
GROUP BY m.last_name,m.first_name,r.copy_id,t.title_id;

--11

--12
--a
SELECT book_date,COUNT(*)
from rental r
WHERE r.book_date BETWEEN last_day(add_months(sysdate,-1))+1 AND last_day(add_months(sysdate,-1))+2
group by book_date;
--b
SELECT book_date,COUNT(*)
from rental r
WHERE r.book_date BETWEEN last_day(add_months(sysdate,-1))+1 AND last_day(sysdate) AND ROWNUM <3
group by book_date;

--c