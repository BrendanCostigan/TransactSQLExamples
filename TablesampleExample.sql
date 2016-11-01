USE tempdb;
GO

-- TABLESAMPLE: Works at page and not row level and so on small tables can either return all or no rows
-- YOu need a large sample table that have many pages of data.


IF OBJECT_ID('dbo.Cities', 'U') IS NOT NULL
	DROP TABLE dbo.Cities;


CREATE TABLE dbo.Cities
(
	City		VARCHAR(255)  NOT NULL,
	Population	INT NULL
)


INSERT dbo.Cities (City, Population)
VALUES
	('London', 8673713),
	('Bristol', 449300),
	('Bristol', 449300),			--< Note duplicate row
	('Hull', NULL),
	('Exeter', 124328);	

-- As the test table has only one page of data returns all or no records
SELECT * 
FROM dbo.Cities
TABLESAMPLE SYSTEM (2 ROWS);


SELECT * 
FROM dbo.Cities
TABLESAMPLE SYSTEM (10 PERCENT);