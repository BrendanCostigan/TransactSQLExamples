-- On the instance with the resource on, in this case [HV-DEV\InstanceA]

USE tempdb;
GO

IF OBJECT_ID(N'dbo.Cities', N'U') IS NOT NULL
	DROP TABLE dbo.Cities;

CREATE TABLE dbo.Cities
(
	Id			INT IDENTITY(1, 1) PRIMARY KEY,
	CityName	NVARCHAR(255)
)


INSERT dbo.Cities (CityName)
VALUES	('London'),
		('Cardiff'),
		('Belfast'),
		('Edinburgh');


-- On the server doing the calling

sp_addlinkedserver [HV-DEV\InstanceA];

SELECT CityName
FROM OPENQUERY([HV-DEV\InstanceA], 'SELECT * FROM tempdb.dbo.Cities');