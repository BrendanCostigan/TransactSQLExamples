USE AdventureWorks2014;
GO

SET NOCOUNT ON;				--< The WITH clause would with fail without a semicolon

WITH CTE AS
(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY ProductLine ORDER BY ListPrice, productid) AS RowNumber, ProductLine, productid, Name, ListPrice
	FROM Production.Product
)
SELECT RowNumber, ProductLine, productid, Name, ListPrice
FROM CTE
WHERE RowNumber <= 2;