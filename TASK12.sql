create database task12
use task12

--CREATE TABLE EMPLOYEE

create table employee(
id int primary key,
first_name varchar(255),
last_name varchar(255)
)

--CREATE TABLE CALL_OUTCOME

create table call_outcome(
id int primary key,
outcome_text char(128)
)

--CREATE TABLE COUNTRY

create table country(
id int primary key,
country_name char(128),
country_name_eng char(128),
country_code char(8)
)


--CREATE TABLE CITY referenced with county table

create table city(
id int primary key,
city_name char(128),
lat decimal(9,6),
long decimal(9,6),
country_id int references country(id)
)

--CREATE CUSTOMER TABLE referenced with city table

create table customer(
id int primary key,
customer_name varchar(255),
city_id int references city(id),
customer_address varchar(255),
next_call_date date,
ts_inserted datetime
)

--CREATE TABLE CALL references with employee id(employee) and customer id(customer) and call_outcome_id(call_outcome)

create table call(
id int primary key,
employee_id int references employee(id),
customer_id int references customer(id),
start_time datetime,
end_time datetime,
call_outcome_id int references call_outcome(id)
)