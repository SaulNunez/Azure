# Repaso de query store y query tuning

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

