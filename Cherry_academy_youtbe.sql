create table tblEmployee(EmpId integer, EmpName varchar(15), ManagerId integer, DeptId integer, Salary integer);

insert into tblEmployee values(1, 'Sachin', 3, 1, 6000);
insert into tblEmployee values(2, 'Rahul', 3, 1, 7000);
insert into tblEmployee values(3, 'Sourav', 5, 1, 10000);
insert into tblEmployee values(4, 'Kapil', 5, 1, 8000);
insert into tblEmployee values(5, 'Gavaskar', 0, 1, 9000);
insert into tblEmployee values(6, 'Mohit', 7, 2, 6000);
insert into tblEmployee values(7, 'Paras', 0, 2, 8000);
insert into tblEmployee values(8, 'Sourav', 5, 1, 10000);

select * from tblEmployee;

create table tblDepartment(DeptId integer, DeptName varchar(10))

insert into tblDepartment values(1, 'IT');
insert into tblDepartment values(2, 'Admin');

-- Find duplicate records in the table
select EmpName, Salary, count(*) as "cnt"
from tblEmployee
group by EmpName, Salary
having count(*) > 1


-- delete all duplicate records in a table
/*with cte as(
select EmpName, Salary, count(*) as cnt
from tblEmployee
group by EmpName, Salary
having count(*) > 1
) select * from cte */

-- OR
with cte as(
	select EmpName, Salary,
	Row_Number() over (
	partition by EmpName, Salary
	order by EmpName, Salary) as "row_num"
	from tblEmployee
) select * from cte where row_num > 1

-- CTE = common table expression (its basically a temp table)


-- Find the manager name for the employee where empId and managerId are in the same table
select emp.EmpId, emp.EmpName, man.EmpName
from tblEmployee emp
join tblEmployee man
on emp.ManagerId = man.EmpId


-- Find the second highest salary
select max(Salary) as sec_highest_sal
from tblEmployee
where Salary <(
select max(Salary)
from tblEmployee)


-- Find the employee with the second highest salary
select * from tblEmployee
where Salary in (select max(Salary) as sec_highest_sal
from tblEmployee
where Salary <(
select max(Salary)
from tblEmployee))


-- Find the 3rd and Nth highest salary
select min(Salary) from(
select distinct top 3 Salary
from tblEmployee
order by Salary desc) as innr_q

-- find the max salary from each dept
select * from tblEmployee
select * from tblDepartment


select dept.DeptName, max(emp.Salary) as max_sal
from tblEmployee emp
join tblDepartment dept
on emp.DeptId = dept.DeptId
group by dept.DeptName

-- alternative for TOP clause
-- select TOP 3 * from tblDepartment

set ROWCOUNT 3
select * from tblEmployee
set rowcount 0

-- show single or same row from a table twice in the results
select deptName from tblDepartment d where d.DeptName='IT'
union all
select deptName from tblDepartment d where d.DeptName='IT'

-- Find departments that have less than 3 employees
select d.deptName, e.deptId, count(*) as cnt
from tblDepartment d
join tblEmployee e
on e.DeptId = d.DeptId
group by d.deptName, e.DeptId
having count(*) < 3


-- cherry youtube vid

