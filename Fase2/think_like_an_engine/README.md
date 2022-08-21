# Think like an engine

## Operadores de lectura
* Table scan
* Clustered index scan
* NonClustered index scan
* NonClustered index seek

## Pasos de ejecucion
[Ejercicio](./SQL%20Execution%20plans.sql)

* Parse, arbol **sintactico** de la operación. Solo checa que tenga sentido, no que se pueda ejecutar, ej. tablas que no existen.
* Bind, revisa **semanticamente** que nuestra query tenga sentido. Conecta objetos de nuestra query a elementos de nuestra base de datos. 
* Optimize, buscar si hay planes simples que ya cumplan con esta query.
    3. Verificacion de planes en cache
    4. Creacion de plan de ejecucion basado en costo
        * Optimizar query
    5. Ejecución del plan

## Statistics
[Ejercicio](./Statistics%20-%20part%202.sql)

Probablemente en examen:
```sql
SET STATISTICS IO ON;
```
Paginas de 8k leidas al ejecutar query.

```sql
SHOW PLAN ON;
```
Nos muestra el plan de ejecucion de la query. 

```sql
SET STATISTICS PROFILE ON;
```

Similar al anterior, pero tiene información de la ejecución real, como numero de filas regresadas.

Estimated subtree cost: 
Crea distintos planes de ejecucion si no tiene una forma sencilla de hacer operación.

Cosas en cache:
* Planes de ejecucion
* Paginas de datos
* Algunas veces, indices

Covering index: 
es un indice que contiene todas las columnas para una consulta.

Sargability: 
puede utilizar el indice dadas las formas que construimos el indice y usar seek.   

Index scan:
Lee desde el principio.   
Index seek:
Se pasa hasta que empiezen los valores que necesita.   
Es mejor reescribir *query* para evitar usar funciones.
Obtener statistics que SQL Server tiene para nuestra tabla:
```sql
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
```
## Bloqueo
Blocking LCK* WAITS
Espera tiempo indefinido, hasta que este disponible el recurso.

### Tipos de bloqueos
* Base de datos
* Tabla
* Pagina
* Fila

### Lock scalation
Si el espacio ocupado por un tipo de bloqueo menor es mas grande que el recurso superior, bloquea el siguiente tipo de bloqueo. Ej. si se bloquean muchas filas, SQL Server bloquea toda la tabla.

### Resource mode
(X) Exclusive: Nadie puede leer ni modificar. Para operaciones de borrado, actualizaciones o insercion.
(S) Shared: A nivel de pagina o renglon, se pone cuando se esta leyendo un recurso. Pueden llegar otras operaciones de lectura y agregar sus bloqueos.
(U) Update: Todavia no bloqueo, pero cuando deje de haber bloqueos shared, se cambiara a exclusive.
(I) Intent: Como que queremos bloquear algo con tipo exclusive.

### DEADLOCKS
Si hay queries que se bloqueen mutuamente porque dependen en recursos que ambas tiene bloqueados.

### No Lock
* Visualizacion de data antes de commit
* Renglones duplicados
* Renglones saltados
* Posibilidad de excepción durante ejecución

## Isolation levels
56.30 20 ago

Propiedades  | Read Committed Snapshot Isolation | Snapshot Isolation
--- | --- | ---
Abrevacion | RCSI | Snapshot
Nivel de efecto | Base de datos | Transacción
Version recuperada | La mas reciente en TempDB | La mas reciente al incio de la transaccion en TempDB
Operaciones | Lectura | Todas

## Parameter sniffing
### Soluciones
#### Recompilar el query cada vez que se necesite
```sql
CREATE PROC dbo.usersByReputation
    @reputation int
AS
    SELECT * FROM dbo.Users WHERE Reputation = @reputation OPTION(RECOMPILE);
GO
```
Contra: Para SQL Server 2008-2014, hay bugs donde con option recompile llegan repuestas que no eran lo que habia pedido.

#### Optimizar para desconocido
```sql
CREATE PROC dbo.usersByReputation
    @reputation int
AS
    SELECT * FROM dbo.Users WHERE Reputation = @reputation OPTION(OPTIMIZE FOR UNKNOWN);
GO
```
Contra: Util cuando los valores estan distribuidos de manera equitativa.

#### Optimizar para una variable
```sql
CREATE PROC dbo.usersByReputation
    @reputation int
AS
    SELECT * FROM dbo.Users WHERE Reputation = @reputation OPTION(OPTIMIZE FOR (@reputation = 1));
GO
```
Contra: Problema, intimamente relacionado a la lógica de negocio.

#### 
```sql
CREATE PROC dbo.usersByReputation_1
    @reputation int
AS
    SELECT * FROM dbo.Users WHERE Reputation = @reputation;
GO

CREATE PROC dbo.usersByReputation_other
    @reputation int
AS
    SELECT * FROM dbo.Users WHERE Reputation = @reputation;
GO


CREATE PROC dbo.usersByReputation
    @reputation int
AS
    IF @reputation = 1
    BEGIN
        EXEC dbo.usersByReputation_1 @reputation;
    END
    ELSE
    BEGIN
        EXEC dbo.usersByReputation_other @reputation;
    END
GO
```
Contra: Mete lógica de negocio y asume algunas cosas.

#### Covering index
```sql
CREATE INDEX IX_REPUTATION_LAD ON db.Users(Reputation) INCLUDE (LastAccessDate);

CREATE PROC dbo.usersByReputation
    @reputation int
AS
    SELECT LastAccessDate FROM dbo.Users WHERE Reputation = @reputation;
GO

```


### DMVs
DMV | Uso
--- | ---
sys.dm_exec_cached_plans | Planes de ejecución en cache, planes estimados
sys.dm_exec_sessions | Sesiones en SQL Server
sys.dm_exec_connections | Conexiones en SQL Server
sys.dm_index_usage_states | Seeks, scans y lookups por indices
sys.dm_io_virtual_file_stats | Estadisticas de escritura y lectura
sys.dm_tran_active_transactions | Estados de las transacciones en el servidor
sys.dm_exec_sql_text | Texto T-SQL de consultas (Función)
sys.dm_exec_query_plan | Plan de ejecución XML (Función)
sys.dm_os_performance_counters | Contadores relacionados con SQL Server
sys.dm_resource_stat | Información de recursos en Azure SQL Database


## Tipos de espera
Tipos | Descripción
--- | ---
RESOURCE_SEMAPHORE | Indica que la query está esperando a que se le asigne memoria para poder ejecutarse
LCK_M_X y LCK* | Indican que están esperando debido a bloqueos en los recursos que van a utilizar
PAGEIOLATCH_SH | Indica esperas para los procesos de lectura y escritura. Numero de ocurrencias bajo y duracion de ocurrencias altas: Problemas en dispositivo almacenamiento. Numero de ocurrencias alto y duracion de ocurrencias bajo: Muchas operaciones scan
SOS_SCHEDULER_YIELD | Indica alto uso de CPU
CX_PACKET | Indica uso de paralelismo en las queries.    Si el numero demasiado alto o el limite de costo para el uso de paralemismo es muy bajo es probable que queries simples son paralelizasas lo que reduce la concurrencia.
PAGEIOLATCH_UP | Indica problemas de lectura y escritura asociadas con las queries.   En versiones <2017 significa problemas de contención en TempDB.   Hoy en dia significa problemas de almacenamiento

## Kahoot
* Seek es solo mejor que scan cuando hay pocos renglones.
* Maximum number of stemps in a statistics histogram: 200
* Number of rows for lock scalation to ocurr: 5000
* Intellifent Query processing: 2019
* Adaptative Query processing: 2017