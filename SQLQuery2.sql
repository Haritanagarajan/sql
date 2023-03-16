CREATE TABLE Trainees (
Trainee_ID INT PRIMARY KEY,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY INT,
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
)

insert into Trainees values(101,'harita','nagarajan',20000,2023-03-30,'front-end')
insert into Trainees values(102,'ranita','nagarajan',30000,2023-03-31,'back-end'),(103,'hari','naga',40000,2023-04-30,'front-end'),(104,'rani','krishan',25000,2023-05-30,'back-end'),(105,'soroj','n',40000,2022-03-30,'back-end'),(106,'srivanth','nagarajan',67000,2022-04-30,'dataanalyst'),(107,'ranjith','kamal',30000,2023-03-30,'designer'),(108,'kamal','n',50000,2021-03-30,'front-end'),(109,'jai','ram',30000,2023-03-30,'front-end'),(110,'kavitha','nagarajan',90000,2021-07-30,'front-end'),(111,'usha','kumar',20000,2023-07-30,'back-end'),(112,'raja','rani',20000,2023-08-30,'designer'),(113,'snega','p',90000,2023-08-30,'front-end'),(114,'harish','kalyn',70000,2022-09-10,'front-end'),(115,'bharathi','kannama',10000,2023-06-30,'back-end'),(116,'karthika','manoj',20000,2020-03-30,'back-end'),(117,'guru','krish',20000,2023-04-30,'designer'),(118,'angel','raj',60000,2020-09-30,'back-end'),(119,'kannu','kanmani',50000,2023-06-30,'front-end'),(120,'sara','mohan',20000,2023-03-30,'front-end')
select * from Trainees
select * from Trainees where FIRST_NAME LIKE '[J-T]%'
select * from Trainees where SALARY>=20000 and SALARY<=50000
select * from Trainees where FIRST_NAME like '%i'
select distinct SALARY from Trainees
select * from Trainees where DEPARTMENT='designer' or DEPARTMENT='front-end'
select * from Trainees where Trainee_ID<105
select * from Trainees order by Trainee_ID offset 5 rows fetch next 10 rows only
select  top 5 with ties * from Trainees order by Trainee_ID
select * from Trainees order by  DEPARTMENT desc
select * from Trainees where LAST_NAME like '__i%'