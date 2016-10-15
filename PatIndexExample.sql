USE AdventureWorks2014;
GO

-- PATINDEX: Returns the starting position of the first occurrence of a pattern in a specified expression, or zeros if the pattern is not found, on all valid text and character data types.


-- Source: https://msdn.microsoft.com/query/dev14.query?appId=Dev14IDEF1&l=EN-US&k=k(PATINDEX_TSQL);k(sql13.swb.tsqlresults.f1);k(sql13.swb.tsqlquery.f1);k(MiscellaneousFilesProject);k(DevLang-TSQL)&rd=true

SELECT DocumentSummary 
FROM Production.Document 
WHERE DocumentNode = 0x7B40;

SELECT PATINDEX('%ensure%', DocumentSummary)
FROM Production.Document
WHERE DocumentNode = 0x7B40;
GO 

-- The _ character is a wildcard so we can use this to find 'bro' or 'bre' for example.
SELECT PATINDEX('%br_%', 'The quick brown fox jumps over a lazy dog.');  
