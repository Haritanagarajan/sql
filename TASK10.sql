CREATE DATABASE TASK10

USE  TASK10

--CREATE TABLE EMPLOYEES

CREATE TABLE EMPLOYEES(
EMPLOYEE_ID INT,
 FIRST_NAME VARCHAR(20),
 LAST_NAME VARCHAR(20),
 EMAIL VARCHAR(30),
 PHONE_NUMBER BIGINT,
 JOB_ID INT,
 SALARY BIGINT
)

--INSERTING VALUES IN TABLE

INSERT INTO EMPLOYEES VALUES(1,'HARITA','N','HARITAN@GMAIL.COM',9876545678,1223,12000),(2,'RANIITA','N','RANITAN@GMAIL.COM',9886545678,1224,13000),
(3,'HARISH','B','HARISH@GMAIL.COM',9886545678,1225,12900),(4,'VASANTH','R','VASANTHR@GMAIL.COM',9876945678,1226,12000),
(5,'HARINI','C','HARINIC@GMAIL.COM',9876545678,1227,12600),(6,'HARSITHA','U','HARSHITHAU@GMAIL.COM',9876590678,1228,80000),
(7,'KAVYA','P','KAVYAP@GMAIL.COM',9076545678,1229,19000),(8,'KARTHICK','N','KARTHICK@GMAIL.COM',9853678678,1230,82000),(9,'SAVITHA','S','SAVITHAS@GMAIL.COM',9876545690,1231,13400),
(10,'HARITANAGARAJAN','N','HARITANAGARAJAN@GMAIL.COM',6382830178,1232,12000),
(11,'RANIITANAGARAJAN','P','RANITANAGARAJAN@GMAIL.COM',9784688947,1233,10000),
(12,'HARISHMITHA','B','HARISHMITHA@GMAIL.COM',9008654567,1234,12900),
(13,'VASANTHKUMAR','R','VASANTHKUMAR@GMAIL.COM',9876945890,1235,12000),
(14,'HARINIBALA','C','HARINIBALAC@GMAIL.COM',9876545678,1236,12600),(15,'HARSITHABACHAN','U','HARSHITHABACHAN@GMAIL.COM',9876590678,1237,80000),
(16,'KAVYAPRIYA','P','KAVYAPRIYA@GMAIL.COM',9076905678,1238,19000),(17,'KARTHICKEYAN','N','KARTHICKEYAN@GMAIL.COM',9853678978,1239,82000),
(18,'SAVITHAKRISHAN','S','SAVITHAKRISHNAN@GMAIL.COM',8876545690,1240,13400),(19,'DOLU','M','DOLU@GMAIL.COM',1234567890,1241,120000),(20,'BOLU','M','BOLU@GMAIL.COM',6382830515,1242,18000)

--RETRIEVING RECORDS FROM TABLE

SELECT * FROM EMPLOYEES


--ALTERING TABLE TO ADD HIRE_DATE COLUMN

ALTER TABLE EMPLOYEES ADD HIRE_DATE DATE

--UPDATING VALUES IN HIRE_DATE COLUMN

UPDATE EMPLOYEES SET HIRE_DATE= '2023-01-31'

--1

SELECT FIRST_NAME,LAST_NAME   
    FROM EMPLOYEES
    WHERE SALARY > (SELECT SALARY   
    FROM EMPLOYEES   
    WHERE  EMPLOYEE_ID=16)


--2

SELECT FIRST_NAME,LAST_NAME,JOB_ID
FROM EMPLOYEES WHERE HIRE_DATE = (SELECT HIRE_DATE FROM EMPLOYEES
WHERE EMPLOYEE_ID=11)

--3

SELECT AVG(SALARY) FROM EMPLOYEES

SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY FROM EMPLOYEES WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEES)

--4

SELECT FIRST_NAME,LAST_NAME,EMPLOYEE_ID,SALARY FROM EMPLOYEES WHERE FIRST_NAME =(SELECT FIRST_NAME FROM EMPLOYEES WHERE FIRST_NAME='HARSITHA')

--5

SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN(SELECT MIN(SALARY) FROM EMPLOYEES  )AND 30000

 use TASK10