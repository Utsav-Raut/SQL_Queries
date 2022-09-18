create table emp(EMPID integer, NAME varchar(30), JOB varchar(30), SALARY integer);

/* Sample data */
insert into emp (EMPID, NAME, JOB, SALARY)
values
(201, 'ANIRUDDHA', 'ANALYST', 2100),
(212, 'LAKSHAY', 'DATA ENGINEER', 2700),
(209, 'SIDDHARTH', 'DATA ENGINEER', 3000),
(232, 'ABHIRAJ', 'DATA SCIENTIST', 2500),
(205, 'RAM', 'ANALYST', 2500),
(222, 'PRANAV', 'MANAGER', 4500),
(202, 'SUNIL', 'MANAGER', 4800),
(233, 'ABHISHEK', 'DATA SCIENTIST', 2800),
(244, 'PURVA', 'ANALYST', 2500),
(217, 'SHAROON', 'DATA SCIENTIST', 3000),
(216, 'PULKIT', 'DATA SCIENTIST', 3500),
(200, 'KUNAL', 'MANAGER', 5000);

insert into emp (EMPID, NAME, JOB, SALARY)
values(210, 'SHIPRA', 'ANALYST', 2800);

select * from emp;

-- Window functions perform calculations on a set of rows that are related together. 
-- But, unlike the aggregate functions, windowing functions do not collapse the result of the rows into a single value. 
-- Instead, all the rows maintain their original identity and the calculated result is returned for every row.


-- OVER CLAUSE
-- Display the total salary of employees along with every row value
select *, sum(SALARY) over() as sum_of_sal from emp;

-- the syntax for defining a simple window function that outputs the same value for all rows is as follows:
-- window_function_name(<expression>) OVER ( )

-- The OVER clause signifies a window of rows over which a window function is applied. 
-- It can be used with aggregate functions, like we have used with the SUM function here, thereby turning it into a window function. 
-- Or, it can also be used with non-aggregate functions that are only used as window functions.


-- WINDOWING WITH PARTITION BY CLAUSE
-- The PARTITION BY clause is used in conjunction with the OVER clause. 
-- It breaks up the rows into different partitions. These partitions are then acted upon by the window function.

-- Running Total
-- Display the total salary per job category for all the rows
select *, sum(SALARY) over(partition by JOB) as sum_per_job_cat from emp;

-- ordering by salary within each partition
select *, sum(SALARY) over(partition by JOB order by SALARY desc) as sum_per_job_cat from emp;


-- ROW_NUMBER

-- Sometimes your dataset might not have a column depicting the sequential order of the rows, as is the case with our dataset. 
-- In that case, we can make use of the ROW_NUMBER() window function. It assigns a unique sequential number to each row of the table
select *, ROW_NUMBER() over (order by EMPID) as "row_num" from emp;

-- partition the rows on the JOB column and order them based on the SALARY of the employee.
select *, ROW_NUMBER() over (partition by JOB order by EMPID) as "row_num" from emp;


-- RANK VS DENSE_RANK
select *, 
ROW_NUMBER() over (partition by JOB order by EMPID) as "row_num" ,
RANK() over(partition by JOB order by salary) as "emp_rank"
from emp;


select *, 
ROW_NUMBER() over (partition by JOB order by EMPID) as "row_num" ,
RANK() over(partition by JOB order by salary) as "emp_rank",
DENSE_RANK() over(partition by JOB order by salary) as "emp_dense_rank"
from emp;

-- in the case of RANK(), we have the same rank for rows with the same value
-- But although rows with the same value are assigned the same rank, the subsequent rank skips the missing rank. 
-- This wouldn’t give us the desired results if we had to return “top N distinct” values from a table

-- The DENSE_RANK() function is similar to the RANK() except for one difference, it doesn’t skip any ranks when ranking rows


-- Nth VALUE
-- If we want to retrieve the nth value from a window frame for an expression, then we can use the NTH_VALUE(expression, N) window function.
-- For example, to retrieve the third-highest salary in each JOB category, we can partition the rows according to the JOB column, 
-- then order the rows within the partitions according to decreasing salary, and finally, use the NTH_VALUE function to retrieve the value.
select * from 
(select *,
ROW_NUMBER() over(partition by JOB order by SALARY desc) as "row_num"
from emp) inn
where inn.row_num = 3



