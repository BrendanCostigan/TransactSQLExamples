USE tempdb;
GO

-- GROUP BY ROLLUP
--
-- Creates a group for each combination of column expressions. In addition,
-- it "rolls up" the results into subtotals and grand totals. To do this, 
-- it moves from right to left decreasing the number of column expressions 
-- over which it creates groups and the aggregation(s).

-- See also GROUPINGSETS and CUBE examples

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Sales' AND Type = 'U')
	DROP TABLE dbo.Sales;


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



--ROLLUP 
-- Country, Region
-- Country
-- ALL
SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY ROLLUP (Country, Region)
--ORDER BY Country, Region;


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Sales' AND Type = 'U')
	DROP TABLE dbo.Sales;
