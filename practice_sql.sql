
--create a database

create database practice

--There are many database how to use particular database command is

use practice_sql

--ddl and dml commands

--create table

create table car(
name varchar(20),
car_num varchar(30),
color varchar(20)
)

--inserting values

insert into car values('swift','1111','red',5),('honda','1112','red',6),('ford','1113','violet',4)

--retrieving values dql

select * from cars

--update dml

update car set car_num='1112' where name='swift'

--alter comand

alter table car add tire int

update car set tire=4

--truncate

truncate table car

--drop command

drop table car

--distinct 

select distinct car_num from car

--rename(temporary renaming)

select car_num as num,name as car_name from car

--renaming(permanently)

sp_rename 'car','cars'

--renaming database(permanently)

sp_renamedb 'practice','practice_sql'

--guid and newid()

DECLARE 
    @id_num UNIQUEIDENTIFIER;
SET @id_num = NEWID();
SELECT 
    @id_num AS GUID from cars;


--datatypes int,smallint,bigint,tinyint,char,nchar,varchar,nvarchar,time,date,datetime2(like getdate()),datetimeoffset,bit,decimal(digits,precision),numeric(same as decimal)

--schema creation and droping schema only after droping the table which is inside the schema

create schema practice_schema

create table practice_schema.schema_bike(
name varchar(20),
color varchar(20)
)

--retrieving values from table

select * from practice_schema.schema_bike

--only after droping table

drop table  practice_schema.schema_bike

--schema is deleted successfully

drop schema  practice_schema


--orderby

create table childerens(
name varchar(20),
standard varchar(20),
address varchar(20))

--inserting values

insert into childerens values('harita','8th','cbe'),('ranita','6th','chennai'),('harish','7th','pondi'),('vasanth','6th','pondi'),('shanthi','4th','cbe'),('rathinam','1st','chennai')

select * from childerens

select * from childerens order by address

select * from childerens order by address desc

--offset skips and fetch select particular number of rows starting from offset

select * from childerens order by name
select * from childerens order by name offset 2 rows fetch first 2 rows only

--top with ties

select top 3 with ties * from childerens order by name 

--between and not between

select * from childerens where standard between '7th' and '6th'

select * from childerens where standard not between '7th' and '6th'

--like _(for single character matching) %(for multiple character matching)

select * from childerens
select * from childerens where name like '_a%'--retrieves and checks from first whether the second letter is a
select * from childerens where name like '[a-z]%'--retrieves and checks from first whether the range matches between a to z
select * from childerens where name like '%a'--retrieves and checks from last whether the first letter is a

--in and not in

select * from childerens where name in ('harita')

select * from childerens where name not in ('harita')

--case sensitive records(table with lowercase name is defined if we retrieve with uppercase it returns nothing)

select * from childerens
select * from childerens where name='Ranita' collate SQL_Latin1_General_CP1_CS_AS;
select * from childerens where name='ranita' collate SQL_Latin1_General_CP1_CS_AS;

--schema rename(using transfer method) only after creating new schema name we can rename schema

create schema s1

create table s1.schema_rename(
id int identity(1,2)
)

select * from s2.schema_rename

create schema s2

alter schema s2 transfer s1.schema_rename

--computed column

select * from childerens

alter table childerens drop column add_stan

alter table childerens add add_stan as(address +' '+ standard) 

--identity columns



create table identity_example(
id int identity(1,1),
name varchar(20)
)

insert into identity_example(name) values('harita'),('ranita'),('sori'),('rondi'),('harish')

--identity on to use your own values

set identity_insert  identity_example on

insert into identity_example(id,name) values(77,'harita')

select * from identity_example

--identity on to use system  values again

set identity_insert  identity_example off

insert into identity_example(name) values('harita'),('ranita'),('sori'),('rondi'),('harish')

--Again to start from the first mentiones identity cycle

DBCC CHECKIDENT('identity_example', RESEED, 1)

--to check currently what identity it has been stopped

Select SCOPE_IDENTITY()

--synonyms

create schema s3

create table s3.synonym_example(
name varchar(20),
id int identity(1,1)
)

insert into s3.synonym_example(name) values('harita'),('ranita')

select * from s3.synonym_example

create synonym synon for s3.synonym_example

select * from synon

--primary key and foreign key constraint

--parent table

create table department(
dept_id int primary key,
dept_name varchar(20),
)

insert into department values(123,'testing'),(124,'designing'),(125,'fullstack'),(126,'developer'),(127,'web ui/ux')

select * from department

--child table

create table employee(
dept_idemp int references department(dept_id),
name varchar(20)
)

insert into employee values(124,'hari'),(123,'kavi'),(126,'savitha'),(127,'harish'),(125,'rani')

select * from employee

delete from department where dept_id=123--throws error

--referencial integrity constraints

--dropping foreign key constraint in employee table

alter table employee drop constraint [FK__employee__dept_i__5FB337D6]

--dropping foreign key constraint column in employee table

alter table employee drop column dept_idemp

--again adding both constraint and column for performing delete and update

alter table employee add dept_idemp int default 123 constraint FK_EMPLOYEE_DEPT_IDEMP foreign key(dept_idemp) references department(dept_id) on delete cascade on update set default

select * from department
select * from employee

update employee set dept_idemp=123 where name='hari'
update employee set dept_idemp=124 where name='kavi'
update employee set dept_idemp=125 where name='savitha'
update employee set dept_idemp=126 where name='harish'
update employee set dept_idemp=127 where name='rani'

--for delete cascade

delete from department where dept_id=123

--for update default

update department set dept_id=123 where dept_name='designing'

--set operations

select * from department
select * from employee

--union(combines one from first table and one from second table)

select dept_id,dept_name from department
union
select dept_idemp,name from employee

--union all(it executes department details first and then the employee table details)

select dept_id,dept_name from department
union all
select dept_idemp,name from employee

--except(except those details it prints)

select dept_id,dept_name from department 
except
select dept_idemp,name from employee where dept_idemp=127

--group by(group by can be used only with aggregte function)

select max(dept_idemp) as max_emp_id,name from employee group by name order by name

--grouping sets

SELECT COALESCE(name, 'All names') as name, SUM(dept_idemp) AS Totalempid
FROM employee   
GROUP BY GROUPING SETS  
(  
(name),
()
)   
ORDER BY name;  


--rollup and cube example

SELECT COALESCE(name, 'All names') as name, SUM(dept_idemp) AS Totalempid
FROM employee group by cube(name,dept_idemp) 


 CREATE TABLE employee1
  (
      id INT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      gender VARCHAR(50) NOT NULL,
      salary INT NOT NULL,
      department VARCHAR(50) NOT NULL
   )

   INSERT INTO employee1
  VALUES
  (1, 'David', 'Male', 5000, 'Sales'),
  (2, 'Jim', 'Female', 6000, 'HR'),
  (3, 'Kate', 'Female', 7500, 'IT'),
  (4, 'Will', 'Male', 6500, 'Marketing'),
  (5, 'Shane', 'Female', 5500, 'Finance'),
  (6, 'Shed', 'Male', 8000, 'Sales'),
  (7, 'Vik', 'Male', 7200, 'HR'),
  (8, 'Vince', 'Female', 6600, 'IT'),
  (9, 'Jane', 'Female', 5400, 'Marketing'),
  (10, 'Laura', 'Female', 6300, 'Finance'),
  (11, 'Mac', 'Male', 5700, 'Sales'),
  (12, 'Pat', 'Male', 7000, 'HR'),
  (13, 'Julie', 'Female', 7100, 'IT'),
  (14, 'Elice', 'Female', 6800,'Marketing'),
  (15, 'Wayne', 'Male', 5000, 'Finance')

   select * from employee1

   --roll up

 SELECT coalesce (department, 'All Departments') AS Department,coalesce (gender,'All Genders') AS Gender,
  sum(salary) as Salary_Sum
  FROM employee1
  GROUP BY ROLLUP (department,gender)

--cube

 SELECT coalesce (department, 'All Departments') AS Department,coalesce (gender,'All Genders') AS Gender,
  sum(salary) as Salary_Sum
  FROM employee1
  GROUP BY cube (department,gender) 

