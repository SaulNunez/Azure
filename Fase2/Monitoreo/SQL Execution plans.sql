--- QUERY 1 ---
SET STATISTICS IO ON; -- Puede venir en examen
-- Logical reads, paginas de 8k leidas
SELECT Id FROM dbo.Users;

--- QUERY 2 ---
SELECT Id FROM dbo.Users 
WHERE LastAccessDate > '2014/07/01';

--- QUERY 3 ---
SELECT Id FROM dbo.Users 
WHERE LastAccessDate > '2014/07/01'
ORDER BY LastAccessDate;

--- QUERY 4 ---
SELECT * FROM dbo.Users 
WHERE LastAccessDate > '2014/07/01'
ORDER BY LastAccessDate;

--- QUERY 5 -----
SELECT * FROM dbo.Users 
WHERE LastAccessDate > '2014/07/01'
ORDER BY LastAccessDate;
GO 100

--- QUERY 6 -----
SELECT Id, DisplayName, Age
FROM dbo.Users
WHERE LastAccessDate > '2014/07/01'
ORDER BY LastAccessDate;


---- QUERY 7 AND 8 VERSUS ---
SELECT Id, DisplayName, Age
FROM dbo.Users
WHERE LastAccessDate >= '2014/07/01'
AND LastAccessDate < '2014/08/01'
ORDER BY LastAccessDate;

-- De ser posible hay que evitar usar funciones
-- le quitan el sargeability
SELECT Id, DisplayName, Age
FROM dbo.Users
WHERE YEAR(LastAccessDate) = 2014
AND MONTH(LastAccessDate) = 7
ORDER BY LastAccessDate;


-- Hay que tener cuidado con LIKE
-- No es malo, pero si tiene inicio fijo impacto no tiene que ser tan malo
-- vs usar funci�n LEFT
SELECT Id FROM dbo.Users WHERE DisplayName LIKE 'Alex M%';
SELECT Id FROM dbo.Users WHERE LEFT(DisplayName, 6) = 'Alex M';

---- QUERY 9 VERSUS ---
SELECT Id, DisplayName, Age
FROM dbo.Users WITH (INDEX = IX_LastAccessDate_Id)
WHERE YEAR(LastAccessDate) = 2014
AND MONTH(LastAccessDate) = 7
ORDER BY LastAccessDate;
--- INDICE NC -----
CREATE INDEX
IX_LastAccessDate_Id
ON dbo.Users(LastAccessDate, Id)
INCLUDE (DisplayName, Age);


CREATE INDEX
IX_LastAccessDate_Id
ON dbo.Users(LastAccessDate, Id);