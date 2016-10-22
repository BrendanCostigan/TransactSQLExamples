
-- Source: http://stackoverflow.com/questions/7747327/sql-rank-versus-row-number
--		   https://msdn.microsoft.com/en-us/library/ms189798.aspx

WITH T(ID, StyleID)
     AS (SELECT 1, 1 UNION ALL
         SELECT 1, 1 UNION ALL
         SELECT 1, 1 UNION ALL
         SELECT 2, 1 UNION ALL
		 SELECT 2, 2)
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY StyleID ORDER BY ID) AS 'ROW_NUMBER',	--< Returns the rank of rows within the partition of a result set, without any gaps in the ranking. The rank of a row is one plus the number of distinct ranks that come before the row in question.
       RANK() OVER(PARTITION BY StyleID ORDER BY ID)       AS 'RANK',		--< Returns the rank of each row within the partition of a result set. The rank of a row is one plus the number of ranks that come before the row in question.
       DENSE_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS 'DENSE_RANK',	--< Returns the sequential number of a row within a partition of a result set, starting at 1 for the first row in each partition.
	   NTILE(4) OVER(PARTITION BY StyleID ORDER BY ID) AS 'NTILE'	--< Distributes the rows in an ordered partition into a specified number of groups. The groups are numbered, starting at one. For each row, NTILE returns the number of the group to which the row belongs.
FROM   T