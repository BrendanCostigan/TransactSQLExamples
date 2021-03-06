
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
	('Bristol', 449300),			--< Note duplicate row
	('Hull', NULL),
	('Exeter', 124328);			


--< Note when specifiying a column NULL values are excluded
--< Note you can not specify COUNT(DISTINCT *)
SELECT COUNT(*) AS RowsCount, COUNT(Population) AS NotNullPopulationCount, COUNT(DISTINCT Population) AS DistinctNotNullPopulationCount FROM dbo.Cities;	


-- Tidy up

IF OBJECT_ID('dbo.Cities', 'U') IS NOT NULL
	DROP TABLE dbo.Cities;
