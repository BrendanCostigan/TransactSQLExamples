
-- Returns one of two values, depending on whether the Boolean expression evaluates to true or false in SQL Server.


SELECT IIF(1 = 1, 'True', 'False'); 

SELECT IIF(1 = 2, 'True', 'False'); 


-- IIF is non-standard and so CASE should be used

SELECT	CASE 1
			WHEN  1 THEN 'True'
			WHEN  2 THEN 'False'
		END


