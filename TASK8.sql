create database task8
use task8

--PROCEDURES

--1

--STUDENT TABLE

CREATE TABLE STUDENT(
STUDENTID INT,
STUDENT_NAME VARCHAR(20),
SEM VARCHAR(20),
SECURED_MARKS INT,
TOTAL_MARKS INT
)

--INSERTING VALUES

INSERT INTO STUDENT VALUES(1,'JOHN','SEM 1',450,500),(2,'HARI','SEM 1',400,500),(3,'VASANTH','SEM 1',300,500),(4,'NITHISH','SEM 1',230,500),(5,'SHANTHI','SEM 1',500,500)
INSERT INTO STUDENT VALUES(6,'GIYAN','SEM 2',450,500)

UPDATE STUDENT SET STUDENT_NAME='JONNY' WHERE STUDENTID=1

--RETRIEVING VALUES

SELECT * FROM STUDENT


--SCALAR FUNCTION

CREATE FUNCTION SF_PERCENTAGE(@MARK INT,@TOTAL_MARK INT)
RETURNS INT 
AS 
BEGIN
DECLARE @PERCENTAGE INT
SET @PERCENTAGE=(@MARK * 100)/@TOTAL_MARK
RETURN @PERCENTAGE
END

--FUNCTION CALL

SELECT dbo.SF_PERCENTAGE(SECURED_MARKS,TOTAL_MARKS)AS STUDENT_PERCENTAGE FROM STUDENT

--2

--INLINE TABLE VALUED FUNCTION 


CREATE FUNCTION IN_VAL_FUNC_SEM3(@SEM VARCHAR(10))
RETURNS TABLE
AS
RETURN (SELECT * FROM dbo.STUDENT WHERE SEM=@SEM)


--CALLING FUNCTION

SELECT * FROM IN_VAL_FUNC_SEM3('SEM 1')

--3

--STORED PROCEDURE

CREATE PROCEDURE SP_STUDENT_DETAILS
AS
BEGIN
SELECT * FROM dbo.STUDENT
END

--EXECUTING THE PROCEDURE

EXEC SP_STUDENT_DETAILS

--4

--STORED PROCEDURE

CREATE PROCEDURE SP_SEM1_STUDTAILSS(@sem1 varchar(10))
AS
BEGIN
SELECT * FROM STUDENT WHERE SEM=@sem1
END

--EXECUTING PROCEDCURE

EXEC SP_SEM1_STUDTAILSS 'SEM 1'

--5

--STORED PROCEDURE

CREATE PROCEDURE SP_TOTAL_STUDTAILSSS(@SEM1 VARCHAR(10) OUTPUT)
AS
BEGIN
SELECT COUNT(STUDENTID) AS TOTAL_NUM_STUD_DETAILSSS FROM STUDENT
END

--EXECUTE PROCEDURE

EXEC SP_TOTAL_STUDTAILSSS 'SEM 1'

--DECLARE ANOTHER VARIABLE TO STORE OUTPUT

DECLARE @TOT INT

--EXEC PROCEDURE

EXEC SP_TOTAL_STUDTAILSSS @TOT OUTPUT

--PRINT TOT

PRINT @TOT

--6

--MERGE STATEMENT

--BACKUP TABLE

CREATE TABLE STUDENT_BACKUP(
STUDENTID INT,
STUDENT_NAME VARCHAR(20),
SEM VARCHAR(20),
SECURED_MARKS INT,
TOTAL_MARKS INT
)

--MERGE

MERGE STUDENT_BACKUP B
USING (SELECT * FROM STUDENT WHERE SEM='SEM 1') AS S
ON(S.STUDENTID=B.STUDENTID)
WHEN MATCHED 
THEN UPDATE SET 
B.STUDENT_NAME=S.STUDENT_NAME
WHEN NOT MATCHED BY TARGET 
THEN INSERT(STUDENTID,STUDENT_NAME,SEM,SECURED_MARKS,TOTAL_MARKS)
VALUES(S.STUDENTID,S.STUDENT_NAME,S.SEM,S.SECURED_MARKS,S.TOTAL_MARKS)
WHEN NOT MATCHED BY SOURCE
THEN DELETE;

SELECT * FROM STUDENT_BACKUP
