
/* Database created */
create database MvcDatabase
use  MvcDatabase

/* Table created */
create table student 
(
 Sid int primary key,
 Sname varchar(20),
 Sstd varchar(10),
 Ssec char
)

/* Insertion created */

insert into student values(1,'Harita','XII','A'),(2,'Ranita','XII','B'),(3,'Harish','XII','C'),(4,'Yamini','XII','D')

/* Selection created */

select * from student
drop table student