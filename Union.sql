USE tempdb;
GO

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
UNION								--< Distinct select of cities in both tables. Duplicates removed.
SELECT City From RightTable
ORDER BY CITY;

SELECT City FROM LeftTable
UNION ALL							--< Select of cities in both tables. No deduplication.
SELECT City From RightTable
ORDER BY CITY;


-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'LeftTable')
        DROP TABLE dbo.LeftTable;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'RightTable')
        DROP TABLE dbo.RightTable;
GO
