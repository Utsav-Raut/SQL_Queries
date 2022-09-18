/*UNION and UNION ALL operators in SQL Server are used to combine the result set of two or more SELECT queries*/

create table tblIndiaCustomers(Id integer, [Name] varchar(30), Email varchar(20));
insert into tblIndiaCustomers values(1, 'Raj', 'R@R.com');
insert into tblIndiaCustomers values(2, 'Sam', 'S@S.com');

create table tblUKCustomers(Id integer, [Name] varchar(30), Email varchar(20));
insert into tblUKCustomers values(1, 'Ben', 'B@B.com');
insert into tblUKCustomers values(1, 'Sam', 'S@S.com');

-- Returns all 4 rows in an unsorted manner
select * from tblIndiaCustomers
UNION ALL
select * from tblUKCustomers;

-- Returns 3 rows (drops the duplicates) in sorted manner
select * from tblIndiaCustomers
UNION
select * from tblUKCustomers;

-- For Union and Union All to work, the number, data type and order of columns in the select statements
-- should be same

-- Diff between Union and Union All
-- Union removes duplicate rows where as Union All does not
-- Union has to perform distinct sort to remove the duplicates, which makes it slower than Union All.
-- Thus Union is a little slower than Union All, and is resource intensive.
-- We can check that by viewing the query execution plan (Ctrl-L)


-- ORDER BY clause should be used only on the last SELECT statement in the UNION query.

-- Diff between Union and Join
-- Union combines rows from 2 or more tables, whereas Joins combine columns from 2 or more tables.
-- Union combines the result set of two or more select queries into a single result-set which includes all 
-- the rows from all the queries in the union, whereas Joins retrieve data from two or more tables
-- based on the logical relationship between the tables.









