USE tempdb;
GO

SELECT GETDATE() AS [GETDATE];							--< Transact SQL specific 
SELECT CURRENT_TIMESTAMP AS [CURRENT_TIMESTAMP];		--< SQL standard so maybe should be used however ...


-- If we run the following CREATE TABLE
CREATE TABLE [dbo].[TestTable](
	[DateTimeOfOrder] [datetime] NOT NULL DEFAULT (CURRENT_TIMESTAMP)
)
GO

--- ... and then script it out we get (note that the CURRENT_TIMESTAMP has been changed to a getdate() 
/*
CREATE TABLE [dbo].[TestTable](
	[DateTimeOfOrder] [datetime] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TestTable] ADD  DEFAULT (getdate()) FOR [DateTimeOfOrder]
GO
*/

