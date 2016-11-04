-- The database AdventureWorks2014 is available from the Microsoft site https://msftdbprodsamples.codeplex.com/
USE AdventureWorks2012
GO

-- 
-- The main advantage of the Common Table Expression (when not using it for recursive queries) is encapsulation, 
-- instead of having to declare the sub-query in every place you wish to use it, you are able to define it once, 
-- but have multiple references to it. (http://stackoverflow.com/questions/706972/difference-between-cte-and-subquery)
--

SET NOCOUNT ON;				--< The WITH clause would with fail without a semicolon

WITH CTE AS
(
	SELECT ROW_NUMBER() OVER(PARTITION BY categoryid ORDER BY unitprice, productid) AS rownum, categoryid, productid, productname, unitprice
	FROM Production.Product
)
SELECT categoryid, productid, productname, unitprice
FROM CTE
WHERE rownum <= 2;






