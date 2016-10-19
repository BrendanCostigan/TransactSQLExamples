USE tempdb;
GO

-- Reference: https://www.mssqltips.com/sqlservertip/1019/crosstab-queries-using-pivot-in-sql-server/

IF OBJECT_ID('ProductSales', 'U') IS NOT NULL
	DROP TABLE ProductSales;

CREATE TABLE dbo.ProductSales
(
	OrderId				INT IDENTITY(1, 1),
	SalesPerson 		NVARCHAR(255),
	Product 			NVARCHAR(255),
	SalesAmount 		MONEY,
)


INSERT ProductSales (SalesPerson, Product, SalesAmount)
VALUES 	('Bob', 'Pickles', 100.00), 
		('Sue', 'Oranges', 50.00), 
		('Bob', 'Pickles', 25.00),
		('Bob', 'Oranges', 300.00),
		('Sue', 'Oranges', 500.00),
		('Joe', 'Bananas', 500.00);		--< Note Joe only sold Bananas and they are not the spreading part 
										--  of the Pivot table below.

SELECT SalesPerson,
	   [Pickles], 
	   [Oranges], 
	   [Apples]
FROM ProductSales
PIVOT (SUM(SalesAmount) FOR Product IN ([Pickles], [Oranges], [Apples])) AS t;

-- Tidy up

IF OBJECT_ID('ProductSales', 'U') IS NOT NULL
	DROP TABLE ProductSales;