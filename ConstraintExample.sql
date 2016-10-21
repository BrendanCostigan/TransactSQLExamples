USE tempdb;
GO

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
        DROP TABLE dbo.Orders;
GO

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
        DROP TABLE dbo.Product;
GO

-- Note adding constaint as part of table definition
CREATE TABLE dbo.Product
(
        Id                              INT     IDENTITY(1, 1) CONSTRAINT pk_key PRIMARY KEY,
        ProductName                     NVARCHAR(255),
        ReleaseDate                     DATE CONSTRAINT constraint_ReleaseDate CHECK (ReleaseDate < DATEADD(day, DATEDIFF(day, 0, CURRENT_TIMESTAMP), 0))
);

-- Drop the constraint added as part of CREATE TABLE
ALTER TABLE dbo.Product DROP CONSTRAINT  constraint_ReleaseDate;
GO

-- Then re-add it as a seperate statment
ALTER TABLE dbo.Product WITH NOCHECK 
ADD CONSTRAINT constraint_ReleaseDate CHECK (ReleaseDate < DATEADD(day, DATEDIFF(day, 0, CURRENT_TIMESTAMP), 0));

-- Insert a product with yesterday as a release date is fine
INSERT dbo.Product (ProductName, ReleaseDate)
VALUES ('Lord Of The Rings (DVD)', DATEADD(day, -1, CURRENT_TIMESTAMP));

-- Insert a product with today as a release date fails
-- !! ERROR - The INSERT statement conflicted with the CHECK constraint "constraint_ReleaseDate". The conflict occurred in database "tempdb", table "dbo.Product", column 'ReleaseDate'.
--INSERT dbo.Product (ProductName, ReleaseDate)
--VALUES ('Lord Of The Rings (DVD)', CURRENT_TIMESTAMP);
--GO

-- Foreign key constraint
CREATE TABLE dbo.Orders
(
        Id                      INT IDENTITY,
        ProductId               INT CONSTRAINT fk_ProductId FOREIGN KEY REFERENCES dbo.Product(Id) ON DELETE NO ACTION
)       

-- Add a child
INSERT dbo.Orders (ProductId)
VALUES (1);

-- This should fail
-- !! ERROR - The DELETE statement conflicted with the REFERENCE constraint "fk_ProductId". The conflict occurred in database "tempdb", table "dbo.Orders", column 'ProductId'.
--DELETE dbo.Product
--WHERE Id = 1;

-- Delete the FOREIGN KEY constraint
ALTER TABLE dbo.Orders DROP CONSTRAINT fk_ProductId;

-- Then re-add it as a seperate statment with CASCADE
ALTER TABLE dbo.Orders WITH NOCHECK 
ADD CONSTRAINT fk_ProductId FOREIGN KEY (ProductId) REFERENCES dbo.Product(Id) ON DELETE CASCADE; 

-- Deleting the Parent results in the child being deleted because of the CASCADE
DELETE dbo.Product
WHERE Id = 1;

SELECT * FROM dbo.Orders;

-- Tidy up
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
        DROP TABLE dbo.Orders;
GO

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
        DROP TABLE dbo.Product;
GO
