create table salesman
(
	salesman_id int,
	name varchar(10),
	city varchar(10),
	commission int,
	primary key (salesman_id)
);
create table customer
(
	customer_id int,
	cust_name varchar(10),
	city varchar(10),
	grade int,
	salesman_id int,
	primary key (customer_id),
	foreign key (salesman_id) references salesman (salesman_id) on delete set NULL
);
create table orders
(
	ord_no int,
	purchase_amt int,
	ord_date date,
	customer_id int,
	salesman_id int,
	primary key (ord_no),
	foreign key (customer_id) references customer (customer_id) on delete cascade,
	foreign key (salesman_id) references salesman (salesman_id) on delete cascade
);

insert into salesman values (1000,'JOHN','mysore','13');
insert into salesman values (1001,'GANESH','bangalore','22');
insert into salesman values (1002,'SURESH','mumbai','16');
insert into salesman values (1003,'RAMESH','delhi','19');
insert into salesman values (1004,'SOMESH','hydrabad','23');
insert into salesman values (1005,'RAJESH','ranchi','23');

insert into customer values (1,'sharal','hydrabad',40,1004);
insert into customer values (2,'meenakshi','mangalore',40,1000);
insert into customer values (3,'vikky','mumbai',35,1002);
insert into customer values (4,'john','mumbai',20,1002);
insert into customer values (5,'george','bangalore',10,1001);
insert into customer values (6,'zyen','bangalore',50,1001);
insert into customer values (7,'roshan','delhi',45,1003);
insert into customer values (8,'vimala','chennai',35,1001);
insert into customer values (9,'nakul','ayodhya',15,1005);

insert into orders values(111,50000,'04-jan-17',1,1004);
insert into orders values(222,45000,'04-jan-17',2,1000);
insert into orders values(333,10000,'05-feb-17',3,1002);
insert into orders values(444,35000,'13-mar-17',4,1003);
insert into orders values(555,75000,'14-mar-17',5,1001);
insert into orders values(666,25000,'14-mar-17',6,1004);
insert into orders values(777,5000,'27-jun-17',7,1003);
insert into orders values(888,52000,'25-aug-17',8,1001);
insert into orders values(991,37000,'25-aug-17',1,1004);
insert into orders values(992,29000,'09-sep-17',2,1000);
insert into orders values(993,6000,'09-sep-17',9,1005);

select * from salesman;
select * from customer;
select * from orders;


--Query1
select grade,count(distinct customer_id) as total_customers
from customer
group by grade
having grade>(select avg(grade) from customer where city = 'bangalore');

--Query2
select s.salesman_id, s.name
from salesman s
where (select count (*) from customer c where c.salesman_id=s.salesman_id)>1;

--Query3
(select a.salesman_id, a.name, b.cust_name, a.commission, a.city from salesman a, customer b where a.city=b.city)
union
(select salesman_id, name,'no match', commission, city from salesman where not city = any (select city from customer))
order by 2 desc;

--Query4-1
create view topsalesman as select b.ord_date, b.purchase_amt, a.salesman_id, a.name 
from salesman a, orders b 
where a.salesman_id = b.salesman_id 
and b.purchase_amt = (select max(c.purchase_amt) from orders c where b.ord_date = c.ord_date);

--Query4-2
select * from topsalesman;

--Query5
delete from salesman where salesman_id=1000;




