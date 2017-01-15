-- Uses SQL 2016 - DROP {OBJECT} IF EXISTS

USE tempdb;
GO

DROP VIEW IF EXISTS vTableOne;
GO

DROP TABLE IF EXISTS TableOne;
GO

CREATE TABLE TableOne
(
	Id			INT	IDENTITY(1, 1),
	SomeText	VARCHAR(255) NOT NULL
)

SET NOCOUNT ON;
GO

INSERT TableOne (SomeText)
VALUES ('Just Some Text')
GO 100


CREATE VIEW vTableOne
AS
	SELECT Id, SomeText
	FROM dbo.TableOne
	WHERE Id < 10;
GO

-- View shows first few rows
SELECT * FROM vTableOne;

-- ... but the table has alot more rows
SELECT * FROM TableOne;

-- Exceed view range, no error message but does not update any rows
UPDATE vTableOne
SET SomeText = 'Some non date text'
WHERE id >= 10;

SELECT * FROM TableOne;

-- You can INSERT records outside of the scope of the view if WITH CHECK OPTION is not specified

INSERT dbo.vTableOne (SomeText)
VALUES ('Test Inserts');

SELECT * FROM TableOne WHERE SomeText = 'Test Inserts';

-- Exceed view range, no error message but does not delete any rows
DELETE vTableOne
WHERE id >= 10;

SELECT * FROM TableOne;

-- !! ERROR: Cannot create index on view 'vTableOne' because the view is not schema bound.
CREATE INDEX pkIndex 
ON vTableOne(id);
GO

DROP VIEW IF EXISTS vTableOne;
GO

-- Note WITH CHECK OPTION is part of the SELECT statement
CREATE VIEW vTableOne
AS
	SELECT Id, SomeText
	FROM dbo.TableOne
	WHERE SomeText = 'Just Some Text'
	WITH CHECK OPTION;
GO

-- With the CHECK OPTION on the view and as this UPDATE would prevent this row from appearing in the view it is prohibited
UPDATE vTableOne
SET SomeText = 'Some Other Text'
WHERE Id = 1;


-- Now try another INSERT but now with WITH CHECK OPTION on. This time it is not allowed

INSERT dbo.vTableOne (SomeText)
VALUES ('Test Inserts');

SELECT * FROM TableOne WHERE SomeText = 'Test Inserts';

DROP VIEW IF EXISTS vTableOne;
GO

-- Note WITH SCHEMABINDING is on CREATE statement
CREATE VIEW vTableOne
WITH SCHEMABINDING 
AS
	SELECT Id, SomeText
	FROM dbo.TableOne
	WHERE Id < 10
	WITH CHECK OPTION;
GO

-- First index must be unique clustered else you get an error message
-- Cannot create index on view 'vTableOne'. It does not have a unique clustered index.
CREATE INDEX pkIndex 
ON vTableOne(id);


-- This time it works
CREATE UNIQUE CLUSTERED INDEX pkIndex 
ON vTableOne(id);
GO

DROP VIEW IF EXISTS dbo.vTwoTables;

DROP TABLE IF EXISTS dbo.TableTwo;

-- Now lets try a view on two tables
CREATE TABLE dbo.TableTwo
(
	Id			INT	IDENTITY(1, 1),
	SomeText	VARCHAR(255) NOT NULL
)

SET NOCOUNT ON;
GO

INSERT TableTwo(SomeText)
VALUES ('Just Some Text')
GO 100


CREATE VIEW dbo.vTwoTables
WITH SCHEMABINDING 
AS
	SELECT t1.Id, t1.SomeText AS TableOneText, t2.SomeText AS TableTwoText
	FROM dbo.TableOne t1
	INNER JOIN dbo.TableTwo t2
	ON t1.Id = t2.Id
	WHERE t1.Id < 10
	WITH CHECK OPTION;
GO


UPDATE dbo.vTwoTables
SET TableOneText = 'This will generate an error',
	TableTwoText = 'Cannot update multiple tables via view';


SELECT * FROM dbo.vTwoTables;

-- !! Error cannot delete against a view that access multiple tables
DELETE dbo.vTwoTables;







