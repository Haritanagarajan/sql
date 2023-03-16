select * from Trainees


--table creation with constraints
create table task2(
id int primary key,
name varchar(20) not null ,
salary int check(salary>20000),
increment int unique 
)

--inserting values
insert into task2 values(1,'harita',25000,1000),(2,'hari',28000,8000),(3,'harsh',25800,1090),(4,'harish',25090,7000),(5,'hema',29000,1030)
select * from task2


--schema creation
create schema s1

--schema table creation
create table s1.t1
(
id int,
name varchar(20),
)

--renaming a table
exec sp_rename 's1.t1','tt1'

select * from s1.tt1

--creating new schema
CREATE SCHEMA s2

--rename schema
alter schema s2 transfer s1.tt1 


--identity an computed column

create table exp(
id int identity(1001,1),
name varchar(20) not null,
salary int not null,
increment int not null
)

--inserting values
insert into exp(name,salary,increment) values('hari',20000,300)
insert into exp(name,salary,increment) values('rani',2000,100)
insert into exp(name,salary,increment) values('srivanth',30000,1000)
select* from exp

-- adding computed column
alter table exp add revised_salary as (salary + ''+ increment) persisted

--retrieve salary >20000 and push into another table
select * into exp1 from exp where salary > 20000
select * from exp1
