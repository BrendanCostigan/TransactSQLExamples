-- Uses SQL 2016 - DROP {OBJECT} IF EXISTS

USE tempdb;
GO

DROP TABLE IF EXISTS Brendan;
GO

CREATE TABLE Brendan
(
	Id			INT	IDENTITY(1, 1),
	SomeText	VARCHAR(255) NOT NULL
)

SET NOCOUNT ON;
GO

INSERT Brendan (SomeText)
VALUES (CAST(GETDATE() AS VARCHAR(255)))

WAITFOR DELAY '00:00:00:10'
GO 1000


DROP VIEW IF EXISTS vBrendan;
GO

-- Note WITH CHECK OPTION is part of the SELECT statement
CREATE VIEW vBrendan
AS
	SELECT Id, SomeText
	FROM dbo.Brendan
	WHERE Id < 100
	WITH CHECK OPTION;
GO

SELECT * FROM vBrendan;

-- Exceed view range
UPDATE vBrendan
SET SomeText = 'Some non date text'
WHERE id = 999;


-- !! ERROR: Cannot create index on view 'vBrendan' because the view is not schema bound.
CREATE INDEX pkIndex 
ON vBrendan(id);

DROP VIEW IF EXISTS vBrendan;
GO

-- Note WITH SCHEMABINDING is on CREATE statement
CREATE VIEW vBrendan
WITH SCHEMABINDING 
AS
	SELECT Id, SomeText
	FROM dbo.Brendan
	WHERE Id < 100
	WITH CHECK OPTION;
GO

-- First index must be unique clustered else youo get an error message
-- Cannot create index on view 'vBrendan'. It does not have a unique clustered index.
CREATE INDEX pkIndex 
ON vBrendan(id);


-- This time it works
CREATE UNIQUE CLUSTERED INDEX pkIndex 
ON vBrendan(id);
GO

