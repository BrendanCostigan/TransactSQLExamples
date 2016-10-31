USE tempdb;
GO

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO

CREATE TABLE dbo.Product (ColumnA INT NOT NULL);										--< Create a table
GO

ALTER TABLE dbo.Product ADD ColumnB VARCHAR(20) NULL;									--< Add a new column
GO

ALTER TABLE dbo.Product ADD CONSTRAINT PK_ColumnA PRIMARY KEY CLUSTERED (ColumnA ASC)	--< Add Primary Key Constraint
GO

ALTER TABLE dbo.Product ALTER COLUMN ColumnB DECIMAL(5, 2);								--< Change column type
GO

CREATE UNIQUE INDEX U_ColumnB ON dbo.Product(ColumnB)									--< Create Index
GO

DROP INDEX U_ColumnB ON dbo.Product														--< Drop Index
GO

ALTER TABLE dbo.Product DROP COLUMN ColumnB;											--< Drop a column
GO

-- Tidy Up
IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
	DROP TABLE dbo.Product;
GO

