USE tempdb;
GO

-- Compare the use of identity vs sequnece. Expected sequence to be faster due to the
-- use of a cache. However, this does not seem to be the case with the current setup.


IF OBJECT_ID('dbo.TestTable', 'U') IS NOT NULL
	DROP TABLE dbo.TestTable;
GO

DECLARE @maxcount INT = 1000000;

CREATE TABLE dbo.TestTable 
(
	A INT IDENTITY(1, 1),
	B DATETIME
)

DECLARE @count INT = 0;
DECLARE @start	DATETIME2 = SYSDATETIME();

SET NOCOUNT ON;

WHILE @count < @maxcount
BEGIN

	INSERT dbo.TestTable(B)
	VALUES (GETDATE());

	SET @count += 1;
END


SELECT CONCAT('Identity time taken ', DATEDIFF(ms, @start, SYSDATETIME()), 'ms') AS [Identity];
GO

IF OBJECT_ID('dbo.SequenceTest', 'SO') IS NOT NULL
	DROP SEQUENCE dbo.SequenceTest;
GO

CREATE SEQUENCE dbo.SequenceTest AS INT CACHE 10000;

IF OBJECT_ID('dbo.TestTable', 'U') IS NOT NULL
	DROP TABLE dbo.TestTable;
GO

CREATE TABLE dbo.TestTable 
(
	A INT DEFAULT (NEXT VALUE FOR dbo.SequenceTest),
	B DATETIME
)


DECLARE @count INT = 0;
DECLARE @start	DATETIME2 = SYSDATETIME();


DECLARE @maxcount INT = 1000000;

SET NOCOUNT ON;

WHILE @count < @maxcount
BEGIN

	INSERT dbo.TestTable(B)
	VALUES (GETDATE());

	SET @count += 1;
END


SELECT CONCAT('Sequence time taken ', DATEDIFF(ms, @start, SYSDATETIME()), 'ms') AS [Sequence];
