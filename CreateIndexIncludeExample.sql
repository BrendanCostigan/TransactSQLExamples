USE AdventureWorks2012;
GO


IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Address_PostalCode')
	DROP INDEX [IX_Address_PostalCode] ON [Person].[Address]
GO

-- Creates a nonclustered index on the Person.Address table with four included (nonkey) columns. 
-- index key column is PostalCode and the nonkey columns are
-- AddressLine1, AddressLine2, City, and StateProvinceID.
CREATE NONCLUSTERED INDEX IX_Address_PostalCode
ON Person.Address (PostalCode)
INCLUDE (AddressLine1, AddressLine2, City, StateProvinceID);
GO
