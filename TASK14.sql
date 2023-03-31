create database task14
use task14


--1

--CREATE TABLE HOBBIES

create table hobbies(
hobbyid int primary key,
hobbyname varchar(20) unique
)

--CREATE STORED PROCEDURE TO INSERT VALUES

CREATE PROCEDURE sp_insert_hobbies
@hobbyid int,
@hobbyname varchar(20)
as
begin
set nocount on
insert into hobbies(hobbyid,hobbyname) values(@hobbyid ,@hobbyname)
end

begin try 
exec sp_insert_hobbies 112,'dancing'
exec sp_insert_hobbies 113,'travelling'
exec sp_insert_hobbies 114,'singing'
exec sp_insert_hobbies 114,'dancing'
end try

begin catch
PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
    PRINT 'Error Procedure: ' + CAST(ERROR_PROCEDURE() AS VARCHAR);
   INSERT INTO  errorbackup (ErrorMessage, ErrorNumber, ErrorSeverity, ErrorState, ErrorLine, ErrorProcedure)
    VALUES (ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_LINE(), ERROR_PROCEDURE());
END CATCH

---backup table

create table errorbackup(
ErrorBackupID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorMessage VARCHAR(MAX),
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    ErrorLine INT,
    ErrorProcedure VARCHAR(100),
    ErrorDateTime DATETIME DEFAULT GETDATE()
);

select * from hobbies

select * from errorbackup

--2

--create procedure to calculate

create procedure CALCULATE

@num1 int,
@num2 int
as
begin
  if @num1=@num2
  begin
  declare
  @product int
  set @product =@num1 * @num2;
  print 'the product of ' +(cast(@num1 as varchar)) +'and '+(cast(@num2 as varchar))+'is'+(cast(@product as varchar));
  end
  else
  begin
  declare @errormessage varchar(500)='The numbers '+(cast(@num1 as varchar))+'and'+(cast(@num2 as varchar))+'are not not equal';
  Raiserror(@errormessage,16,1);
  end
  end

  exec CALCULATE 22,22

--3

--create table friends

create table friends(
name varchar(50))

--create procedure

create procedure frnds
@name varchar(25)
as
begin
if LEFT(@name ,1) in (' A','D','H','K','P','R','S','T','V','Y')
begin
insert into friends values(@name)
end
else
begin
throw 50002,'name must begin only  with A,D,H,K,P,R,S,T,V,Y ',1;
end
end

EXEC frnds 'WARI';

SELECT * FROM friends