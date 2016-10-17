USE tempdb;
GO

-- Consider using OFFSET-FETCH as it is a SQL standard whilst TOP is not,
-- however OFFSET-FETCH does not support PERCENT and WITH TIES.

IF OBJECT_ID('#temp') IS NOT NULL
	DROP TABLE #temp;

CREATE TABLE #temp
(
	Id			INT IDENTITY(1, 1),
	TextValue	VARCHAR(255)
)


INSERT #temp (TextValue)
VALUES	('AAA'),
		('BBB'),
		('BBB'),
		('CCC');


SELECT TOP (2) TextValue
FROM #temp;


-- With TIES has to have an ORDER BY and may return more values that the TOP numbers

SELECT TOP (2) WITH TIES TextValue	
FROM #temp
ORDER BY TextValue;