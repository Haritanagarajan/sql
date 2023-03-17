use db1
--NORMALIZATION

--TABLE CREATION 1

create table department(
deptid int primary key,
deptname varchar(20) not null

)


--INSERT VALUES

insert into department values(100,'developer')
insert into department values(101,'ui/ux')

--RETRIEVING ALL VALUES FROM PARENT TABLE

select * from department

--TABLE CREATION 2

create table addresss(
address_id int primary key ,
city varchar(20) ,
state varchar(15) ,
pincode decimal 
)

--INSERT VALUES

insert into addresss values(1,'manford','oklahomal(ok)',74044)
insert into addresss values(2,'sidney','ohio(oh)',78944)

--RETIEVE VALUES

select * from addresss

--CREATE PARENT TABLE

create table employee(
id int primary key,
desig varchar(20) default 'trainee',
deptid int references department(deptid),
mobile1 decimal,
mobile2 decimal,
street_add varchar(20),
address_id int references addresss(address_id)
)

--INSERT VALUES

insert into employee values(1,'developer',100,687861246,1234567891,'234 hinton road',1),
insert into employee(id,desig,deptid,mobile1,street_add,address_id) values(4,'designer',101,687861290,'237 hinton road',2),
insert into employee values(3,'developer',100,687891246,1284567891,'236 hinton road',1)

--RETRIEVING DATA FROM EMPLOYEE TABLE

select * from employee

--REFERENCIAL INTEGRITY FOR CASCADING DEL AND UPDATE

alter table employee add constraint FK_employee_deptid foreign key(deptid) references department(deptid) on delete cascade on update cascade

--REFERENCIAL INTEGRITY FOR CASCADING DEL SET DEFAULT AND UPDATE

delete from department where deptid=101

update Department set deptid=101 where deptid=100

select * from employee

select * from department

select * from addresss