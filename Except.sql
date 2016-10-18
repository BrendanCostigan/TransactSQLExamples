USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'LeftTable')
        DROP TABLE dbo.LeftTable;
GO

CREATE TABLE LeftTable
(
	City		VARCHAR(255),
	Population	INT
)

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'RightTable')
        DROP TABLE dbo.RightTable;
GO

CREATE TABLE RightTable
(
	City		VARCHAR(255),
	Population	INT
);


INSERT LeftTable
VALUES
	('London', 8673713),
	('Bristol', 449300),
	('Exeter', 124328);			--< Not in right table

INSERT RightTable
VALUES
	('London', 8673713),
	('Bristol', 449301);		--< One higher than in left table



SELECT City, Population FROM LeftTable
EXCEPT								--< Select of cities in the leftTable but not the right. So which table comes first is important.
SELECT City, Population From RightTable;



-- Tidy up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'LeftTable')
        DROP TABLE dbo.LeftTable;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'RightTable')
        DROP TABLE dbo.RightTable;
GO

