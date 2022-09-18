use PHYSICAL_JOINS;

create table Customers(Cust_Id int, Cust_Name varchar(10));

insert into Customers values(1, 'Craig');
insert into Customers values(2, 'John Doe');
insert into Customers values(3, 'Jane Doe');

select * from Customers;

create table Sales(Cust_Id int, Item varchar(10));

insert into Sales values(2, 'Camera');
insert into Sales values(3, 'Computer');
insert into Sales values(3, 'Monitor');
insert into Sales values(4, 'Printer');

select * from Sales;

select * from Sales s
inner join Customers c
on s.Cust_Id = c.Cust_Id
option(hash join);