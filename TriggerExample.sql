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

-- AFTER trigger
CREATE TRIGGER trUpdateAfterProduct
ON dbo.Products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN; 
	
	SELECT item FROM inserted;
	
	IF UPDATE(Item)
		SELECT 'Column Item affected' AS Message;
END
GO	

INSERT dbo.Products
VALUES (1, 'Apple')		--< Above message produced for this INSERT

UPDATE dbo.Products
SET Item = 'Orange';	--< Above message produced for this UPDATE
GO

-- INSTEAD OF trigger
CREATE TRIGGER trUpdateInsteadOfProduct
ON dbo.Products
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN; 
	
	SELECT item FROM inserted;
END
GO	

-- This insert will not work because the above INSTEAD OF trigger will fire
INSERT dbo.Products
VALUES (1, 'Pear')

-- Note that Pear is not INSERTED
SELECT * FROM dbo.Products
GO

DISABLE TRIGGER trUpdateInsteadOfProduct ON dbo.Products;
GO

INSERT dbo.Products
VALUES (1, 'Pear');

-- Note that Pear is INSERTED becuase the INSTEAD OF trigger has been disabled
SELECT * FROM dbo.Products;
GO

-- Tidy up
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
	DROP TABLE dbo.Products;
GO



