<<<<<<< HEAD
use task9

--1

--PROCEDURE WITH CONDITIONAL STATEMENTS


--CREATE TABLE STUDENT

CREATE TABLE STUDENT_DETAILSS(
NAME VARCHAR(20),
MARKS INT)

--INSERTING VALUES

INSERT INTO STUDENT_DETAILSS VALUES('HARITA',200),('HARISHMITHA',300)


--CREATE PROCEDURE WITH CONDITIONAL STATEMENTS


CREATE PROCEDURE SP_MARKSSS @STU_NAME VARCHAR (20)
AS
BEGIN
    IF (10  > 0)
    BEGIN
        IF (@STU_NAME='HARITA')
            select * from STUDENT_DETAILSS where NAME='HARITA'
        ELSE
            PRINT 'Record no found';
    END			
END

--EXECUTING PROCEDURE


EXEC SP_MARKSSS 'HARISHMITHA'


--3

--TEMPORARY TABLES (LOCAL AND GLOBAL)

--LOCAL
CREATE TABLE #FRUITSS(
ID INT,
NAME VARCHAR(20)
)

--INSERT VALUES

INSERT INTO #FRUITSS VALUES(1,'APPLE'),(2,'ORANGE')


--GLOBAL

CREATE TABLE ##FRUITSS(
ID INT,
NAME VARCHAR(20)
)

--INSERT VALUS

INSERT INTO ##FRUITSS VALUES(1,'APPLE'),(2,'ORANGE')

select * from #FRUITSS

select * from ##FRUITSS

--CREATE TABLE VARIABLES TABLE PRICE

DECLARE @PRICE TABLE (
    NAME VARCHAR(25),
    PRICE int,
	PLACE VARCHAR(25)
);

INSERT INTO @PRICE
VALUES('CARROT',300,'OOTY')

select * from @PRICE;

--2

--CREATING PROCEDURES WITH CASE VALUES

CREATE PROCEDURE SP_NAME with encryption
AS
BEGIN
SELECT NAME,MARKS,
CASE MARKS
  WHEN '200' THEN 'VERY POOR'
  WHEN '300' THEN 'GOOD KEEP TRYING'
END AS 'REMARKS'
FROM STUDENT_DETAILSS;
END;


--EXECUTING PROCEDURES

=======
use task9

--1

--PROCEDURE WITH CONDITIONAL STATEMENTS


--CREATE TABLE STUDENT

CREATE TABLE STUDENT_DETAILSS(
NAME VARCHAR(20),
MARKS INT)

--INSERTING VALUES

INSERT INTO STUDENT_DETAILSS VALUES('HARITA',200),('HARISHMITHA',300)


--CREATE PROCEDURE WITH CONDITIONAL STATEMENTS


CREATE PROCEDURE SP_MARKSSS @STU_NAME VARCHAR (20)
AS
BEGIN
    IF (10  > 0)
    BEGIN
        IF (@STU_NAME='HARITA')
            select * from STUDENT_DETAILSS where NAME='HARITA'
        ELSE
            PRINT 'Record no found';
    END			
END

--EXECUTING PROCEDURE


EXEC SP_MARKSSS 'HARISHMITHA'


--3

--TEMPORARY TABLES (LOCAL AND GLOBAL)

--LOCAL
CREATE TABLE #FRUITSS(
ID INT,
NAME VARCHAR(20)
)

--INSERT VALUES

INSERT INTO #FRUITSS VALUES(1,'APPLE'),(2,'ORANGE')


--GLOBAL

CREATE TABLE ##FRUITSS(
ID INT,
NAME VARCHAR(20)
)

--INSERT VALUS

INSERT INTO ##FRUITSS VALUES(1,'APPLE'),(2,'ORANGE')

select * from #FRUITSS

select * from ##FRUITSS

--CREATE TABLE VARIABLES TABLE PRICE

DECLARE @PRICE TABLE (
    NAME VARCHAR(25),
    PRICE int,
	PLACE VARCHAR(25)
);

INSERT INTO @PRICE
VALUES('CARROT',300,'OOTY')

select * from @PRICE;

--2

--CREATING PROCEDURES WITH CASE VALUES

CREATE PROCEDURE SP_NAME with encryption
AS
BEGIN
SELECT NAME,MARKS,
CASE MARKS
  WHEN '200' THEN 'VERY POOR'
  WHEN '300' THEN 'GOOD KEEP TRYING'
END AS 'REMARKS'
FROM STUDENT_DETAILSS;
END;


--EXECUTING PROCEDURES

>>>>>>> 4e89d45b77e637ecbcf09889681e8d8432a6eda8
EXEC SP_NAME