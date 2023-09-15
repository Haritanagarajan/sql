create database EventManagement2

use EventManagement2

create table Roletable
(
  TRoleid int primary key,
  TRolename varchar(20),
  TRoleimage varbinary(max)
)


drop table Roletable



insert into Roletable values(1,'Admin',0),(2,'User',0)


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
  TDob date,
  LastLoginDate datetime,
  TProfile varbinary(max),
  TRoleid int references Roletable(TRoleid)
)

alter TABLE Usertable
ADD CONSTRAINT CHK_Gender CHECK (TGender IN ('Female', 'Male', 'Other'));

select * from Usertable

insert into Usertable values(1,'Pallavi','Pallavi@gmail.com','Pallavi@123','Pallavi@123',6382830515,'Female',21,'2002-03-30','2022-04-22 10:34:53.44',0,1)


CREATE  PROCEDURE [dbo].[Validate_User1]
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


--create table  datetable
--(
--dateid int primary key,
--datesavailable date,
--dated bit not null default 0
--)

--insert into datetable values(1,'2023-10-12',00)
--insert into datetable values(2,'2023-10-02',00)


--create trigger SoftDelete3 ON  datetable
--  instead of delete
--  as begin
--  set nocount on;
--  update  datetable
--  set  dated= 1
--  WHERE dateid IN (SELECT dateid  FROM deleted);
--  END


--create table timetable
--(
--timeid int primary key,
--timesavailable time,
--timed bit not null default 0
--)
--insert into timetable values(1,'12:00',00)
--insert into timetable values(2,'11:00',00)


--create trigger SoftDelete4 ON  timetable
--  instead of delete
--  as begin
--  set nocount on;
--  update  timetable
--  set  timed= 1
--  WHERE timeid IN (SELECT timeid  FROM deleted);
--  END


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
eventd bit not null default 0,
eventuserid int references Usertable(TUserid)
)


select * from EventNames

insert into EventNames values(1,'BirthdayParty',00,0,1)

drop table babyshowertable


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
bdaydatetime datetime,
bdaytime time,
bdaycakes int references caketable(cakeid),
bdaylocation  int references locationtable(locationid),
bdayeventcost bigint ,
bdaybeverages bit not null default 0
)

delete from birthdaytable where id = 3
delete from birthdaytable where id = 2
delete from birthdaytable where id = 1


select * from birthdaytable
insert into birthdaytable values(1,1,1,1,1,10,10,100,2,1,1,23,1000,0);
insert into birthdaytable values(2,1,1,1,1,10,10,100,2,2,1,23,1000,0);


create table babyshowertable(
id int primary key,
babyshoweruserid int references Usertable(TUserid),
babyshowerid int references EventNames(eventid),
babyshowerdecorations int references decorationtable(decorid),
babyshowertheme int references themetable(themeid),
babyshowerchairs int,
babyshowertables int,
babyshowerhallcapacity int,
babyshowerdatetime datetime,
babyshowertime time,
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
bachelordatetime datetime,
bachelortime time,
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
weddingdatetime datetime,
weddingtime time,
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
annidatetime datetime,
annitime time,
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
reuniondatetime datetime,
reuniontime time,
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
cockdatetime datetime,
cocktime time,
cockcakes int references caketable(cakeid),
cocklocation  int references locationtable(locationid),
cockeventcost bigint ,
cockbeverages bit not null default 0,
)



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
select * from Wedding
select * from Anniversary
select * from Reunion
select * from BachelorParty
select * from babyshowertable

delete from birthdaytable where id = 2
delete from Anniversary where id = 2
delete from Wedding where id = 2

select * from datetable
select * from  timetable

select * from decorationtable









ALTER TABLE Employees
ADD Gender NVARCHAR(10); -- You can adjust the length as needed

-- Add a constraint to limit the allowed values to 'Female', 'Male', or 'Other'
ALTER TABLE Employees
ADD CONSTRAINT CHK_Gender CHECK (Gender IN ('Female', 'Male', 'Other'));



CREATE PROCEDURE ReserveDateTime
    @chosenDate DATE,
    @chosenTime TIME
AS
BEGIN
    DECLARE @dateid INT
    DECLARE @timeid INT

    -- Get the dateid for the chosen date
    SELECT @dateid = dateid FROM datetable WHERE datesavailable = @chosenDate

    -- Get the timeid for the chosen time
    SELECT @timeid = timeid FROM timetable WHERE timesavailable = @chosenTime

    -- Check if both date and time are available
    IF @dateid IS NOT NULL AND @timeid IS NOT NULL
    BEGIN
        -- Check if the date and time are not already blocked
        IF (SELECT dated FROM datetable WHERE dateid = @dateid) = 0
           AND (SELECT timed FROM timetable WHERE timeid = @timeid) = 0
        BEGIN
            -- Block the date and time
            UPDATE datetable SET dated = 1 WHERE dateid = @dateid
            UPDATE timetable SET timed = 1 WHERE timeid = @timeid
            PRINT 'Reservation successful!'
        END
        ELSE
        BEGIN
            PRINT 'Date and time are already blocked.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Invalid date and time.'
    END
END




CREATE TRIGGER ReserveDateTimeTrigger
ON timetable
AFTER INSERT
AS
BEGIN
    DECLARE @chosenDate DATE
    DECLARE @chosenTime TIME

    -- Get the chosen date and time from the inserted row
    SELECT @chosenDate = inserted.datesavailable, @chosenTime = inserted.timesavailable
    FROM inserted

    -- Call the stored procedure to handle the reservation
    EXEC ReserveDateTime @chosenDate, @chosenTime
END



CREATE PROCEDURE InsertCocktailParty
    @cockuserId INT,
    @cockId INT,
    @cockDecorations INT,
    @cockTheme INT,
    @cockChairs INT,
    @cockTables INT,
    @cockHallCapacity INT,
    @cockDate INT,
    @cockTime INT,
    @cockCakes INT,
    @cockLocation INT,
    @cockEventCost BIGINT,
    @cockBeverages BIT
AS
BEGIN
    DECLARE @dateAvailable BIT
    DECLARE @timeAvailable BIT

    -- Check if the selected date is available
    SELECT @dateAvailable = dated FROM datetable WHERE dateid = @cockDate

    -- Check if the selected time is available
    SELECT @timeAvailable = timed FROM timetable WHERE timeid = @cockTime

    -- If both date and time are available, insert into CocktailParty
    IF @dateAvailable = 0 AND @timeAvailable = 0
    BEGIN
        INSERT INTO CocktailParty (
            cockuserid, 
            cockid, 
            cockdecorations, 
            cocktheme, 
            cockchairs, 
            cocktables, 
            cockhallcapacity, 
            cockdate, 
            cocktime, 
            cockcakes, 
            cocklocation, 
            cockeventcost, 
            cockbeverages
        )
        VALUES (
            @cockuserId, 
            @cockId, 
            @cockDecorations, 
            @cockTheme, 
            @cockChairs, 
            @cockTables, 
            @cockHallCapacity, 
            @cockDate, 
            @cockTime, 
            @cockCakes, 
            @cockLocation, 
            @cockEventCost, 
            @cockBeverages
        )

        -- Update the datetable and timetable to mark the date and time as reserved
        UPDATE datetable SET dated = 1 WHERE dateid = @cockDate
        UPDATE timetable SET timed = 1 WHERE timeid = @cockTime

        PRINT 'Cocktail party reservation successful!'
    END
    ELSE
    BEGIN
        PRINT 'Selected date and time are not available.'
    END
END


