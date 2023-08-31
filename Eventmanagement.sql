create database EventManagement

use  EventManagement

create table eventstable
(
eventsid int primary key,
id int,
eventname varchar(20)
)


create table locationtable
(
locationid int primary key,
locationname varchar(20),
pincode bigint,
)


create table  themetable
(
themeid int primary key,
themename varchar(20)
)


create table  datetable
(
dateid int primary key,
datesavailable date
)


create table timetable
(
timeid int primary key,
timesavailable time
)


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

create table RoleTables
(
  TRoleid int primary key,
  TRolename varchar(20),
)

create table UserTables
(
  TUserid int primary key,
  TUsername varchar(20),
  LastLoginDate datetime,
  TRoleid int references RoleTable(TRoleid)
)

CREATE  PROCEDURE [dbo].[Validate_User]	@Username NVARCHAR(20),	@Password NVARCHAR(20)ASBEGIN	SET NOCOUNT ON;	DECLARE @UserId INT, @LastLoginDate DATETIME, @RoleId INT		SELECT @UserId = TUserid, @LastLoginDate = LastLoginDate, @RoleId = TRoleid 	FROM UserTables WHERE TUsername = @Username AND [Password] = @Password		IF @UserId IS NOT NULL	BEGIN		BEGIN			UPDATE  UserTables			SET LastLoginDate =  GETDATE()			WHERE TUserid = @UserId						SELECT @UserId [TUserid], 					(SELECT  TRolename FROM RoleTables					 WHERE TRoleid = @RoleId) [Roles] -- User Valid		END	END	ELSE	BEGIN		SELECT -1 [TUserId], '' [Roles] -- User invalid.	ENDEND