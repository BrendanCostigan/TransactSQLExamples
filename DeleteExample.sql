USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myTable' and type = 'U')
	DROP TABLE myTable;
GO


CREATE TABLE myTable
(
	Id			INT IDENTITY,
	OrderDate	DATETIME DEFAULT CURRENT_TIMESTAMP,
	ItemName	VARCHAR(255),
	Quantity	INT
)
GO

-- DEFAULT is used against the OrderField not the IDENTITY field
INSERT myTable VALUES (DEFAULT, 'Lord Of the Rings', 0);
GO

INSERT myTable  (ItemName, Quantity)
SELECT 'The Hobbit', 0;
GO

-- Rather than a simple UPDATE statement using a CTE allows you to 
-- run the SELECT statement without change to see what rows will
-- be impacted by an update

WITH CTE AS
(
	SELECT Quantity
	FROM myTable
	WHERE ItemName = 'Lord Of the Rings'
)
DELETE FROM CTE;


-- Note just the Lord of the Rings has gone
SELECT * FROM myTable;

-- Now put it back to see that just one row is deleted using the derived table
INSERT myTable VALUES (DEFAULT, 'Lord Of the Rings', 0);
GO


-- An alternative approach with the same result is this derived table
DELETE A					--< Note the use the table name from the derived table
FROM (
		SELECT Quantity
		FROM myTable
		WHERE ItemName = 'The Hobbit'
	) AS A;


SELECT * FROM myTable;

-- Tidy Up
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'myTable' and type = 'U')
	DROP TABLE myTable;
GO

