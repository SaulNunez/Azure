## Establecer baseline

### Metricas de `perfmon`
* `Processor(_Total)%ProcessorTime`: Incluido
* `PagingFile(_Total)%Usage`: Uso de memoria almacenada en disco duro. Normalmente deberia ser 0%, en algunos servidores on premises 1-3%. (Creo) Pero significa una caida de rendimiento un punto mas alto.
* `PhysicalDisk(_Total)% Avg. Disk sec/Read`: Picos maximos de 50 en ambos. En milisegundos. 
* `PhysicalDisk(_Total)% Avg. Disk sec/Write`:
* `System/Processor Queue Length`: Cuantos procesos estan en espera de ser ejecutados. Es normal que haya un numero de procesos en espera.
* `SQLServer:Buffer Manager/Page Life Expectancy`: Espacio en memoria que trae información de tablas. Si sube mucho es malo, pero si baja mucho, puede significar que se esta acabando la memoria.
* `SQLServer:SQL Statistics/Batch Requests/sec`: Nos dice número de solicitudes que tiene ese segundo.

### Uso de wait statistics
Estados positbles para un trabajo de sesión.
* RUNNING: Corriendo en CPU.
* RUNNABLE: Listo para ejecutarse porque la base de datos esta ocupado.
* SUSPENDED: Esta esperando algun recurso para ejecutarse.

Categorias de espera
* Resource wait: Esta esperando algun recurso
* Signal wait: Estaba esperando el CPU, un hueco para poder hacer su trabajo.

Vistas para visualizar valores
* `sys.dm_os_`
* `sys.`

## Eventos extendidos
Canales principales
* Administración:
* Operativo: Generar reportes para un administrador para una tarea especifico
* Analítico: Recolectar informacion general para hacer analísis
* Depuración: Pensado para que si tenemos algun problema, junto con el equipo de soporte de SQL Server puedan recolectar información para depuración de errores.

## Azure SQL Insights
1. Una maquina virtual puede obtener metricas de 100 bases de datos. Tamaño recomendado 2vcpus y 4gb de memoria.
2. Se crea un usuario en SQL Server encargado del monitoreo. No se puede usar nuestro usuario DBA para monitoreo, no es buena practica y no es posible con la herramienta.
3. Se crea un area de trabajo de analisis de registors (Log Analytics)
4. Se conecta la maquina virtual a Monitor

## Azure Storage y SQL Server
* Blob storage: usado para almacenar objetovs. Se usa para almacenar copias de seguridad de las bases de datos.
* File storage: Puede usarse como destino de almacenamiento para una instancia de failover en un cluster.
* Disk storage: Abstracción de un disco físico. Usado para almacenar los datos y los registros de una instancia de SQL Server.

### Azure Storage
*Standar HDD: Adecuados para backups y archivos procesados de manera poco comun.
* Standard SSD: Latencia moderada, adecuada para servidores web y otras apps.
* Premium SSD: Baja latencia y alto ancho de banda. Para BDD.
* Utra disk: Muy baja latencia y alta velocidad de lectura y escritura.

#### Recomendaciones
* Use la unidad D: para los archivos de `tempdb` ya que esta base de datos se vuelve a creare al reiniciar el servidor.
* En caso de cargas de trabajo que requieran una latencia de almacenamiento menor a un milisegundo, considere usar discos ultra en lugar de SSD premium.
* Habilite la inicializacion instantanea de archivos para reducir el impacto de las actividades de crecimiento de los archivos. Deja de escribir primero ceros el archivo antes de trabajar con el.
* Mueva los directorios de registro de errores y archivos seguimiento a discos de datos.

### Familias de VMs
* General purpose: RAM y vCPU avanzados
* Memory optimized
* Compute optimized
* Storage optimized: Almacenamietno utra rapido. Para cargas de trabajo intensivas para BDD. Necesitamos agregar redundancia dado que se si se apaga la maquina virtual, habría perdida de datos.

### TempDB
Antes de SQL Server 2016.
* Un solo archivo por defecto para TempDB.
* T1118 para reducir problemas de contención.
* T1117 para realizar llenado proporcional. 

Despues de SQL Server 2016.
* Numero de archivo proporcial al numero de nucleos.
* Archivos del mismo tamaño para asegurar rellenado proporcional.
* T1118 y T1117 ya no son best practices.

### Resource Governor
### Grupos de recursos
Se pueden asignar con un limite de las siguientes caracteristicas:
* Porcentaje de CPU mínimo y máximo
* Límite del porcentaje de CPU
* Porcentaje de memoria mímimo y máximo
* Afinidad del scheduler
* IOPS por volumen mínimas y máximas

#### Cargas de trabajo
Contenedor para soliciturees de sesion.
* Asociadas a un grupo de recursos.
* Se les puede definir un nivel de importancia.

#### Función clasificadora
Determina a cual carga de trabajo pertenece una consulta. 

# Extra a la certificación
## Prometheus
Heramienta de monitoreo/alertas:
* Especializada en escenarios altamente dinamicos (ej. Kubernetes, contenedores)
* Con capacidad de uso en escenarios tradicionales.

Time Series Database: Almacena metricas
    Http server: Obtiene metricas mediante pull. Obtiene las metricas para que el usuario pueda obtenerlas en una interfaz. Se puede usar PromQL
    Data retreival worker: Obtiene las metricas mediante pull de la base de datos, por ejemplo.

Objetivos: Elementos que monitorea.
Cuales unidades son recolectadas de los objetivos?
    * %Total de uso de CPU
    * Espacio disponible
    * Número de bloqueos
    * Inscripciones mediante el día
    * Etc. depende del objetivo y acepta cosas exclusivas de nuestra línea de negocio

### Métricas
Tipos de metricas
* Counter: Es una cuenta que aumenta 1 a la vez.
* Gauge: Suben y bajan a lo largo del tiempo.
* Histogram: Como se distribuyen las solicitudes.

### Alert manager
Se encarga de mandar las alertas a algun lado. Ej. canal del Slack, mensaje SMS, etc.

## Grafana
Permite crear visualizacion de datos en tiempo real.

En este caso lo usamos para mostrar en tableros los datos que obtuvimos en Prometheus.

