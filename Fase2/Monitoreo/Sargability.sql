--- Caso 1 ---
--- Opción 1 ---
SELECT Id
FROM dbo.Users
WHERE YEAR(LastAccessDate) = 2014
AND MONTH(LastAccessDate) = 7
ORDER BY LastAccessDate;

-- Se puede reescribir como
SELECT Id
FROM dbo.Users
WHERE LastAccessDate >= '2014/07/01'
AND LastAccessDate < '2014/08/01'
ORDER BY LastAccessDate;

CREATE INDEX IX_User_LastAccessDate on dbo.Users(LastAccessDate)

SELECT Id
FROM dbo.Users
WHERE LastAccessDate > '2014/09/09'
ORDER BY LastAccessDate;



--- Opción 2 --- 

ALTER TABLE dbo.Users ADD ActivityTime AS DATEDIFF(HH, 

--- Si no se puede reescribir, usar columna calculada y agregar indice a esa columna calculada.
CREATE INDEX IX_ActivityTime  ON dbo.Users(ActivityTIme);

SELECT  Id
FROM dbo.Users
WHERE DATEDIFF(HH, LastAccessDate, CreationDate) < 4;