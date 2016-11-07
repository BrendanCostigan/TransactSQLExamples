USE tempdb;
GO

sp_dropmessage 60000;

EXEC sys.sp_addmessage @msgnum   = 60000,
					   @severity = 16,
					   @msgtext  = N'This is a test message with one numeric parameter (%d), one string parameter (%s), and another string parameter (%s).',
					   @lang = 'us_english'; 
GO

DECLARE @msg NVARCHAR(2048) = FORMATMESSAGE(60000, 500, N'First string', N'second string');			--< Constructs a message from an existing message in sys.messages or from a provided string. 

BEGIN TRY
	THROW 60000, @msg, 1;			--< THROW was introduced in SQL2012

END TRY
BEGIN CATCH
    PRINT 'In catch block.';
    THROW;
	PRINT 'After THROW.';			--< Note is not output
END CATCH;
