drop table tblEmployee;
drop table tblDepartment;

create table tblEmployee(Id integer, Name varchar(15), Gender varchar(15), DepartmentId integer);
insert into tblEmployee values(1, 'John', 'Male', 3);
insert into tblEmployee values(2, 'Mike', 'Male', 2);
insert into tblEmployee values(3, 'Pam', 'Female', 1);
insert into tblEmployee values(4, 'Todd', 'Male', 4);
insert into tblEmployee values(5, 'Sara', 'Female', 1);
insert into tblEmployee values(6, 'Ben', 'Male', 3);

create table tblDepartment(DeptId integer, DeptName varchar(10));
insert into tblDepartment values(1, 'IT');
insert into tblDepartment values(2, 'Payroll');
insert into tblDepartment values(3, 'HR');
insert into tblDepartment values(4, 'Admin');

-- Problem Statement: To print the below
--DeptName | TotalEmployees
--IT       |    2
--HR       |    2

select * from tblEmployee
select * from tblDepartment
-- VIEWS
/*Views get saved in the database, and is available to other queries and stored procedures.
However, if this view is only at one place, it can be easily eliminated using other options, 
like CTE, Derived Tables, Temp Tables and Temp Variables, etc.*/

create view vwEmployeeCount
as
select DeptName, DeptId, count(*) as 'TotalEmployees'
from tblDepartment dept
join tblEmployee emp
on dept.DeptId = emp.DepartmentId
group by DeptName, DeptId;

select DeptName, TotalEmployees
from vwEmployeeCount
where TotalEmployees >= 2;

-- Temp Tables
/* Temporary tables are stored in tempdb. Local temprary tables are visible only in the current session,
and can be shared between nested stored procedure calls. Global temporary tables are visible to other sessions
and are destroyed, when the last connection referencing the table is closed.*/
select DeptName, DeptId, count(*) as 'TotalEmployees'
into #tempEmployeeCount
from tblDepartment dept
join tblEmployee emp
on dept.DeptId = emp.DepartmentId
group by DeptName, DeptId;

select DeptName, TotalEmployees
from #tempEmployeeCount
where TotalEmployees >= 2;


-- TABLE VARIABLE
-- For using temp tables, we need not provide the table structure.
-- But for using table variables, we need to provide the table structure explicitly.
-- Just like temp tables, a temp variable is also created in tempdb. The scope of a table variable
-- is the batch, stored procedure, or statement block in which it is declared. They can be passed
-- as parameters between procedures.

declare @tblEmployeeCount table(DeptName varchar(15), DeptId integer, TotalEmployees int);

insert @tblEmployeeCount
select DeptName, DeptId, count(*) as 'TotalEmployees'
from tblDepartment dept
join tblEmployee emp
on dept.DeptId = emp.DepartmentId
group by DeptName, DeptId;

select DeptName, TotalEmployees
from @tblEmployeeCount
where TotalEmployees >= 2;

-- RUN THE ABOVE SELECT CLAUSE ALONG WITH THE DECLARE AND INSERT COMMANDS, OR ELSE IT WILL THROW AN ERROR.
-- Both temp variable and temp tables are created in tempdb, not in memory.


-- DERIVED TABLES

select DeptName, TotalEmployees
from (
		select DeptName, DeptId, count(*) as 'TotalEmployees'
		from tblDepartment dept
		join tblEmployee emp
		on dept.DeptId = emp.DepartmentId
		group by DeptName, DeptId
	) as EmployeeCount
where EmployeeCount.TotalEmployees >= 2;




-- CTE (Common Table Expression)

-- it is a temporary result set that is defined within execution scope of a single select, insert, update
-- delete, or create view statement.
-- It is similar to derived table in that it is not stored as an object and lasts only for the duration
-- of the query.

with EmployeeCount(DeptName, DeptId, TotalEmployees)
as
(
	select DeptName, DeptId, count(*) as 'TotalEmployees'
	from tblDepartment dept
	join tblEmployee emp
	on dept.DeptId = emp.DepartmentId
	group by DeptName, DeptId
)
select DeptName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2;