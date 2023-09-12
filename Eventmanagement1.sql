create database EventManagement1

use EventManagement1



create table Usertable
(
  TUserid int primary key,
  TUsername varchar(40),
  TEmail varchar(40),
  TPassword varchar(40),
  TConfirmPassword varchar(40),
  TMobile bigint,
  TGender NVARCHAR(20),
  TAge int,
  LastLoginDate datetime,
  TProfife varbinary(max),
  TRoleid int references Roletable(TRoleid)
)

ALTER TABLE Usertable
ADD CONSTRAINT CHK_Gender CHECK (TGender IN ('Female', 'Male', 'Other'));

select * from Usertable

insert into Usertable values(1,'Pallavi','Pallavi@gmail.com','Pallavi@123','Pallavi@123',6382830515,'Female',21,'2022-04-22 10:34:53.44',0,11)
update Usertable set TRoleid = 21 where TUserid = 2

create table Roletable
(
  TRoleid int primary key,
  TRolename varchar(20),
  TRoleimage varbinary(max)
)

insert into Roletable values(11,'Admin',01),(21,'User',11)

CREATE  PROCEDURE [dbo].[Validate_User]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserId INT, @LastLoginDate DATETIME, @RoleId INT
	
	SELECT @UserId = TUserid, @LastLoginDate = LastLoginDate, @RoleId = TRoleid 
	FROM Usertable WHERE TUsername = @Username AND [TPassword] = @Password
	
	IF @UserId IS NOT NULL
	BEGIN
		BEGIN
			UPDATE  Usertable
			SET LastLoginDate =  GETDATE()
			WHERE TUserid = @UserId
			
			SELECT @UserId [TUserid], 
					(SELECT  TRolename FROM Roletable
					 WHERE TRoleid = @RoleId) [Roles] -- User Valid
		END
	END
	ELSE
	BEGIN
		SELECT -1 [TUserId], '' [Roles] -- User invalid.
	END
END


create table  themetable
(
themeid int primary key,
themename varchar(20),
themed bit not null default 0,
themeimage varbinary(max)
)

insert into themetable values(1,'Black',0,000)

create trigger SoftDelete1 ON  themetable
  instead of delete
  as begin
  set nocount on;
  update  themetable
  set  themed= 1
  WHERE themeid IN (SELECT themeid  FROM deleted);
  END


create table locationtable
(
locationid int primary key,
locationname varchar(20),
pincode bigint,
locationd bit not null default 0,
locationimage varbinary(max)
)

insert into locationtable values(23,'Custom Cafe',641008,0,000)


create trigger SoftDelete2 ON  locationtable
  instead of delete
  as begin
  set nocount on;
  update  locationtable
  set  locationd= 1
  WHERE locationid IN (SELECT locationid  FROM deleted);
  END


create table  datetable
(
dateid int primary key,
datesavailable date,
dated bit not null default 0
)

insert into datetable values(1,'2023-10-12',00)

create trigger SoftDelete3 ON  datetable
  instead of delete
  as begin
  set nocount on;
  update  datetable
  set  dated= 1
  WHERE dateid IN (SELECT dateid  FROM deleted);
  END


create table timetable
(
timeid int primary key,
timesavailable time,
timed bit not null default 0
)
insert into timetable values(1,'12:00',00)

create trigger SoftDelete4 ON  timetable
  instead of delete
  as begin
  set nocount on;
  update  timetable
  set  timed= 1
  WHERE timeid IN (SELECT timeid  FROM deleted);
  END


create table caketable
(
cakeid int primary key,
cakesavailable varchar(40),
caked bit not null default 0,
cakeimage varbinary(max)
)

insert into caketable values(1,'Chocolate',0,00)


create trigger SoftDelete5 ON  caketable
  instead of delete
  as begin
  set nocount on;
  update  caketable
  set  caked= 1
  WHERE cakeid IN (SELECT cakeid  FROM deleted);
  END


create table decorationtable
(
decorid int primary key,
decoravailable varchar(40),
decord bit not null default 0,
decorimage varbinary(max)
)

insert into decorationtable values(1,'Balloon',0,00)

create trigger SoftDelete6 ON  decorationtable
  instead of delete
  as begin
  set nocount on;
  update  decorationtable
  set  decord= 1
  WHERE decorid IN (SELECT decorid  FROM deleted);
  END



create table EventNames(
eventid int primary key,
eventname varchar(20),
eventimage varbinary(max),
eventd bit not null default 0
)

select * from EventNames
select * from EventNames

insert into EventNames values(1,'BirthdayParty',00,0)

create trigger SoftDeleteevent ON  EventNames
  instead of delete
  as begin
  set nocount on;
  update  EventNames
  set  eventd= 1
  WHERE eventid IN (SELECT eventid  FROM deleted);
  END


create table birthdaytable(
id int primary key,
bdayuserid int references Usertable(TUserid),
bdayid int references EventNames(eventid),
bdaydecorations int references decorationtable(decorid),
bdaytheme int references themetable(themeid),
bdaychairs int,
bdaytables int,
bdayhallcapacity int,
bdaydate int references datetable(dateid),
bdaytime int references timetable(timeid),
bdaycakes int references caketable(cakeid),
bdaylocation  int references locationtable(locationid),
bdayeventcost bigint ,
bdaybeverages bit not null default 0
)

select * from birthdaytable
select * from babyshowertable


create table babyshowertable(
id int primary key,
babyshoweruserid int references Usertable(TUserid),
babyshowerid int references EventNames(eventid),
babyshowerdecorations int references decorationtable(decorid),
babyshowertheme int references themetable(themeid),
babyshowerchairs int,
babyshowertables int,
babyshowerhallcapacity int,
babyshowerdate int references datetable(dateid),
babyshowertime int references timetable(timeid),
babyshowercakes int references caketable(cakeid),
babyshowerlocation  int references locationtable(locationid),
babyshowereventcost bigint ,
babyshowerbeverages bit not null default 0
)

create table BachelorParty(
id int primary key,
bacheloruserid int references Usertable(TUserid),
bachelorid int references EventNames(eventid),
bachelordecorations int references decorationtable(decorid),
bachelortheme int references themetable(themeid),
bachelorchairs int,
bachelortables int,
bachelorhallcapacity int,
bachelordate int references datetable(dateid),
bachelortime int references timetable(timeid),
bachelorcakes int references caketable(cakeid),
bachelorlocation  int references locationtable(locationid),
bacheloreventcost bigint ,
bachelorbeverages bit not null default 0
)

create table Wedding(
id int primary key,
weddinguserid int references Usertable(TUserid),
weddingid int references EventNames(eventid),
weddingdecorations int references decorationtable(decorid),
weddingtheme int references themetable(themeid),
weddingchairs int,
weddingtables int,
weddinghallcapacity int,
weddingdate int references datetable(dateid),
weddingtime int references timetable(timeid),
weddingcakes int references caketable(cakeid),
weddinglocation  int references locationtable(locationid),
weddingeventcost bigint ,
weddingbeverages bit not null default 0,
weddingPhotography bit  not null default 0,
weddingStyling bit  not null default 0,
weddingHospitality bit  not null default 0,
)



create table Anniversary(
id int primary key,
anniuserid int references Usertable(TUserid),
anniid int references EventNames(eventid),
annidecorations int references decorationtable(decorid),
annitheme int references themetable(themeid),
annichairs int,
annitables int,
annihallcapacity int,
annidate int references datetable(dateid),
annitime int references timetable(timeid),
annicakes int references caketable(cakeid),
annilocation  int references locationtable(locationid),
annieventcost bigint ,
annibeverages bit not null default 0,
anniPhotography bit  not null default 0,
anniStyling bit  not null default 0,
anniHospitality bit  not null default 0,
)



create table Reunion(
id int primary key,
reunionuserid int references Usertable(TUserid),
reunionid int references EventNames(eventid),
reuniondecorations int references decorationtable(decorid),
reuniontheme int references themetable(themeid),
reunionchairs int,
reuniontables int,
reunionhallcapacity int,
reuniondate int references datetable(dateid),
reuniontime int references timetable(timeid),
reunioncakes int references caketable(cakeid),
reunionlocation  int references locationtable(locationid),
reunioneventcost bigint ,
reunionbeverages bit not null default 0,
reunionPhotography bit  not null default 0,
reunionStyling bit  not null default 0,
reunionHospitality bit  not null default 0,
)



--added

create table CocktailParty(
id int primary key,
cockuserid int references Usertable(TUserid),
cockid int references EventNames(eventid),
cockdecorations int references decorationtable(decorid),
cocktheme int references themetable(themeid),
cockchairs int,
cocktables int,
cockhallcapacity int,
cockdate int references datetable(dateid),
cocktime int references timetable(timeid),
cockcakes int references caketable(cakeid),
cocklocation  int references locationtable(locationid),
cockeventcost bigint ,
cockbeverages bit not null default 0,
)

delete from birthdaytable where id = 1
delete from birthdaytable where id = 2


create table AddtoCart(
id int primary key,
cartbday int references birthdaytable(id),
cartbaby int references babyshowertable(id),
cartbachelor int references BachelorParty(id),
cartwedding int references Wedding(id),
cartanni int references Anniversary(id),
cartreunion int references Reunion(id),
cartcocktail int references CocktailParty(id)
)


select * from CocktailParty
select * from birthdaytable
select * from BachelorParty
select * from Wedding
select * from Anniversary
select * from babyshowertable
select * from Reunion
select * from caketable




















select * from Roletable

insert into Roletable values(1,'Admin',0),(2,'User',0)


ALTER TABLE Employees
ADD Gender NVARCHAR(10); -- You can adjust the length as needed

-- Add a constraint to limit the allowed values to 'Female', 'Male', or 'Other'
ALTER TABLE Employees
ADD CONSTRAINT CHK_Gender CHECK (Gender IN ('Female', 'Male', 'Other'));
