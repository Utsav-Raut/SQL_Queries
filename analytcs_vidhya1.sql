create table customerorder(FirstName varchar(30), LastName varchar(30), Amount float, Date datetime, city varchar(20), Quantity integer, postalCode varchar(20))
truncate table customerorder

alter table customerorder
alter column Date smalldatetime;


select * from customerorder

insert into customerorder values('Raju', 'Malhotra', 120.50, '06/06/2020 09:10:55', 'Delhi', 1, '110078');
insert into customerorder values('Kaju', 'Srivastav', 285.00, '06/06/2020 11:21:32', 'Mumbai', 3, '400011');
insert into customerorder values('Vijay', 'Sinha', 835.43, '06/08/2020 18:12:15', 'Bengaluru', 4, '530068');
insert into customerorder values('Ajay', NULL, 643.62, '06/08/2020 18:12:15', NULL, NULL, '110033');
insert into customerorder values('Kriti', 'Banerjee', 1110.80, '06/09/2020 16:13:14', 'Kolkata', 1, '700032');
insert into customerorder values('Kanishka', 'Murthy', 750.50, '06/10/2020 10:13:39', 'Bhopal', 5, '462001');
insert into customerorder values('Bhavaya', 'Rao', 2180.75, '06/11/2020 14:29:09', 'Indore', 4, '452001');
insert into customerorder values('Shivani', NULL, 1182.35, '06/11/2020 20:09:50', 'Jaipur', 1, '302001');
insert into customerorder values('Vaishali', 'Singh', 1000.50, '06/12/2020 08:10:50', 'Delhi', 2, '110034');
insert into customerorder values('Shreya', 'Aggarwal', 1322.90, '06/13/2020 10:12:12', 'Mumbai', 3, '400033');

-- Aggregate functions:
-- count of cities
select count(city) as count_of_cities from customerorder;

-- distinct count of cities
select count(distinct city) as count_of_cities from customerorder;

-- the total sum of Amount is important to analyze the sales that occurred
select sum(Amount) from customerorder;

-- total amount for every city
select city, sum(Amount) from customerorder group by city order by city

-- since we have multiple orders from the same city, therefore, it would be more prudent to calculate the average amount rather than the total sum
select city, avg(Amount) as avg_amt_per_city from customerorder group by city order by city;

-- min and max on the amount column
select min(Amount) as min_amt, max(Amount) as max_amt from customerorder

-- find out the deviation of the amount for every record from the average amount from our table
select FirstName, city, abs(Amount - (select avg(Amount) from customerorder)) as dev_frm_avg from customerorder;

-- using ceil and floor functions
select FirstName, Amount, ceiling(Amount), floor(Amount) from customerorder

-- rounding off
select FirstName, Amount, round(Amount, 1) from customerorder

-- use modulo function to find those records which had an odd number of quantities
select FirstName, Quantity, Quantity%2 as mod_val from customerorder;

-- using lower and upper, concat
select FirstName, lower(FirstName), upper(FirstName), concat(FirstName, ' ', LastName) from customerorder

-- getting date and time from datetime columns
select FirstName, LastName, Date, cast(Date as date) dt, cast(Date as time) tm from customerorder

-- CHECK MORE SQL SERVER DATE AND TIME FUNCTIONS

-- WINDOW FUNCTIONS
-- While the regular aggregate functions group the rows into a single output value, window function does not do that. 
-- The window function works on a subset of rows but does not reduce the number of rows. 
-- The rows retain their individual identity

-- The OVER clause turns the simple aggregate function into a windows function. The syntax is simple and as follows:
-- window_function_name(<expression>) OVER ( <partition_clause> <order_clause>)

-- The part before the OVER clause is the aggregate function or a windows function.
-- The part after the OVER clause can be divided into two parts:
--		Partition_clause defines the partition between rows. The window function operates within each partition. The Partition by clause defines it.
--		Order_clause orders the rows within the partition. The Order by clause defines it.

-- sum as window func
select FirstName, city, Amount, sum(Amount) over(order by city) from customerorder

-- RANK
-- The simple window function is the rank() function. As the name suggests, it ranks the rows within a partition group based on a condition.
-- It has the following syntax: Rank() Over ( Partition by <expression> Order By <expression>)

-- Let?s use this function to rank the rows in our table based on the amount of order within each city
select FirstName, LastName, City, Amount, rank() over(partition by city order by Amount) rnk from customerorder

select FirstName, LastName, City, Amount, rank() over(order by Amount) rnk from customerorder

-- Percent value
-- It is an important window function that finds the relative rank of a row within a group. It determines the percentile value of each row.
-- Its syntax is as follows: Percent_rank() Over(Partition by <expression> Order by <expression>)
-- Although the partition clause is optional.

-- Let?s use this function to determine the amount percentile of each customer in the table
select FirstName, LastName, city, Amount, Percent_rank() over(order by Amount) as percentile from customerorder

-- Nth_value
-- Sometimes you want to find out which row had the highest, lowest, or the nth highest value. 
-- For example, the highest scorer in school, top sales performer, etc. is in situations like these where you need the nth_value() windows function.
-- As a result, the function returns nth row value from an ordered set of rows. The syntax is as follows:
-- nth_value() order (partition by <expression> order by <expression>)

-- Let?s use this function to find out who was the top buyer in the table
-- select FirstName, LastName, nth_value(FirstName, 1) over(order by Amount desc) as nth_val from customerorder

-- MISC Functions
select FirstName, LastName, ISNULL(LastName, 1) as NULL_VAL from customerorder

-- IF ELSE LOOPING LEARN

drop table customerorder