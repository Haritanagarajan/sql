USE TASK11

SELECT * FROM STUDENTS

--1

--AUTO COMMIT SINCE STATEMENTS ARE CORRECT IT IS COMMITTED

BEGIN TRAN

INSERT INTO STUDENTS
VALUES(12,'JONNY','BBA',2022)

UPDATE STUDENTS SET S_YEAR_COMPLETE=2023 WHERE S_ID=12

SELECT * FROM STUDENTS

COMMIT TRAN

--AUTO ROLLBACK WILL THROW ERROR

--SINCE BCA IS NOT ENCLOSED IN QUOTES(VARCHAR)

BEGIN TRAN

INSERT INTO STUDENTS VALUES(13,'GIYAAN',BCA,2022)

SELECT * FROM STUDENTS

COMMIT TRAN


--2

--IMPLICIT TRANSACTION

SET IMPLICIT_TRANSACTIONS ON

UPDATE STUDENTS 
SET S_NAME='KARTHY'
WHERE S_ID=3

SELECT
IIF(@@OPTIONS & 2=2,
'IMPLICIT METHOD IS ON',
'IMPLICIT METHOD IS OFF')
AS TRANSACTION_ON_OFF

SELECT @@TRANCOUNT AS TRANSACTION_OPEN

COMMIT TRAN

SELECT @@TRANCOUNT AS TRANSACTION_OPEN

SET IMPLICIT_TRANSACTIONS OFF

--SELECT FROM STUDENTS IT WILL BE UPDATED

--3

--EXPLICIT TRANSACTIONS

--A] ONLY COMMIT INSERT

BEGIN TRAN

INSERT INTO STUDENTS VALUES(22,'SAMMY','BSCIT',2022)

SELECT @@TRANCOUNT AS CHECK_HOW_MANY_TRANS

COMMIT TRAN

SELECT @@TRANCOUNT AS CHECK_HOW_MANY_TRANS

--CHECKING IT IS UPDATED OR NOT

SELECT * FROM STUDENTS

--B] ONLY ROLLBACK WITH UPDATE

BEGIN TRAN

UPDATE STUDENTS
SET S_ID=21 WHERE S_NAME='JONNY'

SELECT @@TRANCOUNT AS CHECK_HOW_MANY_TRANS

ROLLBACK TRAN

SELECT @@TRANCOUNT AS CHECK_HOW_MANY_TRANS

--CHANGES WILL NOT BE REFLECTED SINCE IT IS ROLLBACK THE CHANGES MADE IN THAT

SELECT * FROM STUDENTS

--C]SAVEPOINT - COMMIT UPDATE INSERT, ROLLBACK DELETE STATEMENT

BEGIN TRAN

UPDATE STUDENTS SET S_ID=21 WHERE S_NAME='JONNY'

INSERT INTO STUDENTS VALUES(23,'NITHIN','BIO',2022)

SAVE TRANSACTION UPDATE_INSERT

DELETE FROM STUDENTS WHERE S_ID=22

--HERE IT IS DELETED

SELECT * FROM STUDENTS

ROLLBACK TRANSACTION UPDATE_INSERT

COMMIT TRAN

--BUT OUTSIDE COMMIT IT IS ROLLBACKED TO LAST COMMIT OF INSERT AND UPDATE

SELECT * FROM STUDENTS


