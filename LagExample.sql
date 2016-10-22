USE AdventureWorks2014;
GO

-- LAG(actual column, rows back, default value)
SELECT	TOP 10 
		[CustomerID], 
		[SalesOrderID], 
		[OrderDate], 
		[TotalDue],
		LAG([TotalDue]) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS PreviousValue, 
		LEAD([TotalDue], 1, 0) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS NextValue,	--< Note default value of 0 rather than NULL, which is the default
		FIRST_VALUE([TotalDue]) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS FirstValue,
		LAST_VALUE([TotalDue]) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID]) AS QuestionableLastValue, --< Defaults to RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW which is probably not what you want
		LAST_VALUE([TotalDue]) OVER(PARTITION BY [CustomerID] ORDER BY [OrderDate], [SalesOrderID] ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LastValue 
FROM [Sales].[SalesOrderHeader]
WHERE [CustomerID] = 11131
ORDER BY CustomerID, [OrderDate], [SalesOrderID];

