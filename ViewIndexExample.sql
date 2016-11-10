USE tempdb;
GO

IF OBJECT_ID(N'dbo.viewProduct', N'V') IS NOT NULL
	DROP VIEW dbo.viewProduct;
GO

IF OBJECT_ID(N'dbo.Product', N'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO

CREATE TABLE dbo.Product
(
	Id					INT	IDENTITY(1, 1),
	ProductName			NVARCHAR(255)
);

INSERT dbo.Product
VALUES ('Lord Of The Rings (DVD)'),
	   ('The Hobbit (DVD)');
GO

SELECT * FROM dbo.Product;
GO

CREATE VIEW viewProduct
AS
	SELECT Id, 
		   ProductName
	FROM dbo.Product
GO

--!! ERROR - View must be scheme bound e.g. dbo.viewProduct
--CREATE UNIQUE CLUSTERED INDEX pkViewProduct
--ON viewProduct(id);


IF OBJECT_ID(N'dbo.viewProduct', N'V') IS NOT NULL
	DROP VIEW dbo.viewProduct;
GO

CREATE VIEW dbo.viewProduct
WITH SCHEMABINDING 
AS
	SELECT Id, 
		   ProductName
	FROM dbo.Product
GO

-- ERROR: Cannot create index on view 'dbo.viewProduct'. It does not have a unique clustered index.
-- Once the CLUSTERED INDEX is created then we can add a SECONDARY INDEX (see below)
--CREATE NONCLUSTERED INDEX IX_ProductName
--ON dbo.viewProduct(ProductName);


-- Success - must be UNIQUE CLUSTERED
CREATE UNIQUE CLUSTERED INDEX pkViewProduct
ON viewProduct(id);

CREATE NONCLUSTERED INDEX IX_ProductName
ON dbo.viewProduct(ProductName);


-- Tidy up

IF OBJECT_ID(N'dbo.viewProduct', N'V') IS NOT NULL
	DROP VIEW dbo.viewProduct;
GO

IF OBJECT_ID(N'dbo.Product', N'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO