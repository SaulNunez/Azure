# Query tuning

## Index Tuning
1. Analizar uso de indices actuales
    * `sys.dm_db_index_operational_stats`
    * `sys.dm_db_index_usage_stats`
2. Eliminar indices poco usados
3. Evaluar queries mas usadas y con mayor consumo de recursos
4. Crear índices o reescribir la query y evaluar rendimiento
5. Implementar cambios en el entorno de producción
6. (Extra, no de la certificación) Monitorear query para no agregar regresiones o que tenga problemas.

### Indíces de tabla
```sql
SELECT I.Name, U.* FROM sys.dm_db_index_usage_stats AS U
LEFT OUTER JOIN sys.indexes AS I ON I.object_id = U.object_id
AND I.index_id = U.index_id
WHERE U.object_id = OBJECT_ID('dbo.Posts');
```
### Optimizar queries
```sql
SELECT  U.DisplayName,
        U.Reputation,
        P.id,
        P.AnswerCount,
        P.ViewCount,
        P.tags,
        P.CreationDate
FROM dbo.Posts AS P
        INNER JOIN
        dbo.Users AS U
        ON P.OwnerUserId = U.Id
ORDER BY P.CreationDate
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
```

```sql
WITH ShowPosts(id, 
        AnswerCount, 
        ViewCount, 
        Tags, 
        CreationDate, 
        OwnerUser)
AS
(
SELECT
        id,
        AnswerCount,
        ViewCount,
        tags,
        CreationDate
FROM dbo.Posts
ORDER BY P.CreationDate
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY
);

SELECT  U.DisplayName,
        U.Reputation,
        P.id,
        P.AnswerCount,
        P.ViewCount,
        P.tags,
        P.CreationDate
FROM ShowPosts AS P
        INNER JOIN
        dbo.Users AS U
        ON P.OwnerUserId = U.Id
ORDER BY P.CreationDate;
```

Usamos CTEs, hacemos que deje de usar mucha memoria uniendo las tablas antes de hacer la operación y se reduce consumo de CPU. Tambien desaparece la degradación de rendimiento cuando el offset es muy grande (pero no entendi como funciona eso).

## Resumable indexes
Al crear indice:
```sql
CREATE INDEX IX_Customer_PersonID_ModifiedDate
    ON Sales.Customer (PersonId, StoreID, TerritoryID, AccountID, ModifiedDate)
WITH (RESUMABLE = ON, ONLINE = ON)
GO
```

```sql
ALTER INDEX IX_Customer_PersonID_ModifiedDate ON Sales.Customer PAUSE
GO
```
* Si es un indice pesado, `online` hace que se ejecute en el fondo su creación.
* `PAUSE`, permite pausar la actualización del índice.
* `sys.index_resumable_operations`, permite ver que índices se pueden pausar y su estatus.

## Join Operators
### Nested Loops
Busca contenido de outer input en el primer input.
![Busca contenido de outer input en el primer input](https://bertwagner.com/wp-content/uploads/2018/12/Nested-Loop-Join-50fps-1.gif)

* Cuando esta ordenada la tabla, no tiene que recorrer la tabla.
* Necesita cargar los renglones a memoria.

#### Ventajas
* Es muy recomendable cuando el numero de renglones es bajo.

#### Desventajas
* Si aumenta numero de renglones, el uso de CPU aumenta y requerira un alto numero de memoria.

### Merge Join
![Ambas tablas se mueven a la vez](https://www.sqlservercentral.com/wp-content/uploads/legacy/edcf5cefcb5afa8a853234e82b478bd924894fce/Merge-Join-1.gif)

* Entradas tienen que estar ordenadas, solo recorre la tabla una vez. Es la mas eficaz.
* Se puede usar `INNER LOOP JOIN` para forzarlo.
* Necesita cargar en memoria.

#### Ventajas
* Es la operación más eficaz.

#### Desventajas
* Entradas tienen que estar ordenadas.
* Es dificil de usarlos en datasets muy grandes porque lo une a memoria.

### Hash Match
![](https://bertwagner.com/wp-content/uploads/2018/12/Hash-Match-Join-Looping-1.gif)

* Puede usar TempDb
* Usa una funcion de hashing
* Compara matches de hashes creados

### Ventajas
* Se puede usar para todas las comparaciones de igualdad.
* Sin importar tamaño del dataset.

#### Desventajas
* Cuando tenga que hacer uso de TempDb ocurrira una degradación en el rendimiento de la query.


### Que hacer cuando SQL Server esta eligiendo una operación no muy adecuada para joins?
1. Actualizar estadísticas
2. Crear indíce para mejorar esta unión

## Query Hints
* `OPTION (FAST n)`, primero regresa esa cantidad, antes de continuar la operación.
* `OPTIMIZE FOR`, optimiza para un valor de variable específico.
* `USE PLAN`, usa plan específico.
* `RECOMPILE`, crear un nuevo plan y lo descarta después de la ejecución.
* `{LOOP|MERGE|HASH} JOIN`, específica tipo de operación a realizar.
* `MAXDOP n`, específica el valor máximo de paralelismo.

## Query Store Hints (in Azure SQL Database only, not yet in SQL Server)
* No recomendado en queries en producción, dado que no se usarian optimizaciones agregadas a versiones posteriores de la base de datos.
* Para este query id, quiero que uses cierto tipo de opciones. 
* Para ser usando cuando en nuestra aplicación hacemos uso de un ORM, por ejemplo.

```sql
SELECT q.query_id, qt.query_sql_text
FROM sys.query_store_query_text qt
    INNER JOIN sys.query_store_query q
        ON qt.query_text_id = q.query_text_id
WHERE query_sql_text like N'%ORDER BY CustomerName DESC%'
    AND query_sql_text not like N'%query_store%'
GO

--- Assuming the query_id returned by the previous query is 42
EXEC sys.sp_query_store_set_hints @query_id=42, @query_hints = N'OPTION(RECOMPILE, MAXDOP 1)'
GO
```

## Particionado
* Disponible en SQL Server Enterprise, SQL Server Developer (para pruebas) y Azure SQL Database.

### Particionado vertical
Si hay una tabla, se divide de manera vertical, de manera que tengamos algunas columnas en una tabla y otras columnas en otra.

[Ejercicio](./ParticionadoVertical.ipynb)

### Particionado horizontal
* Segmentar información a base de filas, como reportes de enero, reportes de febrero, etc.
* Para cantidades muy grandes de datos
* Requiere mantenimiento constante.
* Para cargar OLAP, no es muy recomendado.
* Util para cargas OLTP, mejora operaciones de lectura.
* Se puede realizar usando *Microsoft SQL Server Management Studio* en **Create Partition Wizard**
* Si el numero es menor a un millon de renglones por partición, las ventajas de rendimiento no se veran materializadas al nivel esperado.
* Si esta arriba de 10 millones, vale la pena.

[Ejercicio](./HorizontalPartition%20-%20table.sql)

## Partition Switching
[Ejercicio](./PartitionSwitching.ipynb)

* Es importante que para alter switch tanto origen como destino tengan los mismo contraints y definición de columnas (nombre y tipo).
* Tabla target tiene que estar vacia para `ALTER SWITCH`
* Para cargas de datos
