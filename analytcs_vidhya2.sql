create table ConsumerDetails(Name varchar(25), Locality varchar(100), Total_amt_spend integer, Industry varchar(100));

select * from ConsumerDetails;

insert into ConsumerDetails values('Raj', 'Raj Nagar', 750, 'Manufacturing');
insert into ConsumerDetails values('Ajay', 'Vijay Nagar', 500, 'Creative');
insert into ConsumerDetails values('Sagar', 'Shivam Nagar', 900, 'News');
insert into ConsumerDetails values('Akul', 'Preet Vihar', 350, 'Teaching');
insert into ConsumerDetails values('Rohan', 'kakar Vihar', 1150, 'Tech');
insert into ConsumerDetails values('Shantanu', 'Shanti Vihar', 2110, 'Defense');
insert into ConsumerDetails values('Natasha', 'shakti nagar', 2200, 'Aviation');
insert into ConsumerDetails values('Kapil', 'shakti nagar', 700, 'Aviation');
insert into ConsumerDetails values('Tanmay', 'sikkim Nagar', 900, 'Defense');
insert into ConsumerDetails values('Tarun', 'nikepur', 3000, 'Manufacturing');

select count(*) from ConsumerDetails;
select distinct Industry from ConsumerDetails;
select count(distinct Industry) as distinct_indstry_cnt from ConsumerDetails;
select sum(Total_amt_spend) as total_amt_spent from ConsumerDetails;
select avg(Total_amt_spend) as avg_amt_spent from ConsumerDetails;
select stdev(Total_amt_spend) as stdrd_dev from ConsumerDetails; 
select max(Total_amt_spend) as max_amt from ConsumerDetails; 
select min(Total_amt_spend) as min_amt from ConsumerDetails; 

select Name from ConsumerDetails where Locality in('shakti nagar', 'Shanti Vihar') and Total_amt_spend >= 2000;

select Name from ConsumerDetails where Total_amt_spend between 1000 and 2000;

select top 5 * from ConsumerDetails;

select * from ConsumerDetails order by Name offset 3 rows fetch next 2 rows only;

select * from ConsumerDetails order by Total_amt_spend desc;

select * from ConsumerDetails where Locality like '%Nagar';

select Name from ConsumerDetails where Name like '_a%';

-- find the Number of Customers corresponding to the industries they belong to
select Industry, count(*) as cnt from ConsumerDetails group by Industry order by count(*);

 -- Find the sum of spendings by customers grouped by the industry they belong to
 select Industry, sum(Total_amt_spend) from ConsumerDetails group by Industry order by Industry

 -- Find the industries whose total_sum is greater than 2500
 select Industry, sum(Total_amt_spend) from ConsumerDetails group by Industry having sum(Total_amt_spend) > 2500 order by Industry;

 drop table ConsumerDetails;