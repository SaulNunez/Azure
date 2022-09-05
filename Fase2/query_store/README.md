# Query Store

## Que es Query Store?
Un lugar en SQL Server que nos ayuda a guardan planes de ejecucion, runtime statistics y estadísticas de espera.
* Query Store se introdujo en SQL Server 2016.
* Se agrego estadisticas de espera en SQL Server 2017.
* En Azure SQL esta habilitado por defecto. Usado como backend para alguna funcionalidad como forzed plan del portal de Azure SQL Server.

![Query store en ejecución de query](https://www.gpsos.es/wp-content/uploads/20190513_ejecucion_with_query_store_enabled.png)

* Se guarda texto de query y plan, a excepcion que forcemos un plan. Estas se escriben directamente al disco de manera asíncrona.
* Al finalizar se mandan estadisticas de ejecución. Estas se guardan en una queue que las manda a disco cada cierto tiempo minutos (default 15 minutos).
* Se pueden habilitar a nivel de base de datos. 
* Se guarda de manera asíncrona.
* Se guarda en el servidor.
* Query store se puede activar a nivel de base de datos.
* No se puede habilitar en TempDB y en Master.

## Usos
* Identificar regresión de rendimiento
* Identificar las consultas con mayor uso de recursos para realizar query tuning
* A/B testing para evaluar cambios en las queries y su rendimiento
* Verificar estabilidad de rendimiento en SQL Server tras una actualización
* Determinar las queries más usadas
* Auditar los planes de ejecución de una consulta
* Entender las wait statistics más prominentes del servidor

## Modos
Operation Mode:
* Off: Esta deshabilitado.
* Read only: Solo se puede leer información
* Read write: Leer y guardar información desde el momento que se ejecuta.

## Opciones
* **Data Flush Interval**: Lapsos mas cortos causan mas carga al almacenamiento.
* **Statistics Collection Interval**: Va a estar agregando información de estatidisticas de manera agregada, lapsos mas cortos agregan mas granuladidad, pero ocupa más espacio en disco.
* **Max plans per query**:
* **Max size in query store**: Que tan grande puede ser el almacenamiento ocupado. Al llenarse, se cambiara estado de operacion a read only.
Si queremos borrar toda la información purge query data.
* **Query Store Capture Mode**
    * **None**: Ya no se captura información. A excepción de que se este corriendo actualmente un query, entonces seguira capturando esa información o hayan queries futuras de las que se este capturando información. Se tendría que apagar query store para dejar totalmente de escribir.
    * **All**: Guardar todos lo queries. Pero hay queries que ejecuta automaticamente SQL Server y algunos queries esporadicas de nuestra aplicación
    * **Auto**: Identifica queries con impacto a los recursos para guardar
* **Size based cleanup mode**: Al estar 90% lleno, borra las queries más viejas hasta llegar al tener un 20% libre.
* **Stale query threshold**: Tiempo por el que mantenemos la información guardada, información de ejecución mayor a 30 días se borra automáticamente.
*  **Wait Statistics Capture Mode**: Si guardamos estadisticas de espera.

### SQL
```sql
USE [master]
GO
ALTER DATABASE [AdventureWorks2019] SET QUERY_STORE = ON
GO
ALTER DATABASE [AdventureWorks2019] SET QUERY_STORE (OPERATION_MODE = READ_WRITE)
GO
```

### SQL Server Management Studio
En Plan Summary, cuadrito significa planes de ejecucion que tuvieron una excepción, ej. cancelados.

Dando clic a un plan de ejecucion en tracked queries lo elecciona para ese tipo de queries y evita parameter sniffing. ✅ significa plan elegido. Usar force plan para usarlo exclusivamente.

### Query wait statistics
Identifica estadísticas de espera
* network IO, estadisticas de espera de la red
* Paralelismo, valores muy altos, tenemos un threshold muy bajo.
* Buffer IO,
* CPU, 
* Latch,

Se puede ver como se han comportado los query statistics a lo largo del tiempo.

## Top resource consuming queries


## Particionado horizontal
* Columnstore index, primera opcion, para rendimiento de queries.
* Particionado horizontal, para carga de datos, si tarda demasiado cargar los datos a la base de datos.

