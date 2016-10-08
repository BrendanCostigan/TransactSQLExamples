-- The database AdventureWorks2014 is available from the Microsoft site https://msftdbprodsamples.codeplex.com/


USE AdventureWorks2014;
GO


-- Source:	https://technet.microsoft.com/en-us/library/ms189575(v=sql.105).aspx
--			https://www.simple-talk.com/sql/sql-training/subqueries-in-sql-server/
--
-- You must enclose a subquery in parenthesis.
-- A subquery must include a SELECT clause and a FROM clause.
-- A subquery can include optional WHERE, GROUP BY, and HAVING clauses.
-- A subquery cannot include COMPUTE or FOR BROWSE clauses.
-- You can include an ORDER BY clause only when a TOP clause is included.
-- You can nest subqueries up to 32 levels.


-- Suquery in SELECT clause

SELECT	OrderHeader.SalesOrderID,
		OrderHeader.OrderDate,
		(
			SELECT MAX(OrderDetail.UnitPrice)
			FROM Sales.SalesOrderDetail AS OrderDetail
			WHERE OrderHeader.SalesOrderID = OrderDetail.SalesOrderID
		) AS MaxUnitPrice
FROM Sales.SalesOrderHeader AS OrderHeader;


SELECT	SalesOrderNumber,
		SubTotal,
		OrderDate,
		(
			SELECT SUM(OrderQty)
			FROM Sales.SalesOrderDetail
			WHERE SalesOrderID = 43659
		) AS TotalQuantity
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = 43659;


-- Subquery in FROM clause

SELECT p.ProductID,
	p.NAME AS ProductName,
	p.ProductSubcategoryID AS SubcategoryID,
	ps.NAME AS SubcategoryName
FROM Production.Product p
INNER JOIN (
	SELECT ProductSubcategoryID,
		NAME
	FROM Production.ProductSubcategory
	WHERE NAME LIKE '%bikes%'
	) AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID;



-- Subquery in WHERE clause


SELECT BusinessEntityID,
	FirstName,
	LastName
FROM Person.Person
WHERE BusinessEntityID = (
		SELECT BusinessEntityID
		FROM HumanResources.Employee
		WHERE NationalIDNumber = '895209680'
		);