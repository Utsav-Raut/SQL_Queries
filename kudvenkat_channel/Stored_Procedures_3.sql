/* Whenever you execute a SP, it returns an integer status variable.
Usually a zero indicates success, and non-zero indicates failure.*/

create proc spGetTotalCount1
@TotalCount int OUTPUT
as 
begin
	select @TotalCount = count(Id) from tblEmployee
end;

declare @TotalEmployees int
exec spGetTotalCount1 @TotalCount = @TotalEmployees out
print @TotalEmployees


create proc spGetTotalCount2
as 
begin
	return(select count(Id) from tblEmployee)
end;

declare @TotalEmp int
exec @TotalEmp = spGetTotalCount2
select @TotalEmp

-- Example where we can use a output param but not a return statement
-- 1. Using output param
create proc spGetNameById
@Id int,
@Name varchar(20) output
as 
begin
	select @Name = Name from tblEmployee where Id = @Id
end;

declare @Name varchar(20)
exec spGetNameById 2, @Name out
select @Name


-- 2. Using return
create proc spGetNameById2
@Id int
as 
begin
	return(select Name from tblEmployee where Id = @Id)
end;

declare @Name varchar(20)
exec @Name = spGetNameById2 2
select @Name


-- RETURN VALUES SHOULD ALWAYS BE AN INTEGER, THAT TOO ONLY ONE VALUE.

/*
  Return Status Values				 |  Output Parameters
1. Only integer datatype			 |  Any datatype
2. Only one value					 |  More than one value
3. Used to convey success or failure | Use to return values like name, count, etc

*/

/*Advantages of SPs
1. Execution plan retention and reusability:
When we issue a query to SQL server, 3 things happen:
a) it checks the syntax of the query
b) it compiles the query
c) it generates an execution plan
An execution plan charts out, for a query to retrieve the data what is the best possible way available.This depends on the indexes available to help that query. 
Next time when the same query is executed, the execution plan stays cached by the server and hence the execution is faster.
SPs do this caching all the time and one of the reasons why sps are used so much.
However, in case of small change in a ad-hoc query, the execution plan has to be rebuilt which is time intensive. But in case of SPs that doesn't happen. By changing the parameter, the execution time still stays the same.

2. Reduce network traffic:
Just send the params and ask the sp to execute, and done!! no extra query need to be passed, the sp will execute on the server and return the result

3. Code reusability and better maintainability

4. Better security:
In terms of final grain control by restricting access to entire database tables (kind of what views can do)

5. Avoids sql injection attack

*/