USE tempdb;
GO


IF OBJECT_ID(N'dbo.TestTable', N'U') IS NOT NULL
	DROP TABLE dbo.TestTable;

CREATE TABLE dbo.TestTable
(
	Id		INT NOT NULL,
	MyData	CHAR(1) NOT NULL
)

INSERT dbo.TestTable
VALUES	(1, 'A'),
		(1, 'B'),
		(2, 'C'),
		(3, 'D'),
		(4, 'E');


-- Note in the following the default SORT ORDER applies to the Id column
SELECT Id, MyData
FROM dbo.TestTable
ORDER BY Id, MyData DESC;

-- Note the need for the DESC on the first column
SELECT Id, MyData
FROM dbo.TestTable
ORDER BY Id DESC, MyData ASC;


-- Tidy up

IF OBJECT_ID(N'dbo.TestTable', N'U') IS NOT NULL
	DROP TABLE dbo.TestTable;