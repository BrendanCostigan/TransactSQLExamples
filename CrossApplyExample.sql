-- Requires SQL2016+ due to DROP IF EXISTS

USE tempdb;
GO

DROP TABLE IF EXISTS LeftTable;

CREATE TABLE LeftTable
(
	ColOne		INT
)

DROP TABLE IF EXISTS RightTable;


CREATE TABLE RightTable
(
	ColOne		CHAR(1)
)

INSERT LeftTable VALUES (1), (2), (3);

INSERT RightTable VALUES ('A'), ('B'), ('C');

SELECT lt.ColOne AS 'LeftTableColOne', rt.ColOne AS 'RightTableColOne'
FROM LeftTable lt
CROSS APPLY RightTable rt


-- Tidy up

DROP TABLE IF EXISTS LeftTable;

DROP TABLE IF EXISTS RightTable;
