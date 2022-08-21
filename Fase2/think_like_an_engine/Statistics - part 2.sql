--- Query to get statistics on one table ---
SELECT so.name,
    st.name,
    st.stats_id,
    sc.stats_column_id,
    c.name as column_name,
    st.auto_created,
    st.filter_definition,
    sp.last_updated,
    sp.rows,
    sp.rows_sampled,
    sp.steps,
    sp.modification_counter
FROM sys.stats AS st
JOIN sys.stats_columns AS sc on st.object_id=sc.object_id and st.stats_id=sc.stats_id
JOIN sys.columns as c on sc.object_id=c.object_id and sc.column_id=c.column_id
JOIN sys.objects as so on st.object_id=so.object_id
CROSS APPLY sys.dm_db_stats_properties(st.object_id, st.stats_id) sp
WHERE so.name='Posts'
ORDER by so.name, st.stats_id, sc.stats_column_id;
GO


---- Explore Single column statistics -----
DBCC SHOW_STATISTICS('dbo.Users', '_WA_Sys_0000000A_09DE7BCC')
-- Que nos da?
-- - Header
-- - Density Vector
-- - Histograma

--76,74
SELECT Id FROM dbo.Users WHERE Reputation = 76 OPTION(RECOMPILE);

---- Explore Multiple (Single column) statistics -----
DBCC SHOW_STATISTICS('dbo.Posts', '_WA_Sys_00000010_060DEAE8')
DBCC SHOW_STATISTICS('dbo.Posts', '_WA_Sys_0000000D_060DEAE8')

-- Usar estimador de cardinalidad legacy
SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 9481, RECOMPILE);

-- Usar estimador de cardinalidad nuevo
SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 2312, RECOMPILE);

---- Explore Multiple column statistics -----
CREATE INDEX IX_PostTypeId_LastEditorUserId ON dbo.Posts(PostTypeId, LastEditorUserId)
-- En query de informacion de tablas va a aparecer indice dos veces
-- Todo porque esta en dos columnas

DBCC SHOW_STATISTICS('dbo.Posts', 'IX_PostTypeId_LastEditorUserId')

SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 9481, RECOMPILE);

SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 2312, RECOMPILE);

---- Filtered statistics -----
CREATE INDEX IX_LastEditorUserId_PostTypeId_PTYE2
ON dbo.Posts(LastEditorUserId, PostTypeId)
WHERE PostTypeId = 2;

DBCC SHOW_STATISTICS('dbo.Posts', 'IX_LastEditorUserId_PostTypeId_PTYE2')

SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 9481, RECOMPILE);



SELECT Id FROM dbo.Posts
WHERE PostTypeId = 2 AND LastEditorUserId = 41956  
OPTION(QUERYTRACEON 2312, RECOMPILE);

---- Ascending key problem -----

SET NOCOUNT ON;
GO
BEGIN TRAN
DECLARE @MaxId INT = 1;
SELECT @MaxId = MAX(Id)+1 FROM dbo.Posts;
INSERT dbo.Posts (Id, Body, CreationDate, LastActivityDate, OwnerUserId, PostTypeId, Score, ViewCount)
	VALUES (@MaxId, 'foo', '2013-09-06 11:58:38.690', '2013-09-06 11:58:38.690', 1, 2, 0, 0);
COMMIT
GO 20000
