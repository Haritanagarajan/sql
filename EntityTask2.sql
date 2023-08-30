use MvcDatabase

/*Training*/
create table Training
(
Did int primary key,
Dname varchar(20)
)

insert into Training values (189,'Dotnet'),(120,'React JS'),(180,'Angular JS'),(170,'Node JS'),(130,'PHP')

select * from Training

 ALTER TABLE Training ADD IsDeleted BIT NOT NULL DEFAULT 0;


  create trigger SoftDelete1 ON Training
  instead of delete
  as begin
  set nocount on;
  update Training
  set IsDeleted= 1
  WHERE Did IN (SELECT Did FROM deleted);
  END


/*Trainee*/
create table Trainee
(
Tid int primary key,
Tname varchar(20),
TDomainid int references Training(Did),
Tprofile varbinary (max)
)

insert into Trainee values (1,'Harita',189,0),(2,'Ranita',120,1),(3,'Harishmitha',180,0),(4,'Yamini',170,0000111),(5,'Vasanth',130,1)

select * from Trainee
select * from Training

 
  alter table Trainee drop column No

--ON DELETE CASCADE --ON UPDATE SET DEFAULT


ALTER TABLE Trainee DROP CONSTRAINT [FK__Trainee__TDomain__1332DBDC]
ALTER TABLE Trainee DROP COLUMN TDomainid 


ALTER TABLE Trainee ADD TDomainid INT DEFAULT 120 CONSTRAINT FK_Trainee_TDomainid FOREIGN KEY(TDomainid) REFERENCES Training(Did) ON DELETE CASCADE ON UPDATE SET DEFAULT

DELETE FROM Training WHERE Did=180

select * from Trainee
select * from Training

delete from Training where Did=6

update Training set Did=173 where Did=189

insert into Trainee values (6,'Hari',0,0,103)

update Trainee set TDomainid=130 where Tid=1
update Trainee set TDomainid=120 where Tid=2
update Trainee set TDomainid=170 where Tid=3
update Trainee set TDomainid=189 where Tid=4
update Trainee set TDomainid=180 where Tid=5


/*User Table*/

create table UserAuth
(
UserId int primary key,
UserName varchar(20) ,
UserRole varchar(20)
)


insert into UserAuth values(1,'Dora','User'),(2,'Hatori','Admin')

select * from UserAuth

/*Role Table*/

create table RoleTable
(
  TRoleid int primary key,
  TRolename varchar(20),
)

insert into RoleTable values(1,'User'),(2,'Admin')

select * from RoleTable

/*User Table for role auth*/

create table UserTable
(
  TUserid int primary key,
  TUsername varchar(20),
  TRoleid int references RoleTable(TRoleid)
)

alter table UserTable add  TPassword varchar(20)

update UserTable set TPassword = 'user@123.com' where TRoleid=1
update UserTable set TPassword = 'admin@123.com' where TRoleid=2


insert into UserTable values(11,'Harita',1),(12,'Vasanth',2)

select * from RoleTable
select * from UserTable


/***** Object:  StoredProcedure [dbo].[Validate_User]    Script Date: 30-08-2023 16:45:17 *****/CREATE  PROCEDURE [dbo].[Validate_User]	@Username NVARCHAR(20),	@Password NVARCHAR(20)ASBEGIN	SET NOCOUNT ON;	DECLARE @UserId INT,  @RoleId INT		SELECT @UserId = TUserid,@RoleId = TRoleid 	FROM UserTable WHERE TUsername = @Username AND [TPassword] = @Password		IF @UserId IS NOT NULL	BEGIN		IF NOT EXISTS(SELECT TUserid FROM UserTable WHERE TUserid = @UserId)		BEGIN									SELECT @UserId [TUserid], 					(SELECT TRolename FROM RoleTable					 WHERE TRoleid = @RoleId) [Roles] -- User Valid		END		ELSE		BEGIN			SELECT -2 [TUserid], '' [Roles]-- User not activated.		END	END	ELSE	BEGIN		SELECT -1 [TUserid], '' [Roles] -- User invalid.	ENDEND