-- Pivot is a sql server operator that can be used
-- to turn unique values from one column, into multiple
-- columns in the output, there by effectively rotating a table

select * from tblProductSales

select SalesCountry, SalesAgent, sum(SalesAmount) as Total
from tblProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

-- CROSS-TAB format

select SalesAgent, India, US, UK
from tblProductSales
pivot 
(
	SUM(SalesAmount)
	FOR SalesCountry
	IN (India, US, UK)
)
as PivotTable