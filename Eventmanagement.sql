create database EventManagement

use  EventManagement

create table eventstable
(
eventsid int primary key,
id int,
eventname varchar(20)
)


insert into eventstable values(101,1,'Birthday_Parties')

create table locationtable
(
locationid int primary key,
locationname varchar(20),
pincode bigint,
)

insert into locationtable values(001,'La_Cafe',641003),(002,'Cups_Cafe',641009),(003,'Must_Try_Cafe',642065),(004,'Lorry_Owners_Hall',641024),(005,'Amirtha_Party_Hall',600213),(006,'Subaveena_Hall',643124)


create table  themetable
(
themeid int primary key,
themename varchar(20)
)

insert into themetable values(011,'Black and Blue'),(012,'Pink and Blue'),(013,'green and cyan'),(014,'white and black'),(015,'Blach and white')


create table  datetable
(
dateid int primary key,
datesavailable date
)

insert into datetable values(021,'2023-08-04'),(022,'2023-08-08'),(023,'2023-08-12'),(024,'2023-08-16'),(025,'2023-08-20'),(026,'2023-09-01'),(027,'2023-08-02')


create table timetable
(
timeid int primary key,
timesavailable time
)

INSERT INTO timetable (timeid, timesavailable)
VALUES
    (021, '02:00 AM'),
    (022, '06:00 AM'),
    (023, '10:00 AM'),
    (024, '02:00 PM'),
    (025, '06:00 PM'),
    (026, '01:00 AM'),
    (027, '02:00 AM');


create table eventnames
(
eventid int references  eventstable(eventsid),
eventnameid int,
eventdate int references datetable(dateid),
eventtime int references timetable(timeid),
eventhallcapacity bigint,
eventcatering  bit not null default 0,
eventlocation int references locationtable(locationid),
eventtheme int references themetable(themeid),
eventcost bigint,
)

INSERT INTO eventnames VALUES (101,81,021,021,1000,0,001,011,3000)
  
select * from eventnames
select * from locationtable
select * from timetable
select * from datetable
select * from  eventstable
select * from  themetable



---testing
create table RoleTables
(
  TRoleid int primary key,
  TRolename varchar(20),
)

insert into RoleTables values(1,'Admin'),(2,'User')


create table UserTables
(
  TUserid int primary key,
  TUsername varchar(20),
  TPassword varchar(20),
  TEmail varchar(20),
  TMobile bigint,
  LastLoginDate datetime,
  TRoleid int references RoleTables(TRoleid)
)

insert into UserTables values(11,'Pallavi','Pallavi@123','Pallavi@gmail.com',6382340717,'2023-09-04 14:30:00',1),(12,'Harita','Harita@123','Harita@gmail.com',6382340515,'2023-09-04 14:30:00',2)


select * from eventnames
select * from locationtable
select * from timetable
select * from datetable
select * from  eventstable
select * from  themetable
select * from  RoleTables
select * from  UserTables


CREATE  PROCEDURE [dbo].[Validate_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserId INT, @LastLoginDate DATETIME, @RoleId INT
	
	SELECT @UserId = TUserid, @LastLoginDate = LastLoginDate, @RoleId = TRoleid 
	FROM UserTables WHERE TUsername = @Username AND [TPassword] = @Password
	
	IF @UserId IS NOT NULL
	BEGIN
		BEGIN
			UPDATE  UserTables
			SET LastLoginDate =  GETDATE()
			WHERE TUserid = @UserId
			
			SELECT @UserId [TUserid], 
					(SELECT  TRolename FROM RoleTables
					 WHERE TRoleid = @RoleId) [Roles] -- User Valid
		END
	END
	ELSE
	BEGIN
		SELECT -1 [TUserId], '' [Roles] -- User invalid.
	END
END


