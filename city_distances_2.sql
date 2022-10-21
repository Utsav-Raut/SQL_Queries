-->> Problem Statement:
Write SQL Query to find the average distance between the locations?

-- INPUT:
SRC       DEST    DISTANCE
A	      B	      21
B	      A	      28
A	      B	      19
C	      D	      15
C	      D	      17
D	      C	      16.5
D	      C	      18

-- EXPECTED OUTPUT:
SRC       DEST    DISTANCE
A	      B	      22.66
C	      D	      16.62


-->> Dataset:
drop table src_dest_dist;
create table src_dest_distance_2
(
    src         varchar(20),
    dest        varchar(20),
    distance    float
);
insert into src_dest_distance_2 values ('A', 'B', 21);
insert into src_dest_distance_2 values ('B', 'A', 28);
insert into src_dest_distance_2 values ('A', 'B', 19);
insert into src_dest_distance_2 values ('C', 'D', 15);
insert into src_dest_distance_2 values ('C', 'D', 17);
insert into src_dest_distance_2 values ('D', 'C', 16.5);
insert into src_dest_distance_2 values ('D', 'C', 18);

select * from src_dest_distance_2;

with cte as
	(select src, dest, sum(distance) as total_dist, count(distance) as no_of_routes,
		row_number() over(order by src) as id
		from src_dest_distance_2
		group by src, dest)
select T1.src, T2.src, (T1.total_dist + T2.total_dist) / (T1.no_of_routes + T2.no_of_routes) as avg_dist
from cte T1
join cte T2
on T1.src = T2.dest
and T1.dest = T2.src
and T1.id < T2.id


