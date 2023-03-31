create database task13
use task13

--department table

create table department(
dept_name varchar(25) primary key,
building varchar(20),
budget numeric(18,2)
)

--course table

create table course(
class_id varchar(7) primary key,
name varchar(25),
dept_name varchar(25) references department(dept_name),
credits numeric(5),
description varchar(8000)
)



--requisite table

create table requisite(
class_id  varchar(7) references course(class_id ),
req_id int primary key,
type varchar(4)
)

-- table time_slot

create table time_slot
(
time_slot_id int primary key,
days varchar(8),
start_time TIME(4),
end_time TIME(4)
)
--section table

create table section(
class_id varchar(7) references course(class_id),
class_num int primary key,
semester varchar(7),
year int,
room_no varchar(6),
time_slot_id int references time_slot(time_slot_id),
capacity int

)

--user table

create table _user(
user_id int primary key,
username varchar(16) unique ,
password varchar(40)
)

--teaches table

create table teaches(
user_id int references _user(user_id),
class_id varchar(7) references course(class_id),
class_num int references section(class_num) ,
semester varchar(7),
year int
)

--user salary table

create table user_salary(
user_id int references _user(user_id),
salary numeric(18,2)
)

--userbalance table

create table user_balance(
user_id int references _user(user_id),
balance numeric(18,2)
)

--role table

create table _role(
role_id int primary key,
role_name varchar(3) ,
role_full_name varchar(15)
)

--user role table 

create table user_role(
user_id int references _user(user_id),
role_id int references _role(role_id)
)



--user_number table
create table user_number(
user_id int references _user(user_id) ,
number numeric(15,0),
description varchar(15))

--user address table 


create table user_address(
user_id int references _user(user_id),
address varchar(80),
apt_num varchar(15),
city varchar(25),
state varchar(2),
zip numeric(5,0),
description varchar(15))




--takes table

create table takes(
user_id  int references _user(user_id), 
class_id varchar(7) references course(class_id ),
class_num int references section(class_num),
semester varchar(7),
year int,
grade varchar(2))


-- fineaid_main table

create table fineaid_main(
aid_id int primary key,
name varchar(50) unique ,
category varchar(15))

--user_fineaid_map

create table user_fineaid_map(
user_id  int  references _user(user_id) ,
aid_id int references fineaid_main(aid_id),
semester varchar(7),
year int,
offered numeric(18,2),
accepted numeric(18,2))

--user_email table

create table user_email(
user_id  int references _user(user_id),
email varchar(50) primary key,
description varchar(15))

--hold_main table

create table hold_main(
user_id  int references _user(user_id),
hold_id int primary key,
name varchar(25) unique,
description varchar(15)
)

--user_hold_map table

create table user_hold_map (
user_id  int  references _user(user_id),
hold_id int references hold_main(hold_id))


