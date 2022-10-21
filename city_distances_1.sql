-->> Problem Statement:
Write a SQL query to convert the given input into the expected output as shown below:

-- INPUT:
SRC         DEST        DISTANCE
Bangalore	Hyderbad	400
Hyderbad	Bangalore	400
Mumbai	    Delhi	    400
Delhi	    Mumbai	    400
Chennai	    Pune	    400
Pune        Chennai	    400

-- EXPECTED OUTPUT:
SRC         DEST        DISTANCE
Bangalore	Hyderbad	400
Mumbai	    Delhi	    400
Chennai	    Pune	    400


-->> Dataset:
drop table src_dest_distance;
create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);
insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);

select * from src_dest_distance;

select T1.*
from src_dest_distance T1
inner join src_dest_distance T2
on T1.source = T2.destination
and T1.destination = T2.source
and T1.source < T2.source