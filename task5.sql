use db1

select * from Trainy

---QUERIES

--1

SELECT COUNT(FIRST_NAME) AS 'COUNT OF EMPLOYEE',DEPARTMENT FROM Trainy GROUP BY  DEPARTMENT

--2

SELECT 
    TRAINEE_ID, 
    JOINING_DATE,
    DATEADD(day, 5, JOINING_DATE) INDUCTION_PROGRAMME_DATE
FROM 
    Trainy

--3

SELECT TRAINEE_ID,DEPARTMENT,
      CHOOSE(MONTH([JOINING_DATE]),'January','February','March','April','May','June',
      'July','August','September','October','November','December') AS 'MONTH OF JOINING DATE'
  FROM Trainy;


--4

SELECT coalesce (DEPARTMENT, 'DEPARTMENT TOTAL SALARY') AS DEPARTMENT,
  sum(SALARY) as TOTAL_SALARY
  FROM Trainy
  GROUP BY ROLLUP (DEPARTMENT)

--5

SELECT TOP 3 * FROM Trainy ORDER BY NEWID()

--6

create table COMPOSITE
(
id int IDENTITY (1,1),
Dept_id int,
Dept_name varchar(25),
constraint pk_id Primary Key(id),
constraint uk_id_name Unique (Dept_id,Dept_name)
)

insert into COMPOSITE(Dept_id,Dept_name) values(201,'DEVELOPER')
insert into COMPOSITE(Dept_id,Dept_name) values(202,'DESIGNER')

SELECT * FROM COMPOSITE

--7

--CASE

SELECT FIRST_NAME,DEPARTMENT,SALARY,
CASE
    WHEN SALARY >= 200000 THEN 'PERSON IS SENIOUR DESIGNER'
    WHEN SALARY <= 100000 THEN 'PERSON IS JUNIOUR DESIGNER'
    ELSE 'DESIGNER'
END AS 'Employee Details'
FROM Trainy

--IIF

SELECT *,IIF(DEPARTMENT='HR','STAFF IS PALLAVI','STAFF IS THANGAM') FROM Trainy

--8

--SEQUENCE CREATION

CREATE SEQUENCE [dbo].[SequenceObject]
AS INT
START WITH 1 
INCREMENT BY 1

--RETRIEVING SEQUENCE OBJECT

SELECT * FROM sys.sequences WHERE name = 'SequenceObject';

SELECT NEXT VALUE FOR [dbo].[SequenceObject];

--TABLE CREATION

CREATE TABLE EM
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
);

SELECT * FROM EM

--INSERTING VALUES
INSERT INTO EM VALUES
(NEXT VALUE for [dbo].[SequenceObject], 'BenNY', 'Male');
INSERT INTO EM VALUES
(NEXT VALUE for [dbo].[SequenceObject], 'Saran', 'MALE');
INSERT INTO EM VALUES
(NEXT VALUE for [dbo].[SequenceObject], 'Sara', 'female');

--ALTERING SEQUENCE TO RESTART WITH 1

ALTER SEQUENCE [SequenceObject] RESTART WITH 1

--9

CREATE SCHEMA DD1

CREATE TABLE DD1.SYNONYM1(
ID INT
)

CREATE SCHEMA DD2

CREATE TABLE DD2.SYNONYM2(
NAME VARCHAR(20)
)
create synonym f_emp FOR DD1.SYNONYM1

CREATE DATABASE COMPANY
USE COMPANY

CREATE SYNONYM db1 FOR DD2.SYNONYM2

--10

use db1

create table Dep
(
id int IDENTITY (1,1) primary key,
Dept_id int,
Dept_name varchar(25)
)

insert into Dep(Dept_id,Dept_name) values(1,'BCA'),(2,'IT'),(3,'CT')

SET IDENTITY_INSERT Dep off 

insert into Dep(Dept_id,Dept_name) values(4,'DS')

select * from Dep

SET IDENTITY_INSERT Dep on

insert into Dep(id,Dept_id,Dept_name) values(6,5,'AI')




