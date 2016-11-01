 --
-- http://www.techsapphire.in/index/learn_hierarchies_in_sql_server_using_hierarchyid/0-173
-- Same video on YouTube https://www.youtube.com/watch?v=koI08v7Hwd8
--

USE tempdb;
GO


DECLARE @hid HIERARCHYID;

SET @hid = '/1/2/3/';

SELECT @hid as [HierarchyID]
-- ToString and CAST on hierarchy id
SELECT @hid [Var Binary], @hid.ToString() [As String], CAST(@hid AS VARCHAR) [As String by CAST];

--GetAncestor(nth) on hierarchy id
SELECT	 @hid.ToString()
		,@hid.GetAncestor(1).ToString() [Parent]
		,@hid.GetAncestor(2).ToString() [Grand Parent]
		,@hid.GetAncestor(3).ToString() [Root]
		,@hid.GetAncestor(4).ToString() [No Parent];


IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL
	DROP TABLE #TEMP;

WITH CTE(chain, NAME) AS (
		SELECT CAST('/1/' AS HIERARCHYID), 'Ram'
		UNION ALL
		SELECT '/2/', 'Ron'
		UNION ALL
		SELECT '/1/1/', 'Sahil'
		UNION ALL
		SELECT '/1/2/', 'Mohit'
		UNION ALL
		SELECT '/2/1/', 'Maze'
		UNION ALL
		SELECT '/', 'Boss'
)
SELECT *
INTO #TEMP
FROM CTE;

--INSERT INTO #TEMP VALUES('/1/2/1/','Don')
SELECT *, chain.ToString()
FROM #TEMP

--GetRoot, GetLevel() on hierarchyid
SELECT NAME
	,chain
	,chain.ToString() [String Value]
	,HIERARCHYID::GetRoot().ToString() [Root]
	,chain.GetLevel() [Level]
FROM #TEMP
ORDER BY chain.GetLevel();

--IsDescendantOf(node) on hierarchyid
DECLARE @node HIERARCHYID

SET @node = '/1/';

SELECT NAME
	,chain
	,chain.ToString() [String Value]
	,HIERARCHYID::GetRoot().ToString() [Root]
	,chain.GetLevel() [Level]
FROM #TEMP
WHERE chain.IsDescendantOf(@node) = 1
	AND chain != @node
	AND chain.GetLevel() = @node.GetLevel() + 1
ORDER BY chain.GetLevel()

--GetDescendant() on hierarchyid
--DECLARE @leftNode HIERARCHYID
--DECLARE @rightNode HIERARCHYID

--SET @leftNode = '/2/1/';
--SET @rightNode = '/2/1/';

--WITH CTE (node)
--AS (
--	SELECT @leftNode.GetAncestor(1).1(MAX(@rightnode), NULL) [GeneratedID]
--	)
--SELECT node
--	,'More'
--FROM CTE

--GetReparentedValue(oldNode,newNode) on hierarchyid
--DECLARE @oldNode HIERARCHYID
--	,@newNode HIERARCHYID

--SET @oldNode = '/1/';
--SET @newNode = '/2/3/';

--SELECT chain.ToString() [OldNode]
--	,NAME
--	,chain.GetReparentedValue(@oldNode, @newNode).ToString() [NewNode]
--FROM #TEMP
--WHERE chain.IsDescendantOf(@oldNode) = 1

-- Tidy up

IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL
	DROP TABLE #TEMP;
