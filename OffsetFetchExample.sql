USE AdventureWorks2014;
GO

-- Consider using OFFSET-FETCH as it is a SQL standard in palce of which TOP is not,
-- however OFFSET-FETCH does not support PERCENT and WITH TIES.


--Return rows 51 to 75:
SELECT SalesOrderID, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC, SalesOrderID DESC
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;                           --< Need to have the ONLY keyword

--Return all rows after the first 50:
SELECT SalesOrderID, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC, SalesOrderID DESC
OFFSET 50 ROWS;													  --< ROW or ROWS is acceptable
