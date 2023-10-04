
create database VehicleManagement
use VehicleManagement



create table VRoles
(
  VRoleid int primary key,
  VRolename varchar(20),
)

select * from VRoles

insert into VRoles values(1,'Owner'),(2,'Customer')

update VRoles set VRolename='Admin' where VRoleid = 1

---------------------------------------------------------------------
create table VUsers
(
  VUserid int identity(1,1) primary key,
  VUsername varchar(30),
  VEmail varchar(90),
  VPassword varchar(200),
  VConfirmPassword varchar(200),
  VMobile bigint,
  VCreated date,
  VLastLoginDate datetime,
  VRoleid int references VRoles(VRoleid)
)

update VUsers set VRoleid=1 where VUserid=11



Create trigger EncryptionPassword on VUsers
after insert
as begin
update VUsers set VPassword = ENCRYPTBYPASSPHRASE('VehicleManagement',inserted.VPassword) from inserted where VUsers.VUserid=inserted.VUserid
update VUsers set VConfirmPassword = ENCRYPTBYPASSPHRASE('VehicleManagement',inserted.VConfirmPassword) from inserted where VUsers.VUserid=inserted.VUserid
end;


update VUsers set VPassword=ENCRYPTBYPASSPHRASE('VehicleManagement',VPassword) where VUserid>0
update VUsers set VConfirmPassword=ENCRYPTBYPASSPHRASE('VehicleManagement',VConfirmPassword) where VUserid>0


select * from VUsers

insert into VUsers values ('Harita','30harita2002@gmail.com','Harita@123','Harita@123',6382830515,'2023-09-26','2023-09-26 00:00:00',2)


exec Validate_Users 'Harita','Harita@123'

CREATE OR ALTER  PROCEDURE [dbo].[Validate_Users]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserId INT, @LastLoginDate DATETIME, @RoleId INT
	
	SELECT @UserId = VUserid, @LastLoginDate = VLastLoginDate, @RoleId = VRoleid 
	FROM VUsers WHERE VUsername = @Username AND Convert(varchar(200),DECRYPTBYPASSPHRASE('VehicleManagement',VUsers.VPassword)) = @Password
	
	IF @UserId IS NOT NULL
	BEGIN
		BEGIN
			UPDATE  VUsers
			SET VLastLoginDate =  GETDATE()
			WHERE VUserid = @UserId
			
			SELECT @UserId [VUserid], 
					(SELECT  VRolename FROM VRoles
					 WHERE VRoleid = @RoleId) [Roles] -- User Valid
		END
	END
	ELSE
	BEGIN
		SELECT -1 [VUserId], '' [Roles] -- User invalid.
	END
END

----------------------------------------------------------------------------------------------


CREATE TABLE CarBrand
(
Brandid int identity(1,1) primary key,
BrandName varchar(60),
BranndImage varbinary(max)
)


select * from CarBrand

delete from CarBrand where Brandid = 15

insert into CarBrand values('Maruthi Suzuki','E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement\Files'),('Hyundai','E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement'),('Volkswagen','E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement'),('Lamborghini','E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement')

update table CarBrand alter column BranndImage varchar(max)

update CarBrand set BranndImage='E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement\wwwroot\Assets' where Brandid = 7
update CarBrand set BranndImage='E:\ASP_CORE_REACT\VehicleManagement\VehicleManagement\wwwroot\Assets' where Brandid = 8


----------------------------------------------------------------------------------------
CREATE TABLE BrandCars
(
Carid int identity(1,1) primary key,
Brandid int references CarBrand(Brandid),
CarName varchar(100),
AddAmount smallmoney,
CarImage varbinary(max)
)

alter table BrandCars alter column CarImage varchar(max)

insert into BrandCars values(1,'Swift',3000,0),(1,'Swift Dezire',3500,0),(1,'Alto 800',2000,0),(1,'SX4',4000,0)

insert into BrandCars values(2,'i20',4000,0),(2,'Verna',4500,0),(2,'Santro',2500,0),(2,'Sonota',4200,0)

insert into BrandCars values(3,'Polo',4200,0),(3,'Vento',4500,0),(3,'Jetta',2900,0),(3,'Ameo',4000,0)

insert into BrandCars values(4,'Tiago',3200,0),(4,'Nexon',4500,0),(4,'Indica',3000,0),(4,'Zest',4000,0)

select * from BrandCars
------------------------------------------------------------------------------
CREATE TABLE CarFuel
(
Fuelid int identity(1,1) primary key,
FuelName varchar(60),
FuelImage varbinary(max)
)


alter table CarFuel alter column FuelImage varchar(max)

select * from CarFuel

insert into CarFuel values('Petrol',0),('Diesel',0)

----------------------------------------------------------------------------
CREATE TABLE CarServices
(
Serviceid int identity(1,1) primary key,
Carid int references BrandCars(Carid),
ServiceName varchar(max),
Warranty varchar(max),
Subservice1  varchar(max),
Subservice2  varchar(max),
Subservice3  varchar(max),
Subservice4  varchar(max),
TimeTaken smallint,
Servicecost smallmoney
)

select * from CarServices

insert into CarServices values(11,'Basic Service','1000 kms or 1 Month Wrranty','WiperFluid Replacement','Car Wash','Engine Oil Replacement','Battery Water Top Up',4,2000)
insert into CarServices values(11,'Standard Service','1000 kms or 1 Month Wrranty','Car Scanning','Interior Vaccuming(Carpet & Seats)','Car Wash','Battery Water Top Up',6,2500)
insert into CarServices values(11,'Comprehensive Service','1000 kms or 1 Month Wrranty','Car Scanning','AC Filter Replacement','Fuel Filter Checking','Battery Water Top Up',8,3500)
insert into CarServices values(11,'Caliper Pin Replacement','Recommended:In case of Noise coming from Brakes','Caliper Assembly Cost Additional','Caliper Pin Replacement(OES)','Opening & Filtering Caliper Pin','Battery Water Top Up',5,2000)


-----------------------------------------------------------------------------------
CREATE TABLE CarDetails
(
DetailsId int identity(1,1) primary key,
VUserid int references VUsers(VUserid),
VUserName varchar(max),
Brandid int references CarBrand(Brandid),
BrandImage varchar(max),
Carid int references BrandCars(Carid),
CarImage varchar(max),
Fuelid int references CarFuel(Fuelid),
FuelImage varchar(max),
Serviceid int references CarServices(Serviceid),
CreatedDate datetime,
DueDate datetime
)

drop table CarDetails

delete from CarDetails   where DetailsId =26

select * from  CarDetails

alter table CarDetails  add  Email varchar(100)