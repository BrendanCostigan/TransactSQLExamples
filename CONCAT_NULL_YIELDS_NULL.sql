-- Source: https://msdn.microsoft.com/en-us/library/ms176056.aspx

SET CONCAT_NULL_YIELDS_NULL ON

SELECT 'HELLO ' + NULL + 'WORLD' AS [CONCAT_NULL_YIELDS_NULL IS ON];

SET CONCAT_NULL_YIELDS_NULL OFF;

SELECT 'HELLO ' + NULL + 'WORLD' AS [CONCAT_NULL_YIELDS_NULL IS OFF];