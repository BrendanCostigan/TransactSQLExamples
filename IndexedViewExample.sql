USE tempdb;
GO

-- Drop VIEW
IF OBJECT_ID('vwProduct', 'V') IS NOT NULL
	DROP VIEW vwProduct;
GO

-- Drop TABLE
IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO

CREATE TABLE dbo.Product
(
	Id				INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Item			NVARCHAR(255)
)


INSERT dbo.Product(Item)
VALUES	('Bike'),
		('Car'),
		('Scooter');
GO	

-- Create a view from the query
-- Note the table name must include the schemea name
CREATE VIEW vwProduct
WITH SCHEMABINDING
AS
	SELECT	Id,
			Item
	FROM dbo.Product AS P;
GO

-- Index the view
-- To create an index the view must be created with SCHEMABINDING
CREATE UNIQUE CLUSTERED INDEX idx_vwProduct
ON vwProduct(Id);
GO


-- Tidy up

IF OBJECT_ID('vwProduct', 'V') IS NOT NULL
	DROP VIEW vwProduct;
GO

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO