USE AdventureWorks2014;
GO

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
