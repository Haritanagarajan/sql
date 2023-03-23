--QUERIES
                 
--1

SELECT * FROM worker
SELECT * FROM Title
SELECT * FROM BONUS

SELECT FIRST_NAME as WORKER_NAME from worker

--2

SELECT UPPER(FIRST_NAME) AS FIRST_NAME FROM worker

--3

SELECT DISTINCT DEPARTMENT FROM worker


--4

SELECT FIRST_NAME,SUBSTRING(FIRST_NAME, 1, 3) AS TFIRST_THREE_CHARNAME  from worker;

--5

SELECT DISTINCT LEN(DEPARTMENT) AS DEPARTMENT FROM worker

--6

alter table worker add COMPLETE_NAME as (FIRST_NAME + SPACE(3)+ LAST_NAME) persisted

SELECT(FIRST_NAME+SPACE(1)+LAST_NAME) AS COMPLETE_NAME FROM worker

--7

SELECT * FROM worker WHERE FIRST_NAME = 'Vipul' or FIRST_NAME='Satish'

--8

select * from worker where DEPARTMENT='Admin'

--9

select * from worker where FIRST_NAME like '%_a'

--10

select * from worker where FIRST_NAME like '%a%'

