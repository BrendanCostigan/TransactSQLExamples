USE AdventureWorks2014;
GO

-- LAG(actual column, rows back, default value)
SELECT	TOP 10 
		[CustomerID], 
		[SalesOrderID], 
		[OrderDate], 
		[TotalDue],
		LAG([TotalDue], 1, 0) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS PreviousValue,
		LEAD([TotalDue], 1, 0) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS NextValue
FROM [Sales].[SalesOrderHeader]
WHERE CustomerID = 11000;
