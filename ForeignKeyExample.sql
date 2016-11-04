USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'foreign_key_example_sequence' AND type = 'SO')
	DROP SEQUENCE [foreign_key_example_sequence];
GO	

CREATE SEQUENCE [foreign_key_example_sequence]
    AS INT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 100
    CYCLE
    CACHE 10;

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'OrderDetail' AND type = 'U')
	DROP TABLE [dbo].[OrderDetail];
GO	

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Product' AND type = 'U')
	DROP TABLE [dbo].[Product];
GO	

CREATE TABLE dbo.Product
(
	Id				INT UNIQUE,
	ProductName		VARCHAR(255)
);

INSERT dbo.Product
VALUES (NEXT VALUE FOR foreign_key_example_sequence, 'Lord Of the Rings DVD'),
	   (NEXT VALUE FOR foreign_key_example_sequence, 'The Bridge DVD');
GO

SELECT * FROM dbo.Product;
GO	 

-- Note also the use of a CHECK
CREATE TABLE dbo.OrderDetail
(
	OrderDate		DATETIME DEFAULT CURRENT_TIMESTAMP,
	ProductId		INT REFERENCES dbo.Product(Id),
	Quantity		INT CONSTRAINT quantity_constraint CHECK (Quantity > 0)		-- Or CHECK (Quantity > 0)	
);
GO

-- !! Generates Foreign Key Error
INSERT dbo.OrderDetail(OrderDate, ProductId, Quantity)
VALUES (DEFAULT, 99, 3)				-- Default date, ProductId,	Quantity
GO

-- !! Generates Check Constraint Error
INSERT dbo.OrderDetail(OrderDate, ProductId, Quantity)
VALUES (DEFAULT, 1, -1)				-- Default date, ProductId,	Quantity
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'OrderDetail' AND type = 'U')
	DROP TABLE [dbo].[OrderDetail];
GO	

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Product' AND type = 'U')
	DROP TABLE [dbo].[Product];
GO	

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'foreign_key_example_sequence' AND type = 'SO')
	DROP SEQUENCE [foreign_key_example_sequence];
GO	
