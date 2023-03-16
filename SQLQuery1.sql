create database database1
use database1

create table student(
stu_name varchar(20),
stu_rollno int,
stu_group varchar(20),
stu_contact int
)
 insert into student values('vasanth',200,'csc',632383),('shanthi',300,'bio',638483),('rathinam',400,'bio',638253),('sri',500,'accounts',638273),('harira',600,'accounts',638983)
 select * from student
 update student set stu_group='accounts' where stu_rollno=300
