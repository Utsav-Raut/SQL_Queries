-- FROM https://learnsql.com/blog/sql-window-functions-examples/


create table Employee(employee_id integer, full_name varchar(40), department varchar(20), salary decimal(10, 2));

insert into Employee values(100, 'Mary Johns', 'SALES', 1000.00);
insert into Employee values(101, 'Sean Moldy', 'IT', 1500.00);
insert into Employee values(102, 'Peter Dugan', 'SALES', 2000.00);
insert into Employee values(103, 'Lilian Penn', 'SALES', 1700.00);
insert into Employee values(104, 'Milton Kowarski', 'IT', 1800.00);
insert into Employee values(105, 'Mareen Bisset', 'ACCOUNTS', 1200.00);
insert into Employee values(106, 'Airton Graue', 'ACCOUNTS', 1100.00);

select * from Employee

-- Rank salaries within each department
select *, rank() over(partition by department order by salary) as sal_rnk
from Employee

-- let’s find out where each employee’s salary ranks in relation to the top salary of their department. 
-- This calls for a math expression, like: employee_salary / max_salary_in_depth
-- The next query will show all employees ordered by the above metric; 
-- the employees with the lowest salary (relative to their highest departmental salary) will be listed first

select *, cast(salary / Max(salary) over(partition by department order by salary desc) as decimal(16,2)) as salary_metric
from Employee
order by 5


--********************************************--
drop table Train_Sch;

create table Train_Sch(Train_Id integer, Station varchar(40), Train_Time datetime);

insert into Train_Sch values(110, 'San Francisco', '10:00:00');
insert into Train_Sch values(110, 'Redwood City', '10:54:00');
insert into Train_Sch values(110, 'Palo Alto', '11:02:00');
insert into Train_Sch values(110, 'San Jose', '12:35:00');
insert into Train_Sch values(120, 'San Francisco', '11:00:00');
insert into Train_Sch values(120, 'Redwood City', '');
insert into Train_Sch values(120, 'Palo Alto', '12:49:00');
insert into Train_Sch values(120, 'San Jose', '13:30:00');

select * from Train_Sch

select Train_id, Station, cast(Train_Time as time) as Station_Time,
		cast((lead(Train_Time, 1, Train_Time) over(partition by Train_Id order by Train_Time) - Train_Time) as time) as Time_To_Next_Stn
from Train_Sch