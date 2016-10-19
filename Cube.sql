USE tempdb;
GO

-- GROUP BY CUBE ( )
--
-- GROUP BY CUBE creates groups for all possible combinations of columns. 
-- For GROUP BY CUBE (a, b) the results has groups for unique values of 
-- (a, b), (NULL, b), (a, NULL), and (NULL, NULL).

-- See also GROUPINGSETS and ROLLUP examples

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


--CUBE says SELECT all possible grouping sets 
--Country, Region
--Country
--Region
--ALL
SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY CUBE (Country, Region)
--ORDER BY Country, Region;

--This is the equivalent of the above 
SELECT Country, Region, SUM(VALUE)
FROM dbo.Sales
GROUP BY 
	GROUPING SETS
	(
		(Country, Region),
		(Country),
		(Region),
		( )
	)
ORDER BY Country, Region;


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Sales' AND Type = 'U')
	DROP TABLE dbo.Sales;
