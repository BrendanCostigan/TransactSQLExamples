USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Product' AND type = 'U')
	DROP TABLE Product;
GO

CREATE TABLE Product
(
	Id					INT	IDENTITY(1, 1),
	ProductName			NVARCHAR(255)
);

INSERT Product
VALUES ('Lord Of The Rings (DVD)'),
	   ('The Hobbit (DVD)');
GO

SELECT * FROM Product;

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'viewProduct')
	DROP VIEW viewProduct;
GO

CREATE VIEW viewProduct
AS
	SELECT Id, ProductName
	FROM Product
	WHERE Id < 2
	WITH CHECK OPTION;					--< Note use of CHECK OPTION
GO

UPDATE viewProduct
SET ProductName = 'Lord Of The Rings (Blu-ray)'
WHERE Id = 1
GO

-- !! ERROR as it would try and insert an Id of 3 which is higher than the view allows
INSERT viewProduct
VALUES ('The Silmarillion (DVD)');
GO

SELECT * FROM viewProduct;

-- No error or update performed as there are no records in the View with an Id of 2
UPDATE viewProduct
SET ProductName = 'The Hobbit (Blu-ray)'
WHERE Id = 2;
GO

-- If a view is created without SCHEMABINDING and the schema changes then use the following to update the view
sp_refreshview 'viewProduct';

-- Tidy up
IF OBJECT_ID('viewProduct', 'V') IS NOT NULL
	DROP VIEW viewProduct;

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Product' AND type = 'U')
	DROP TABLE Product;
GO



