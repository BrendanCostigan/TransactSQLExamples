-- Source:
-- https://msdn.microsoft.com/en-us/library/ms173784.aspx
--
-- Returns the binary checksum value computed over a row of a table or over a list of expressions.
-- BINARY_CHECKSUM can be used to detect changes to a row of a table.

-- Note that this is, not surprisingly, case sensitive despite the collation,
-- in this case SQL_Latin1_General_CP1_CI_AS, being case insensitive

USE tempdb;
GO

IF OBJECT_ID (N'dbo.TestBINARY_CHECKSUM', N'U') IS NOT NULL
BEGIN
	DROP TABLE dbo.TestBINARY_CHECKSUM;
END


CREATE TABLE dbo.TestBINARY_CHECKSUM (column1 int, column2 varchar(256));
GO

-- Insert initial value
INSERT INTO TestBINARY_CHECKSUM VALUES (1, 'test');
GO
SELECT BINARY_CHECKSUM(*) from TestBINARY_CHECKSUM;
GO

-- Change the value and recalculate
UPDATE TestBINARY_CHECKSUM set column2 = 'TEST';
GO
SELECT BINARY_CHECKSUM(*) from TestBINARY_CHECKSUM;
GO


-- Put the original value back
UPDATE TestBINARY_CHECKSUM set column2 = 'test';
GO
SELECT BINARY_CHECKSUM(*) from TestBINARY_CHECKSUM;
GO
