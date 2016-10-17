USE tempdb;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'mytable' AND type = 'U')
	DROP TABLE dbo.mytable;
GO

CREATE TABLE dbo.mytable 
 ( 
   low int, 
   high int, 
   myavg AS (low + high)/ 2 PERSISTED                    --< Note persisted, means the values are stored and not calculated adhoc
);

-- Insert a row 
INSERT dbo.mytable (low, high)
VALUES (3, 5);

-- See the computed colum
SELECT * FROM dbo.mytable;

--  Update a column that influences the computed colunm
UPDATE dbo.mytable
SET high =  15;

-- Note that the computed column has been updated
SELECT * FROM dbo.mytable;

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'mytable' AND type = 'U')
	DROP TABLE dbo.mytable;
GO

CREATE TABLE dbo.mytable 
 ( 
   low int, 
   high int, 
   myavg AS (low + high) PERSISTED NOT NULL PRIMARY KEY			--< Note to have a key you must mark the column as PERSISTED
);


-- Tidy Up

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'mytable' AND type = 'U')
	DROP TABLE dbo.mytable;
GO

