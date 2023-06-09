create database task7

use task7

--CREATION OF TABLE

create table example_cluster(
STUDENT_ID INT IDENTITY(1,4)PRIMARY KEY,
STUDENT_NAME VARCHAR(25),
DEPARTMENT VARCHAR(15),
SCORE INT
)

--INSERTING VALUES

INSERT INTO example_cluster VALUES ('John Smith', 'IT', 85),('Jane Doe', 'CT', 92),('Michael Lee', 'BCA', 78),
('Sarah Kim', 'Chemistry', 89),('David Wong', 'BCOM', 76),('Emily Chen', 'Physics', 94),('Tom Wilson', 'IT', 81),
('Ava Hernandez', 'CT', 87),('Ethan Davis', 'BCA', 73),('Liam Brown', 'Chemistry', 91),('Olivia Garcia', 'BCOM', 85),
('Sophia Rodriguez', 'Physics', 88),('Noah Martinez', 'IT', 77),('Isabella Jackson', 'CT', 90),('Mia Perez', 'BCA', 82),
('Charlotte Taylor', 'Chemistry', 94),('Benjamin Anderson', 'BCOM', 79),('Lucas Thomas', 'Physics', 86),('Evelyn Martin', 'IT', 88),
('William White', 'CT', 83),('Harper Thompson', 'BCA', 90),('James Harris', 'Chemistry', 76),('Amelia Young', 'BCOM', 91),
('Logan Scott', 'Physics', 84),('Natalie Allen', 'IT', 79)

--RETRIEVNG VALUES FROM TABLE

select * from example_cluster

--1

CREATE NONCLUSTERED INDEX DEPARTMENT ON example_cluster(DEPARTMENT)

--2

CREATE NONCLUSTERED INDEX NON_CLUSINDEX1 ON example_cluster(DEPARTMENT) where DEPARTMENT='CT'

--3

CREATE VIEW VIEW_BCA
AS SELECT * FROM example_cluster WHERE DEPARTMENT='BCA'

SELECT * FROM VIEW_BCA

--4

SELECT *,RANK () OVER (ORDER BY SCORE) AS STUDENT_RANK FROM example_cluster

--5

SELECT *,DENSE_RANK() OVER (ORDER BY SCORE) AS STUDENT_RANK FROM example_cluster


--6

--CREATE MANAGER TABLE

CREATE TABLE MANAGER(
MAN_ID INT PRIMARY KEY,
MAN_NAME VARCHAR(20)
)

--INSERTING VALUES

INSERT INTO MANAGER VALUES(123,'HARITA'),(124,'RANITA'),(125,'VASANTH'),(126,'TANYA')


--RETRIEVING THE VALUES

 

--CREATE EMPLOYEE TABLE

CREATE TABLE EMPLOYEE
(
EMP_ID INT PRIMARY KEY,
EMP_NAME VARCHAR(25),
M_ID INT REFERENCES MANAGER(MAN_ID)
)

--INSERT VALUES

INSERT INTO EMPLOYEE VALUES(1,'PALLAVI',123),(2,'THANGAM',124),(3,'SHARON',125),(4,'CHIKKU',126)

--RETRIEVING VALUES 

SELECT * FROM EMPLOYEE


A] CREATE VIEW MAN_EMPP
AS
SELECT MM.MAN_ID,MM.MAN_NAME,EM.EMP_ID,EM.EMP_NAME FROM MANAGER AS MM FULL JOIN EMPLOYEE AS EM ON MM.MAN_ID=EM.EMP_ID

SELECT * FROM MAN_EMPP

B] --ON DELETE CASCADE

ALTER TABLE EMPLOYEE DROP CONSTRAINT 
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_EMPLOYEE_M_ID FOREIGN KEY (M_ID)REFERENCES MANAGER(MAN_ID) ON DELETE CASCADE

DELETE FROM MANAGER WHERE MAN_ID=123

SELECT * FROM EMPLOYEE
SELECT * FROM MANAGER

--ON UPDATE SET DEFAULT

ALTER TABLE EMPLOYEE DROP CONSTRAINT [FK_EMPLOYEE_M_ID] 
ALTER TABLE EMPLOYEE DROP COLUMN M_ID 
ALTER TABLE EMPLOYEE ADD M_ID INT DEFAULT 2 CONSTRAINT FK_EMPLOYEE_M_ID FOREIGN KEY (M_ID) REFERENCES MANAGER (MAN_ID) ON UPDATE SET DEFAULT

UPDATE EMPLOYEE SET M_ID = 124 WHERE EMP_ID =2
UPDATE EMPLOYEE SET M_ID =125 WHERE EMP_ID=3
UPDATE EMPLOYEE SET M_ID=126 WHERE EMP_ID=4
 
INSERT INTO MANAGER VALUES(2,'HARITA')

UPDATE MANAGER SET MAN_ID=128 WHERE MAN_ID=126

use task7

--on delete and update set default

DROP TABLE EMPLOYEE

DROP TABLE MANAGER

SELECT * FROM EMPLOYEE

SELECT * FROM MANAGER

alter table EMPLOYEE DROP [FK__EMPLOYEE__M_ID__4E88ABD4]
ALTER TABLE EMPLOYEE DROP COLUMN M_ID

ALTER TABLE EMPLOYEE ADD M_ID INT DEFAULT 124 CONSTRAINT FK_EMP_M_ID FOREIGN KEY(M_ID) REFERENCES MANAGER(MAN_ID) ON DELETE CASCADE ON UPDATE SET DEFAULT

UPDATE EMPLOYEE SET M_ID = 123 WHERE EMP_ID =1
UPDATE EMPLOYEE SET M_ID =124 WHERE EMP_ID=2
UPDATE EMPLOYEE SET M_ID=125 WHERE EMP_ID=3
UPDATE EMPLOYEE SET M_ID=126 WHERE EMP_ID=4

DELETE FROM MANAGER WHERE MAN_ID=123

UPDATE MANAGER SET MAN_ID=223 WHERE MAN_ID=125

 