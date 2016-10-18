
USE tempdb;
GO


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
	('Hull', NULL),
	('Exeter', 124328);			


SELECT COUNT(*) AS RowsCount, COUNT(Population) AS NotNullPopulationCount FROM dbo.Cities;	--< Note when specifiying a column NULL values are excluded


-- Tyidy up

IF OBJECT_ID('dbo.Cities', 'U') IS NOT NULL
	DROP TABLE dbo.Cities;
