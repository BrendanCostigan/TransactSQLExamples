USE tempdb
GO

-- Example 1

IF EXISTS (SELECT * FROM sys.types WHERE name = 'SSN')
	DROP TYPE SSN;
GO

CREATE TYPE SSN FROM VARCHAR(11) NOT NULL;
GO


-- Example 2
IF EXISTS (SELECT * FROM sys.types WHERE name = 'Product')
	DROP TYPE [Product];
GO

CREATE TYPE [dbo].[Product] AS TABLE
(
	[Id]				 INT	IDENTITY,
	[ItemName]			 NVARCHAR(255),
	[Stock]				 INT
)
GO

DECLARE @XYZ	[dbo].[Product];


INSERT @XYZ
	VALUES  ('Lord Of the Rings', 23),
			('The Hobbit', 31);

SELECT * FROM @XYZ;

-- Tidy up

IF EXISTS (SELECT * FROM sys.types WHERE name = 'SSN')
	DROP TYPE SSN;
GO

IF EXISTS (SELECT * FROM sys.types WHERE name = 'Product')
	DROP TYPE [Product];
GO


