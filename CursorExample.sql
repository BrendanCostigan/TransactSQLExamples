USE tempdb;
GO

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
	DROP TABLE dbo.Products;
GO

CREATE TABLE dbo.Products
(
	Id			INT,
	Item		NVARCHAR(255)
)
GO

INSERT dbo.Products
VALUES (1, 'Apple')
GO

INSERT dbo.Products
VALUES (2, 'Orange')
GO

INSERT dbo.Products
VALUES (3, 'Pear')
GO


DECLARE @ProductId		INT;

DECLARE myCursor CURSOR FAST_FORWARD FOR 				--< Note that the cursor name is not declared with a @ like a normal declare
SELECT Id FROM dbo.Products;

OPEN myCursor;

FETCH NEXT FROM myCursor INTO @ProductId;

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT Item 
	FROM Products
	WHERE Id = @ProductId;

	FETCH NEXT FROM myCursor INTO @ProductId;

END

CLOSE myCursor;

DEALLOCATE myCursor;
 
 
-- Tidy up
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
	DROP TABLE dbo.Products;
GO