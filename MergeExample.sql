-- Reference: An example from the following book - https://www.amazon.co.uk/Training-Kit-Exam-70-461-Microsoft/dp/0735666059

USE TEST;
GO

IF OBJECT_ID(N'dbo.Products', N'U') IS NOT NULL
	DROP TABLE dbo.Products; 

CREATE TABLE dbo.Products
(
	Id				INT PRIMARY KEY,
	Product			NVARCHAR(255),
	Stock			INT
);

INSERT dbo.Products 
VALUES (1, N'Apples', 3)
GO

-- Update Stock from 3 to 45
MERGE dbo.Products AS target
USING (SELECT 1, 'Apples', 45) AS source (productId, productName, stockLevel)
ON (target.id = source.productid)
WHEN MATCHED THEN
	UPDATE SET Stock = stockLevel;
	
SELECT * FROM dbo.Products;	

-- Insert new record
MERGE dbo.Products AS target
USING (SELECT 2, 'Orange', 25) AS source (productId, productName, stockLevel)
ON (target.id = source.productid)
WHEN MATCHED THEN
	UPDATE SET Stock = stockLevel
WHEN NOT MATCHED THEN
	INSERT (Id, Product, Stock)
	VALUES (productId, productName, stockLevel);
	
SELECT * FROM dbo.Products;		

--!! ERROR: In a MERGE statement, a 'WHEN MATCHED' clause with a search condition cannot appear after a 'WHEN MATCHED' clause with no search condition.
--MERGE Products AS target
--USING (SELECT 1, 'Apple', 0) AS source (productId, productName, stockLevel)
--ON (target.id = source.productid)
--WHEN MATCHED THEN
--	UPDATE SET Stock = stockLevel
--WHEN MATCHED AND stockLevel = 0
--	THEN DELETE
--WHEN NOT MATCHED THEN
--	INSERT (Id, Product, Stock)
--	VALUES (productId, productName, stockLevel);


-- Further to the above error we can reverse the MATCHED statements and it works as required
-- If the new stock level is zero, then delete the record. Note the use of MATCHED and AND statement.
MERGE dbo.Products AS target
USING (SELECT 1, 'Apple', 0) AS source (productId, productName, stockLevel)
ON (target.id = source.productid)
WHEN MATCHED AND stockLevel = 0
	THEN DELETE
WHEN MATCHED THEN
	UPDATE SET Stock = stockLevel
WHEN NOT MATCHED THEN
	INSERT (Id, Product, Stock)
	VALUES (productId, productName, stockLevel);

SELECT * FROM dbo.Products;	


-- Currently, there is one row 'Orange' in the dbo.Products table

MERGE dbo.Products AS target
USING (SELECT 1, 'Apple', 0) AS source (productId, productName, stockLevel)
ON (target.id = source.productid)
WHEN NOT MATCHED BY SOURCE											--< As the current record is not matched by the incoming record it is deleted
	THEN DELETE;

SELECT * FROM dbo.Products;	


IF OBJECT_ID(N'tempdb..#OutputTable', N'U') IS NOT NULL
	DROP TABLE #OutputTable; 

CREATE TABLE #OutputTable
(
	the_action		NVARCHAR(10),
	action_id		INT
)

MERGE dbo.Products AS target
USING (SELECT 1, 'Apple', 0) AS source (productId, productName, stockLevel)
ON (target.id = source.productid)
WHEN MATCHED AND stockLevel = 0
	THEN DELETE
WHEN MATCHED THEN
	UPDATE SET Stock = stockLevel
WHEN NOT MATCHED THEN
	INSERT (Id, Product, Stock)
	VALUES (productId, productName, stockLevel)
OUTPUT $action AS the_action,
	   COALESCE(inserted.id, deleted.id) AS orderid
INTO #OutputTable;							--< INTO does not create the table, it must already exist

SELECT * FROM #OutputTable;					-- Thsi is from the table populated by the OUTPUT statement

-- Tidy up
IF OBJECT_ID(N'dbo.Products', N'U') IS NOT NULL
	DROP TABLE dbo.Products;

IF OBJECT_ID(N'tempdb..#OutputTable', N'U') IS NOT NULL
	DROP TABLE #OutputTable; 
