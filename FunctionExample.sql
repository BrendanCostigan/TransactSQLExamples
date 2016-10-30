USE tempdb;
GO

-- Scalar function
IF OBJECT_ID('dbo.fn_GetDate', 'FN') IS NOT NULL --< Note object type is 'FN'
	DROP FUNCTION dbo.fn_GetDate;
GO

CREATE FUNCTION fn_GetDate (@date DATETIME) --< Convert DATETIME to DATE
RETURNS DATE
AS
BEGIN
	RETURN (CONVERT(DATE, getdate()));
END
GO

SELECT dbo.fn_GetDate(CURRENT_TIMESTAMP);

-- Table function example
IF OBJECT_ID('dbo.LeftTable', 'U') IS NOT NULL
	DROP TABLE dbo.LeftTable;
GO

CREATE TABLE dbo.LeftTable 
(
	Id		INT IDENTITY,
	City	VARCHAR(255)
)

INSERT dbo.LeftTable
VALUES	('London'),
		('Bristol'),
		('Bath'),
		('Exeter');
GO

-- Inline Table-Valued Function Syntax 
IF OBJECT_ID('dbo.fn_GetCitiesIF', 'IF') IS NOT NULL --< Note object type is 'IF'
	DROP FUNCTION dbo.fn_GetCitiesIF;
GO

CREATE FUNCTION dbo.fn_GetCitiesIF (@cityPrefix VARCHAR(255)) --< Note paramter is prefixed with an 'at' sign
RETURNS TABLE
AS
RETURN
(
	SELECT City
	FROM dbo.LeftTable
	WHERE City LIKE (@cityPrefix + '%')
)
GO

SELECT * FROM dbo.fn_GetCitiesIF('B');			--< As it is a table function we need to return the values with a SELECT followed by the column names or the '*'


-- Now this gets a bit weird, we can insert a record against the underlying table even when it would not appear in the resultset. 
INSERT dbo.fn_GetCitiesIF('Bristol')
SELECT 'York';

SELECT * FROM dbo.LeftTable;					--< Note 'York' is included in the results		

IF OBJECT_ID('dbo.fn_GetCitiesTF', 'TF') IS NOT NULL	--< Note object type is 'IF'
	DROP FUNCTION dbo.fn_GetCitiesTF;
GO

-- Multistatement Table-valued Function Syntax
CREATE FUNCTION dbo.fn_GetCitiesTF (@cityPrefix VARCHAR(255)) --< Note paramter is prefixed with an 'at' sign
RETURNS @cities TABLE 
(
	Id			INT,
	CityName	VARCHAR(255)
)
AS
BEGIN
	INSERT @cities
	SELECT	Id,
			City
	FROM dbo.LeftTable
	WHERE City LIKE (@cityPrefix + '%');

	RETURN
END
GO

SELECT * 
FROM dbo.fn_GetCitiesTF('B');
GO

-- User defined functions cannot create or access temporary tables

--CREATE FUNCTION dbo.fn_WillNotWorkTF (@cityPrefix VARCHAR(255)) --< Note paramter is prefixed with an 'at' sign
--RETURNS @cities TABLE 
--(
--	Id			INT,
--	CityName	VARCHAR(255)
--)
--AS
--BEGIN
	
--	CREATE TABLE #MyTempTable				--< Generates error
--	(
--		A	INT
--	)
	
--	INSERT @cities
--	SELECT	Id,
--			City
--	FROM dbo.LeftTable
--	WHERE City LIKE (@cityPrefix + '%');

--	RETURN
--END
--GO



-- Tidy up
IF OBJECT_ID('dbo.fn_GetDate', 'FN') IS NOT NULL --< Note object type is 'FN'
	DROP FUNCTION dbo.fn_GetDate;
GO

IF OBJECT_ID('dbo.LeftTable', 'U') IS NOT NULL
	DROP TABLE dbo.LeftTable;
GO

IF OBJECT_ID('dbo.fn_GetCitiesIF', 'IF') IS NOT NULL --< Note object type is 'IF'
	DROP FUNCTION dbo.fn_GetCitiesIF;
GO

IF OBJECT_ID('dbo.fn_GetCitiesTF', 'TF') IS NOT NULL	--< Note object type is 'IF'
	DROP FUNCTION dbo.fn_GetCitiesTF;
GO


