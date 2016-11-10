USE tempdb;
GO

IF OBJECT_ID('dbo.AuditTable','U') IS NOT NULL
	DROP TABLE dbo.AuditTable;
GO

IF OBJECT_ID('dbo.Orders','U') IS NOT NULL
	DROP TABLE dbo.Orders;
GO


CREATE TABLE dbo.Orders
(
	Id			INT IDENTITY,
	OrderDate	DATETIME DEFAULT CURRENT_TIMESTAMP,
	ItemName	VARCHAR(255)	PRIMARY KEY,
	Quantity	INT
)
GO


CREATE TABLE dbo.AuditTable
(
	ItemName	VARCHAR(255),
	Quantity	INT
)

-- Use of the Output statment
-- Must prefix with the inserted keyword
INSERT  dbo.Orders(ItemName, Quantity)
OUTPUT inserted.ItemName, inserted.Quantity
INTO dbo.AuditTable(ItemName, Quantity)
VALUES ('The Hobbit', 0);

SELECT * FROM AuditTable;

-- Demonstrate that you cannot have foreign keys on OUTPUT tables
ALTER TABLE dbo.AuditTable 
ADD  CONSTRAINT FK_ItemName FOREIGN KEY (ItemName)
REFERENCES dbo.Orders(ItemName);


-- Repeat the output and we generate an error
-- !! ERROR - The target table 'dbo.AuditTable' of the OUTPUT INTO clause cannot be on either side of a (primary key, foreign key) relationship. Found reference constraint 'FK_ItemName'.
--INSERT  dbo.Orders(ItemName, Quantity)
--OUTPUT inserted.ItemName, inserted.Quantity
--INTO dbo.AuditTable(ItemName, Quantity)
--VALUES ('The Hobbit', 0);

-- Tidy Up
IF OBJECT_ID('dbo.AuditTable','U') IS NOT NULL
	DROP TABLE dbo.AuditTable;
GO

IF OBJECT_ID('dbo.Orders','U') IS NOT NULL
	DROP TABLE dbo.Orders;
GO



