USE tempdb;
GO

-- See also CUBE and ROLLUP examples

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Sales' AND Type = 'U')
	DROP TABLE Sales;


CREATE TABLE dbo.Sales
(
	Country		VARCHAR(255),
	Region		VARCHAR(255),
	Value		DECIMAL(9, 2)
)


INSERT dbo.Sales
VALUES 
	('England', 'North', 21.00),
	('England', 'North', 22.00),
	('England', 'South', 27.00),
	('England', 'South', 29.00),
	('England', 'South', 23.00),
	('Scotland', 'North', 11.00),
	('Scotland', 'North', 12.00),
	('Scotland', 'North', 7.00),
	('Scotland', 'South', 9.00),
	('Scotland', 'South', 13.00);


-- ERROR - Column 'Sales.Region' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
-- Reason is that Region is not in the Group Set
--
--SELECT Country, Region, SUM(VALUE)
--FROM dbo.Sales
--GROUP BY 
--	GROUPING SETS
--	(
--		(Country)
--	)
--GO

-- This fixes that
SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY 
	GROUPING SETS
	(
		(Country, Region)
	)
ORDER BY Country, Region;

-- Note a simple GROUP BY gives the same value as the GROUPING SET example above
--SELECT Country, Region, SUM(VALUE)
--FROM dbo.Sales
--GROUP BY Country, Region
--ORDER BY Country, Region;



SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY 
	GROUPING SETS
	(
		(Country, Region),		--< Group by Country, Region
		(Country)				--< Additional group by just COUNTRY
	)
ORDER BY Country, Region;

SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY 
	GROUPING SETS
	(
		(Country, Region),
		(Country),
		( )						--< Group by ALL
	)
ORDER BY Country, Region;


-- When grouping SQL uses NULL to indicate the level which is being grouped. 
-- However, if the column allows NULLs, you cannot tell if it is a grouping 
-- column or a NULL in the data hence the GROUPING function which outputs a 
-- 1 to indicate a grouping row or a 0 to indicate it is not i.e. if a column 
-- contains NULL it is because of data and not grouping.

SELECT Country, GROUPING(Country), Region, GROUPING(Region), SUM(VALUE)		--< Note the GROUPING FUNCTION in the SELECT
FROM dbo.Sales
GROUP BY 
	GROUPING SETS
	(
		(Country, Region),
		(Country),
		( )						--< Group by ALL
	)
ORDER BY Country, Region;


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Sales' AND Type = 'U')
	DROP TABLE dbo.Sales;
