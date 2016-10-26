USE [AdventureWorks2014]
GO


-- Synonyms can refer to objects in other databases which makes your code cleaner
-- Synonyms do not support WITH SCHEMABINDING so can refer to objects that have changed or have been deleted


IF OBJECT_ID('dbo.MyProduct', 'SN') IS NOT NULL
	DROP SYNONYM [dbo].[MyProduct];
GO

CREATE SYNONYM dbo.MyProduct
FOR Production.Product;
GO
-- Query the Product table by using the synonym.
USE tempdb;
GO

SELECT ProductID, Name 
FROM dbo.MyProduct
WHERE ProductID < 5;
GO


IF OBJECT_ID('dbo.x', 'SN') IS NOT NULL
	DROP SYNONYM [dbo].[MyProduct];
GO

-- You can create a SYNONYM for an object that does not exist

CREATE SYNONYM dbo.Fake
FOR dbo.FantasyObject;
GO




-- ERROR: Cannot ALTER a table via a SYNONYM
ALTER TABLE dbo.MyProduct
	ADD test INT;





