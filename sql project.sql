create database SQL_Project;
show databases;
use SQL_Project;
create table regions(region_id int primary key,region_name varchar(9));

insert into regions values('1','Mumbai'),('2','Delhi'),('3','Bihar'),('4','Pune'),('5','Goa');
select * from regions;

create table customer_nodes( customer_id int primary key ,region_id int ,nodes_id int,start_date date, end_date date,foreign key(region_id)references regions(region_id));
select * from customer_nodes;
desc customer_nodes;

insert into customer_nodes values('1','3','4','2020-01-02','2020-01-03'),
('2','3','5','2020-01-03','2020-01-03'),
('3','5','4','2020-01-27','2020-01-03'),
('4','5','4','2020-01-07','2020-01-03'),
('5','4','3','2020-01-15','2020-01-03'),
('6','4','1','2020-01-11','2020-01-03'),
('7','4','5','2020-01-20','2020-01-03'),
('8','3','2','2020-01-15','2020-01-03'),
('9','1','5','2020-01-21','2020-01-03'),
('10','2','4','2020-01-13','2020-01-03'),
('11','2','5','2020-01-19','2020-01-03'),
('12','1','2','2020-01-13','2020-01-03'),
('13','5','3','2020-01-02','2020-01-03'),
('14','1','2','2020-01-25','2020-01-03'),
('15','2','5','2020-01-25','2020-01-03'),
('16','5','3','2020-01-13','2020-01-03');

select * from customer_nodes;

create table customer_transactions( customer_id int,txn_date date,txn_type varchar(10),txn_amount int, foreign key (customer_id) references customer_nodes(customer_id));
desc customer_transactions;
insert into customer_transactions values('1','2020-01-21','deposit','82'),
('2','2020-03-07','purchase','717'),
('3','2020-04-05','withdrawal','494'),
('4','2020-03-24','deposite','532'),
('5','2020-02-22','purchase','222'),
('6','2020-03-18','withdrawal','794'),
('7','2020-01-12','deposite','892'),
('8','2020-04-21','purchase','498'),
('9','2020-05-05','withdrawal','550'),
('10','2020-07-01','deposite','270'),
('11','2020-06-19','purchase','220'),
('12','2020-10-18','withdrawal','594'),
('13','2020-11-16','deposite','632'),
('14','2020-04-29','purchase','218'),
('15','2020-05-25','withdrawal','350'),
('16','2020-01-15','deposite','792');


show tables;
desc customer_nodes;
select * from customer_transactions;


select txn_date, txn_type from customer_transactions;
select customer_id,region_id from customer_nodes;
select region_id,region_name from regions;

select * from customer_transactions where customer_id=5;
select * from customer_nodes where customer_id=5;
select * from regions where region_id=4;

select txn_type,txn_amount from customer_transactions where customer_id=1;
select start_date,end_date from customer_nodes where customer_id=6;
select region_id, region_name from regions where region_id=3;

select * from customer_transactions where txn_amount<500;
select * from customer_transactions where txn_amount>500;

select * from customer_transactions where  txn_amount Between 300 and 600;

select * from customer_transactions where  customer_id=1 or customer_id=2;
  #--- by using or operater--
  select * from customer_transactions where customer_id in(1,2);

select region_name from regions;

 # using distinct show unique addresses
select distinct region_name from regions;

 # The name of the cities whos name end with "i"
select distinct region_name from regions where region_name like"%i";

# The name of the cities whos name start with "m"
select distinct region_name from regions where region_name like"m%";

 # The name of the cities whos name Goa
select distinct region_name from regions where region_name like"G%a";

 # The name of the cities whos name Delhi with 5 (_ _ _ _ _ ) char only
select distinct region_name from regions where region_name like"____i";

# The name of the cities whos 2nd letter "u"
select distinct region_name from regions where region_name like"%u%";
                    # ---or----
select distinct region_name from regions where region_name like"_u%";

# Order By used to sort amount in assending order
select customer_id, txn_amount from customer_transactions order by txn_amount;

# desc used to sort marks in decending order
select customer_id, txn_amount from customer_transactions order by txn_amount desc;

# higest amount of customer information used "limit"
select * from customer_transactions order by txn_amount desc limit 1;

# higest amount of top 3 customer used "limit"
select txn_amount from customer_transactions order by txn_amount desc limit 3;

 # infromation of all the student of marks is null
select * from customer_transactions where txn_amount is null; 
# so we have no null values in table

# infromation of all the customers whos amount is not null
select * from customer_transactions where txn_amount is not null;

# infromation of all the customers whos amount is not null and least marks
select * from customer_transactions where txn_amount is not null order by txn_amount limit 1;

# find the length of the region_name
select region_name, length(region_name) as len from regions;

select * from regions group by region_name;

#join = crossproduct +some condition

select regions.region_id,regions.region_name,
customer_nodes.customer_id,customer_nodes.region_id,customer_nodes.nodes_id,customer_nodes.start_date,customer_nodes.end_date,
customer_transactions.customer_id,customer_transactions.txn_date,customer_transactions.txn_type,customer_transactions.txn_amount
from regions,customer_nodes,customer_transactions;

select regions.region_id,regions.region_name,
customer_transactions.customer_id,customer_transactions.txn_date,customer_transactions.txn_type,customer_transactions.txn_amount
from regions cross join customer_transactions;

select regions.region_id,regions.region_name,
customer_transactions.customer_id,customer_transactions.txn_date,customer_transactions.txn_type,customer_transactions.txn_amount
from regions natural join customer_transactions;

select regions.region_id,regions.region_name,
customer_transactions.customer_id,customer_transactions.txn_date,customer_transactions.txn_type,customer_transactions.txn_amount
from regions left outer join customer_transactions
on regions.region_id=customer_transactions.customer_id;
                     
select regions.region_id,regions.region_name,
customer_transactions.customer_id,customer_transactions.txn_date,customer_transactions.txn_type,customer_transactions.txn_amount
from regions right outer join customer_transactions
on regions.region_id=customer_transactions.customer_id;

select * from customer_nodes
union all 
select * from customer_transactions;

# constrain,join,view,subqueries