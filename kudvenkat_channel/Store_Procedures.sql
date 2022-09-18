/*A stored procedure is a group of T-SQL (Transact SQL) statements.
If you have a situation, where you write the same query over and over again, you 
can save the specific query as a stored procedure and call it just by its name.
*/
select * from tblEmployee;

create procedure spGetEmployees
as
begin
	select Name, Gender from tblEmployee
end;

spGetEmployees;
-- Or, exec stored_procedure_name
-- Or, execute stored_procedure_name


-- Using Parameters:
create proc spGetEmployeesByGenderAndDept
@Gender varchar(20),
@DeptId int
as
begin
	select Name, Gender, DepartmentId from tblEmployee where Gender = @Gender
	and DepartmentId = @DeptId
end;

exec spGetEmployeesByGenderAndDept 'Female', 1;
-- OR
spGetEmployeesByGenderAndDept @DeptId = 1, @Gender = 'Female';


-- To view the definition of a stored procedure
sp_helptext spGetEmployeesByGenderAndDept;

-- System defined stored procedures starts with 'sp_', and so MSDN recommends not to create user
-- defined stored procedures starting with 'sp_'.

-- Altering a SP
alter procedure spGetEmployees
as 
begin
	select Name, Gender from tblEmployee order by Name
end;

spGetEmployees;

-- To drop procs
drop proc spGetEmployees;



-- Encrypting content/text of sp
alter proc spGetEmployeesByGenderAndDept
@Gender varchar(20),
@DeptId int
with encryption
as
begin
	select Name, Gender, DepartmentId from tblEmployee where Gender = @Gender
	and DepartmentId = @DeptId
end;

sp_helptext spGetEmployeesByGenderAndDept;

-- Now we cannot see the content/view of the sp. We can delete it though.

