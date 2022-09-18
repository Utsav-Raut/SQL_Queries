/* To create an SP with output parameters, we use the keyword OUT or OUTPUT.*/

create procedure spGetEmployeeCountByGender
@Gender varchar(10),
@EmployeeCount integer output
as 
begin
	select @EmployeeCount = count(Id)
	from tblEmployee
	where Gender = @Gender
end;

declare @EmployeeTotal int
exec spGetEmployeeCountByGender 'Male', @EmployeeTotal output
if(@EmployeeTotal is null)
	print '@EmployeeTotal is null'
else
	print 'Count of employees = ' + cast(@EmployeeTotal as varchar);


-- If we don't specify the OUTPUT keyword when executing a SP, the
-- @EmployeeTotal variable will be NULL.

-- Another of executing the above sp by specifying the variable names:
declare @EmployeeTotal int
exec spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal output, @Gender = 'Male'
print @EmployeeTotal


-- Useful system SP
/* sp_help procedure_name - To view the info about the sp, like parameter names, their datatypes, etc.
	sp_help can be used with any database object like tables, views, SP's, triggers, etc.
	Alternatively you can also press Alt+F1 when the name of the object is highlighted.

sp_helptext procedure_name - View the text of the stored procedure

sp_depends procedure_name - view the dependencies of the sp.
This system SP is very useful, especially if you want to check if there are any sps that are referencing a table 
that you are about to drop. sp_depends can also be used with other db objects like table, etc.
*/

sp_help  tblEmployee;

sp_depends spGetEmployeeCountByGender;
sp_depends tblEmployee;
