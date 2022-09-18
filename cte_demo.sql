-- with clauses are also referred to as Common table expressions (CTE) and it is also referred to as sub-query factoring.

create table employee(emp_id integer, emp_name varchar(15), salary integer);

create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);

insert into employee values(101, 'Mohan', 40000);
insert into employee values(102, 'James', 50000);
insert into employee values(103, 'Robin', 60000);
insert into employee values(104, 'Carol', 70000);
insert into employee values(105, 'Alice', 80000);
insert into employee values(106, 'Jimmy', 90000);

select * from employee;

insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

-- fetch those employee who earn more than the average salary of all employees
select * from employee
where salary > (select avg(salary) from employee)

-- OR

with average_salary (avg_sal) as
	(select cast(avg(salary) as int) from employee)
select *
from employee e, average_salary av
where e.salary > av.avg_sal;

-- find the stores whose sales are better than the average sales across all stores

-- 1) total sales of each store -- total_sales
select store_id, 
sum(cost) as total_sales_per_store 
from sales group by store_id order by store_id

-- 2) find average sales wrt all the stores --avg_sales
select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_stores
from (select store_id, 
sum(cost) as total_sales_per_store 
from sales group by store_id) x

-- 3) find the stores where total_sales > avg_sales of all stores

select *
from (select store_id, 
		sum(cost) as total_sales_per_store 
		from sales group by store_id
	  ) total_sales
join (select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_stores
		from (select store_id, 
		sum(cost) as total_sales_per_store 
		from sales group by store_id) x
	  ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores

-- OR

with total_sales (store_id, total_sales_per_store) as
					(select store_id, 
						sum(cost) as total_sales_per_store 
						from sales group by store_id),
		avg_sales (avg_sales_for_all_stores) as
					(select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_stores
						from total_sales)		
select *
from total_sales ts
join avg_sales av
on ts.total_sales_per_store > av.avg_sales_for_all_stores

