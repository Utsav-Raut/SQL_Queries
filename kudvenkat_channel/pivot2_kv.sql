-- In case if we have some extra columns (like an ID column), we select the columns required for our
-- operations, and then perform pivot on it.

select * from tblProductsSale

select SalesAgent, India, US, UK
from
(
	select SalesAgent, SalesCountry, SalesAmount
	from tblProductsSale
) as sourceTable
pivot
(
	sum(SalesAmount)
	For SalesCountry
	in (India, US, UK)
) as pivotTable