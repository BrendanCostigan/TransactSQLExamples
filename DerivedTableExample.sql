USE AdventureWorks2012
GO

SELECT rownum, [ProductID], [Name], [ListPrice]
FROM (	SELECT ROW_NUMBER() OVER(PARTITION BY [Class] ORDER BY [ListPrice], [ProductID]) AS rownum, [ProductID], [Name], [ListPrice]
		FROM Production.Product) AS D
WHERE rownum <= 2;