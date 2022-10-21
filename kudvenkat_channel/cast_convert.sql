/*To convert one data type to another, CAST and CONVERT functions can be used.
CAST(expression as data_type)[(length)]
CONVERT(data_type [(length)], expression [, style])
*/

create table tblEmployeesDOB(Id int, Name varchar(10), DateOfBirth datetime);
insert into tblEmployeesDOB values(1, 'Sam', '1980-12-30 00:00:00.000')
insert into tblEmployeesDOB values(2, 'Pam', '1982-09-01 12:02:36.260')
insert into tblEmployeesDOB values(3, 'John', '1985-08-22 12:03:30.370')
insert into tblEmployeesDOB values(4, 'Sara', '1979-11-29 12:59:30.670')


select * from tblEmployeesDOB

select Id, Name, DateOfBirth, cast(DateOfBirth as varchar) as ConvertedDOB from tblEmployeesDOB
-- OR (with optional length)
select Id, Name, DateOfBirth, cast(DateOfBirth as varchar(10)) as ConvertedDOB from tblEmployeesDOB -- length beside varchar is optional


select Id, Name, DateOfBirth, convert(varchar, DateOfBirth) as ConvertedDOB from tblEmployeesDOB

-- Getting only the DATE part

-- Some common date style provided in MSDN doc
/*
Style | DateFormat
101   | mm/dd/yyyy
102   | yy.mm.dd
103   | dd/mm/yyyy
104   | dd.mm.yy
105   | dd-mm-yy
*/

-- METHOD 1:

select Id, Name, DateOfBirth, convert(varchar, DateOfBirth, 103) as ConvertedDOB from tblEmployeesDOB


-- METHOD 2:

select Id, Name, DateOfBirth, cast(DateOfBirth as date) from tblEmployeesDOB

select Id, Name, DateOfBirth, convert(date, DateOfBirth) from tblEmployeesDOB


-- NOTE: To control the formatting of the Date part, DateTime has to be converted to varchar or nvarchar
-- using the styles provided. When converting to Date data type, the CONVERT() function will ignore the style parameter.

-- Concatenating String with Integer
select Id, Name, (Name + '-' + convert(varchar, Id)) as [Name-Id] from tblEmployeesDOB


-- FROM REGISTRATION TABLE, FIND THE TOTAL NUMBER OF REGISTRATIONS BY DATE
create table tblRegistration(Id int, Name varchar(10), Email varchar(20), RegisteredDate datetime);
insert into tblRegistration values(1, 'John', 'j@j.com', '2012-08-24 11:04:30.230')
insert into tblRegistration values(2, 'Sam', 's@s.com', '2012-08-25 14:04:29.780')
insert into tblRegistration values(3, 'Todd', 't@t.com', '2012-08-25 15:04:29.780')
insert into tblRegistration values(4, 'Mary', 'm@m.com', '2012-08-24 15:04:30.730')
insert into tblRegistration values(5, 'Sunil', 'sunil@s.com', '2012-08-24 15:05:30.330')
insert into tblRegistration values(6, 'Mike', 'mike@m.com', '2012-08-26 15:05:30.330')

select cast(RegisteredDate as date) as RegistrationDate, count(Id)
from tblRegistration
group by cast(RegisteredDate as date)


-- CAST() is ANSI standard and can be used across different databased, but CONVERT() is specific to sql-server.
-- CONVERT() is more flexible that CAST() as we saw above.
