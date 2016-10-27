-- Sourced from http://www.databasejournal.com/features/mssql/usage-and-benefits-of-using-with-result-sets-in-sql-server-2012.html


USE tempdb
GO

IF OBJECT_ID(N'[dbo].[Employee]', N'U') IS NOT NULL
       DROP TABLE [dbo].[Employee]
GO


IF OBJECT_ID(N'[dbo].[GetEmployees]', N'P') IS NOT NULL
       DROP PROCEDURE [dbo].[GetEmployees]
GO


IF OBJECT_ID(N'[dbo].[GetEmployeesWithMultipleResultsets]', N'P') IS NOT NULL
       DROP PROCEDURE [dbo].[GetEmployeesWithMultipleResultsets]
GO



CREATE TABLE [dbo].[Employee]
(
        [EmpId]   [INT]   NOT NULL IDENTITY PRIMARY KEY,
        [FirstName]  NVARCHAR(100) NOT NULL,
        [MiddleName]  NVARCHAR(100)  NULL,
        [LastName]  NVARCHAR(100)  NOT NULL,
)
GO

INSERT INTO [dbo].[Employee] (FirstName, MiddleName, LastName)
VALUES
       ('Arshad', NULL,'Ali'),
       ('Paul', 'M','John')
GO

CREATE PROCEDURE GetEmployees
AS
BEGIN
	SELECT EmpId, FirstName + ' ' + ISNULL(MiddleName, '') +' '+ LastName AS Name
	FROM dbo.Employee
END
GO

EXECUTE   GetEmployees
GO

EXECUTE   GetEmployees 
WITH RESULT SETS
(
       (
       EmployeeId INT,
       EmployeeName VARCHAR(150)
       ) 
)
GO

CREATE PROCEDURE GetEmployeesWithMultipleResultsets
AS
BEGIN

 SELECT EmpId, FirstName + ' ' + ISNULL(MiddleName, '') +' '+ LastName AS Name
 FROM dbo.Employee

 SELECT EmpId, FirstName + ' ' + ISNULL(MiddleName, '') +' '+ LastName AS Name
 FROM dbo.Employee

END
GO

EXEC GetEmployeesWithMultipleResultsets
GO

EXECUTE   GetEmployeesWithMultipleResultsets 
WITH RESULT SETS
(
       (
		   EmployeeId1 INT,
		   EmployeeName1 VARCHAR(150)
       ), 
       (
		   EmployeeId2 INT NOT NULL,
		   EmployeeFullName2 VARCHAR(150) NOT NULL
       ) 
)
GO


-- Tidy up

IF OBJECT_ID(N'[dbo].[Employee]', N'U') IS NOT NULL
       DROP TABLE [dbo].[Employee]
GO


IF OBJECT_ID(N'[dbo].[GetEmployees]', N'P') IS NOT NULL
       DROP PROCEDURE [dbo].[GetEmployees]
GO


IF OBJECT_ID(N'[dbo].[GetEmployeesWithMultipleResultsets]', N'P') IS NOT NULL
       DROP PROCEDURE [dbo].[GetEmployeesWithMultipleResultsets]
GO