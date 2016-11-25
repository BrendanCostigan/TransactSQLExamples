USE tempdb;
GO


IF OBJECT_ID('dbo.NormalTable', 'U') IS NOT NULL
	DROP TABLE dbo.NormalTable
GO

IF OBJECT_ID('dbo.SparseTable', 'U') IS NOT NULL
	DROP TABLE dbo.SparseTable;
GO

CREATE TABLE dbo.NormalTable
(
	A		INT,
	B		CHAR(255) NULL
)




CREATE TABLE dbo.SparseTable
(
	A		INT,
	B		CHAR(255) SPARSE NULL
)

SET NOCOUNT ON;

DECLARE @x	INT = 0;

WHILE @x < 100000
BEGIN

	IF (@x % 10 = 0)
	BEGIN
		INSERT dbo.NormalTable(A, B)
		VALUES (@x, REPLICATE('X', 255))
	END
	ELSE
	BEGIN
		INSERT dbo.NormalTable(A, B)
		VALUES (@x, NULL)
	END

	SET @x += 1;
END
GO

sp_spaceused 'dbo.NormalTable'
GO



SET NOCOUNT ON;

DECLARE @x	INT = 0;

WHILE @x < 100000
BEGIN

	IF (@x % 10 = 0)
	BEGIN
		INSERT dbo.SparseTable(A, B)
		VALUES (@x, REPLICATE('X', 255))
	END
	ELSE
	BEGIN
		INSERT dbo.SparseTable(A, B)
		VALUES (@x, NULL)
	END

	SET @x += 1;
END
GO


sp_spaceused 'dbo.SparseTable'



-- Tidy up

IF OBJECT_ID('dbo.NormalTable', 'U') IS NOT NULL
	DROP TABLE dbo.NormalTable
GO

IF OBJECT_ID('dbo.SparseTable', 'U') IS NOT NULL
	DROP TABLE dbo.SparseTable;
GO