USE tempdb;
GO

-- Setup

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'LeftTable')
        DROP TABLE dbo.LeftTable;
GO

CREATE TABLE LeftTable
(
	City		VARCHAR(255)
)

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'RightTable')
        DROP TABLE dbo.RightTable;
GO

CREATE TABLE RightTable
(
	City		VARCHAR(255)
);


INSERT LeftTable
VALUES
	('London'),
	('Bristol'),
	('Exeter');

INSERT RightTable
VALUES
	('London'),
	('Bristol');



SELECT City FROM LeftTable
INTERSECT							--< Select of cities that are returned in both SELECT statements.
SELECT City From RightTable;


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'LeftTable')
        DROP TABLE dbo.LeftTable;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'RightTable')
        DROP TABLE dbo.RightTable;
GO