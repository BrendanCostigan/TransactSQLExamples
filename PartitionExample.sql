USE AdventureWorks2014;
GO

SET NOCOUNT ON;				--< The WITH clause would with fail without a semicolon

WITH CTE AS
(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY ProductLine ORDER BY ListPrice, productid) AS rownum, ProductLine, productid, Name, ListPrice
	FROM Production.Product
)
SELECT rownum, ProductLine, productid, Name, ListPrice
FROM CTE
WHERE rownum <= 2;