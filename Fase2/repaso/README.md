# Repaso de query store y query tuning

## Table Scan
No tenemos ordenada la información de ninguna manera.

## Clustered Index Scan
La informacion esta ordenada de alguna forma, lee algunas columnas, pero no lee todos los renglon.

## Operaciones de un Query
1. Parse
2. (Bind) Relacionar los objetos de la base de datos
3. Optimización, crear plan de ejecución
    1. Plan de ejecucion estimado
    2. Plan de ejecucion actual

## Inputs de optimizer
1. Arbol sintactico
2. Lista de indices posibles a usar
3. Información de estadísticas

## Planes de ejecución
Ver con mas detalle grabacion
* Determina costo de la operacion
* Define si corre de manera paralela
* Crea varios planes de ejecución y elije el de menor costo
* Como los leemos:
    * De derecha a izquierda, enfocado en datos.
    * De izquierda a derecha, de forma lógica, como si fueran iteradores.

## Clustered seek
Se va a pasar cierta cantidad de renglones y empezara a leer.

## Siempre es mejor seek que scan?
Puede que tengamos un seek porque tengamos un plan mal diseñado.

## Statistics
Auto create y auto update statistics estan encendidos por default en SQL Server y Azure SQL.

### Cada cuando se actualizan las estadisticas?
Se recomienda proceso automatizado para actualizar estadisticas cada cierto tiempo.

### Diferencia estimador de cardinalidad

## Blocking and locking
### Blocking
Si nosotros usamos un recurso, generalmente este se bloquea para que seamos los unicos usandolo y no se modifique mientras lo usamos.

#### Solucionar problemas de bloqueo
1. Crear indices.
2. Usar el valor correcto de aislamiento para nuestra base de datos.

#### NOLOCK
* Visualizacion de datos antes de commit
* Renglones duplicados
* Renglones saltados
* Posibilidad de excepción durante ejecución

## Isolation levels
Al cambiar nivel de isolacion estamos haciendo el tradeback a consistencia eventual.

* RCSI, a nivel base de datos, bloqueos en lectura.
* Snapshot isolation, por cada transacción.

## Sargability
Por alguna razon no se puede usar seek en la consulta y usa scan, aunque deberiamos poder usar seek.
Hay veces donde ocurre esto por usar funciones al escribir nuestra query.

## Parameter sniffing
//TODO: Ver donde ocurre

### Soluciones
* OPTION (RECOMPILE)
* OPTION (OPTIMZE FOR UNKNOWN)
* OPTION (OPTIMIZE FOR @reputation=#)
* Branching logic

## Intelligent Query Processing
* Adaptive Joins, puede cambiar tipo de join a realizar si es mas conveniente
* Interleaved Execution, multistate value function
* Memory Grant Feedback, se ejecuta la query, si query se queda sin memoria, en siguientes ejecuciones se le da un poco mas de lo esperado.
* Revisar nivel de compatibilidad >= 150

## Adaptative Query Processing
* Table Variable Deferred Compilation,
* Batch Mode on Rowstore
* T-SQL Scalar UDF Inlining, funciones que afectan cada renglon son paralelizadas.
* Approximate Count Distinct, 
* Revisar nivel de compatibilidad >= 140

## Nivel de compatibilidad
Esto nos asegura la forma del plan de ejecución. En teoria el tiempo es similar entre versiones pero no es asegurado. También se mantiene compatibilidad de sintaxis, SQL Server hasta 2014.

## Dynamic Management View

## Common wait types
* PAGEIOLATCH_SH, si es muy alta y pocas veces, almacenamiento esta fallando.
* SOS_SCHEDULER_YIELD, indica uso alto de CPU. Muchas razones por lo que pudiera ocurrir. Tal vez muy pocos nucleos para la carga de trabajo.
*  CXPACKET, es normal su ocurrencia. Significa que espera que otro thread termine su trabajo. Si es muy alto, el limite de costo para paralelismo es muy bajo.
* PAGEIOLATCH_UP, indica problemas de lectura y escritura asociadas a las queries. En SQL Server 2017, significa problemas de contención en TempDB.

## Denormalización
### Snowflake schema
* Diseño desentralizado
* Hay redundancia.
* Pero velocidad de consulta es alta.

## Disk Based Rowstore
Clustered, Almacena fisicamente datos en orden
Non-clustered, crear un indice separado usando un arbol binario balanceado.

## Número de renglones mínimo para poder usar optimización de inserción en columnstore indexes
1024

## Query Store
* Almacena plan de ejecución, estadísticas de ejecucion, estadísticas de espera ( a nivel de query).
* Almacena de manera asincrona.
Query runtime statistics hace *data flush* cada cierto tiempo (definido por el usuario).
* Plan de query se guardado inmediatamente, pero de manera asíncrona.
* Query store esta activado por defecto en Azure SQL. No se puede desactivar.
* On premises on en maquina virtual, Query store NO esta activado por defecto en SQL Server.

## Performance tuning
1. Analizar uso de indices
2. Eliminar indices poco usados o duplicados
3. Evaluar queries mas usadas y con mayor consumo de recursos usando QS o eventos extendidos
4. Crear indices o reescribir la query
5. Implementar cambios

## Resumable index
Se puede pausar o reanudar creación de un indice.

## Online
Si online esta `OFF`, no se puede usar mientras se esta reconstruyendo. En `ON` se usan los valores anteriores en lo que se crea.

## Monitoreo base de datos
### Azure SQL Insights
Usa Azure SQL Analytics, para obtener informacion del rendimiento a alto nivel.

### Database tuning advisor
Si crear o borrar indice
Si usar plan anterior

## TempDB
100-150 dtus ~ 1 maquina virtual
Temp DB, cada archivo son de 32 GB

## Resource governor
### Funcion clasificadora
Usa usuario, base de datos, etc. para determinar a cual carga de trabajo pertenece una consulta.

11.34 detalles de columnas

## Indices
### Rebuild y reorganizar
* Rebuild, reconstruye el indice. Actualiza estadisticas de nuestros indices. >30%. Online u offline. Capacidad de determinar fillfactor, espacio adicional para usar ante el crecimiento de la tabla.
* Reorganize, ordena nuestro indice, pero no cambia configuracion ni estadisticas. 5%-30%. Online

## Intelligent QP
* Interleaved Excecution, optimizan funciones que regresan tablas. Se generan estadisticas primera vez que se ejecutan.
* Memory Grant Feedback, le agrega un poquito mas de memoria la proxima vez si se quedo sin memoria
* T-SQL Scalar UDF Inlining
* Approximate QP, Approximate Count Distint

## Maximum degreee of parallelism
* Use ALTER DATABASE SCOPED CONFIGURATION

## Escenarios
* Replay Recorded trace data: SQL Server Distributed Replay
* Generate recomentations to add, remove, or modify indexes: Database Tuning Advisor
* Statistics about SQL Server Actity: Built-in Functions.

## Intelligent Insights
Configure Azure SQL Analytics

# Automate Maintenance Tasks
* Azure Automations
* Elastic Jobs

--------
## Table scan
No tenemos nuestros datos con un clustered index. Es señal que tenemos que crear una llave primaria

## Clustered Index Scan
*  Lee desde el comienzo o final de la tabla 
* Lee todas las columnas (a excepcion de columnas extendidas)

## Clustered Index Seek
Se salta renglones hasta cierta area

## Non-clustered Index Seek
Solo se leen ciertas columnas

---
You must be connected to the server instance that hosts the primary replica when you create the listener. You can use SQL Server Management Studio (SSMS), Transact-SQL, or SQL Server PowerShell to create an availability group listener.

When using static IP addressing, you need an IP address for the subnet hosting the primary replica and for each subnet hosting an availability replica. Microsoft recommends using static IP addresses when creating an availability group listener.

The listener must have a valid DNS host name that is unique in the domain. The host name must also be unique in NetBIOS. The maximum name length is 63 characters, but you are limited to 15-character names when creating the listener in SSMS.

___

Permiso para borrar tabla
: `ALTER` en schema o `CONTROL` en tabla. Tambien se pudiera agregar rol usuario a `db_ddladmin`.

---
Estrategia de encriptacion que:
*  Encripte solo columans con informacion sensible
* Datos encriptados en almacenamiento y transito.
* Datos son desencriptados en aplicacion.
* Encriptacion debe ser tan segura como sea posible.
* Administradores no deben desencriptar informacion.

1. Create column master key.
2. Create column encryption key.
3. Encrypt the data columns with Always Encrypted using randomized encryption.

---

Automatic tuning options on SQL Managed Instance.
* Automatic tuning **cannot** identify and create indexes that may improve performace of your workload.
* Automatic tuning **cannot** identify redundant and duplicate indexes and indexes that have not been used in more than 90 days.
* Automatic tuning can use automatic plan correction to identify queries using an execution plan thatn is slower than previous good plan.

---

Minimum information needed for `Invoke-AzSqlInstanceFailover`.
* Resource group
* Managed instance name

---
DMVs for IO wait problems.

---
Granting ALL to a security principal grants the BACKUP DATABASE, BACKUP LOG, CREATE DEFAULT, CREATE FUNCTION, CREATE PROCEDURE, CREATE RULE, CREATE TABLE, and CREATE VIEW permissions:
Members of `DelegatedAdmin` have sufficient permission to back up the database, back up the transaction log, create views, create tables, and create rules.
---
Two activities supported by default for Azure AD server principals (logins) are:
* Execute database backup and restore operations
* Set up Service Broker and DB mail
---
CPU IO Wait issues
* The sys.dm_exec_requests DMV provides information about each request currently executing in SQL Server. 
* The sys.dm_os_waiting_tasks DMV gives you information about the wait queue of tasks that are waiting on some resource. With either, you are looking for information about wait_type and wait_time.
---
You need to identify the 10 missing indexes most likely to improve query performance.

>   You should use the sys.dm_db_missing_index_group_stats DMV. This DMV returns summary information about groups of missing indexes. To get information about the 10 missing indexes with the highest anticipated improvement for user queries, you could run:
    ```sql
    SELECT TOP 10 *
    FROM sys.dm_db_missing_index_group_stats
    ORDER BY avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)DESC;
    ```
---
You need to rewrite the queries that should not recompile unless the underlying table schema changes.

> You should include the KEEPFIXED PLAN hint. This will prevent the Query Optimizer from recompiling the query unless the schema of one or more underlying tables changes or or if sp_recompile runs against the tables.
---
Multiple Azure SQL Database single databases and on-premises SQl Server Instances, with SQL Database Sync you can ensure that bi-directional updates occur across the databases.
---
You want to monitor resource usage to get an idea of how it is changing over time. You want to collect CPU usage and storage data usage statistics for a five-day period once every month.

```sql
SELECT *
FROM sys.resource_stats
WHERE database_name='MyTalk' AND
START_TIME > DATEADD(day, -5, GETDATE())
ORDER BY START_TIME DESC;
```
You are responsible for maintaining an Azure SQL Database single database. You want to minimize the time required for maintenance tasks.
* Elastic Jobs
* Azure Automation
---
InvControl is a SQL Server on an Azure Virtual Machine database. You run the following to create a certificate in the database:

CREATE CERTIFICATE InvC
WITH SUBJECT = 'Inventory control records';
GO

You use the BACKUP CERTIFICATE command to back up the certificate before doing extensive maintenance on the database.

You need to restore the certificate to InvControl.

> You should use the CREATE CERTIFICATE command. You specify the backup file as the source for creating the certificate.

---
You configured SQL Server Agent and installed and configured SQL Server IaaS Agent for an instance of SQL Server on Azure virtual machine (VM). The instance supports a single database named SQLDB1. You want to have notifications sent to a designated operator when agent jobs complete or fail. The operator should receive an email notification through Database mail.
1. Enable Database Email
2. Create a Database Mail account and add the account to the DatabaseMailUserRole in the msdb database
3. Create a Database Mail profile for the Database Mail account
4. Set the profile as the default profile in the msdb database.
---
You should use T-SQL built-in functions to display snapshot statistics about SQL Server activity since the server was started. For example, you can use @@CPU_BUSY to view the amount of time the CPU has spent executing SQL Server code.
---
You deployed a new Azure SQL Server Managed Instance. The instance supports a new application that recently went live. You plan to closely monitor several aspects of the instance during this initial deployment.

You need to configure alerts for average CPU usage percentage and storage space used for the instance and the database it hosts.

What should you use to enable and configure alerting? 

> Azure Portal
---
You want to run a disaster recovery drill for an Azure SQL Database that is protected using failover groups. The database was recently introduced into a production environment. The disaster recovery drill should:
* Be performed in the production environment.
* Minimize interruptions to the production environment.
* Minimize risk of data loss.
* Minimize the time required to complete the recovery drill.

1. Disable the web application connected to the database.
2. Make sure the application configuration in the DR region points to the former secondary.
3. Initiate planned failover of the failover group from the secondary server.
4. Configure the database after recovery.
5. Verify application integrity.

There is no need to rename the primary server. You would do this as your first step during a geo-replication disaster recovery drill.

---
MyDB is an Azure SQL Managed Instance database. The database has experienced problems with read queries blocking queries that try to write to the database. You want to use row versioning to minimize blocking instances.

> You should set READ_COMMITTED_SNAPSHOT to ON in ALTER DATABASE and the transaction isolation level to READ COMMITTED. . If READ_COMMITTED_SNAPSHOT is set to ON, a transactionally consistent snapshot of the data as it was at the start of the statement is used to prevent dirty reads and meet scenario requirements. This is necessary because locks are not used by transactions to minimize the risk of blocks. A dirty read refers to reading uncommitted data.

---
Your company has a hybrid SQL Server infrastructure that includes SQL Server instances deployed on premises and one SQL Server on an Azure virtual machine (VM) instance. You have a VPN connection between the Azure virtual network and the on-premises network. You have a disaster recovery site set up with a replica domain controller installed.

You need to recommend a disaster recovery solution that is supported in a hybrid IT environment only. Additional configuration changes should be kept to a minimum.

> Log Shipping
---
Database backups are retained in separate Azure Blob storage containers. By default, full backups are copied to a different storage container on a weekly schedule. This will incur increasing storage costs as the number of backups increases.
---
You deploy an Always On Availability Group. A database named MyDB1 will be the primary replica for the Availability Group. MyDB1 is currently configured for the simple recovery model.

You need to prepare a secondary database for the Always On availability group.

Configure the primary replica for either the bulk-logged or the full recovery model.

> No. The bulk-logged recovery model is not supported.

Create the secondary replica database with the same name as the primary database.

> Yes

Use the RECOVERY option when restoring to the secondary database.

> No. You should not use the RECOVERY option when restoring to the secondary database. You must specify the NORECOVERY option when restoring the full backup. You must also specify the NORECOVERY option if you have to restore a differential backup or any transaction log backups to the secondary database.

---

You can use Azure portal or Transact-SQL (T-SQL) statements to configure automatic tuning at the database level for Azure SQL Database and Azure SQL Managed Instance.

> No. You can use Azure portal or T-SQL statements to configure automatic tuning at the database level for Azure SQL Database only. You must use the ALTER DATABASE command to configure automatic tuning for Azure SQL Managed Instance.

---

The CREATE_INDEX and DROP_INDEX options are supported for Azure SQL Database instances only.

> Yes. The CREATE_INDEX and DROP_INDEX options are supported for Azure SQL Database instances only. FORCE_LAST_GOOD_PLAN is the only automatic tuning option supported by Azure SQL Managed Instance.

----
You want to set up alerts for an Azure SQL Managed Instance with alert triggers based on metric triggers. Alerts should trigger when a specified metric threshold is crossed in either direction.

You need to identify supported managed instance metrics.

Which three metrics are supported for alert configuration? Each correct answer presents a complete solution. 

A limited set of Azure SQL Managed Instance alerting configuration metrics are supported. These are:
* Average CPU percentage
* IO bytes read
* IO bytes written
* IO requests count
* Storage space reserved
* Storage space used
* Virtual core count

---
You want to run a full backup of database on a SQL Server on an Azure virtual machine instance. The backup should overwrite an existing backup file. You specify the INIT option when you run the BACKUP command. The backup fails because the backup file has not expired.

You need to run the backup as soon as possible.

What additional option should you specify? 

> You should specify the SKIP option. This option prevents checking of the expiration date and time of a backup set on the media before overwriting it.

---
MyDB database is a SQL Server on Azure virtual machine (VM). The database reports checksum errors.

You need to perform physical and logical consistency checks on the database and repair errors. You want to keep the risk of data loss to a minimum. The database should be available for user access when finished.

How should you complete the statements?
```sql
USE master;
ALTER DATABASE MyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DBCC CHECKDB (‘MyDB’ REPAIR_REBUILD) WITH NO_INFOMSGS
GO
ALTER DATABASE MyDB SET MULTI_USER;
GO
```
---
You support an Azure Managed Instance database named SQLDB2 that supports both queries embedded in applications and ad hoc queries. Programmers are creating stored procedures based on some of the more commonly used ad hoc queries. The AUTO_CREATE_STATISTICS option is on for the database.

You need to ensure that you can use sys.dm_exec_query_plan_stats to retrieve parameter values from the last time a query executed.

Which option should you set for SQLDB2? 

> You should set LAST_QUERY_PLAN_STATS to ON. This enables the collection of last query plan statistics in sys.dm_exec_query_plan_stats. The last query plan statistics are equivalent to collecting the actual execution plan.
---
Your company is launching an online sales application. The application will give customers the option of saving credit card information so that it is available for subsequent purchases. Data must be encrypted at rest and in transit. The data should be decrypted for processing by client applications only. The encryption should be a secure as possible, and database administrators should not be able to decrypt the data.

You need to choose an appropriate encryption option.

What should you implement?

> You should implement Always Encrypted. You can use Always Encrypted to encrypt the data in select columns. The data is decrypted only for processing by client applications with access to the encryption key. Database administrators and other privileged uses cannot decrypt the data. The master encryption key is not stored with the database or server. It must be stored externally, such as in an Azure Key Vault, a hardware security module (HSM), or the Windows certificate store.

---
You have an Azure SQL Managed Instance database named DB1. You want to add a user to the database that must provide a password for login authentication and database access.

You need to create the user named User2 with a password of P@55w*rd.

What commands should you run to create the user? To answer, select the correct Transact-SQL (T-SQL) command strings from the drop-down menus.

```sql

USE master;
GO
CREATE LOGIN User2 WITH PASSWORD P@55w*rd;
GO
USE DB1;
GO
CREATE USER User2 FROM LOGIN User2;
GO
```