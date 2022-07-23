## Historia Azure SQL
* 2006 - CloudDB y RedDog
* 2008 - Microsoft Azure SQL DS
* 2010 - Lanzamiento de Windows Azure y SQL DS
* 2016 - Elastic Pools, reservar recursos, pero compartirlos entre distintos VMs
* 2018 - Azure SQL MI
* 2018 - Azure SQL Hyperscale Serverless

## Que es Azure SQL?
Todas las soluciones que tiene Microsoft para bases de datos.

### SQL Server on Azure VM
#### Opciones de despliegue
* Azure Marketplace (SQL pre-instalado en Windows o Linux)
    * Si recursos debajo de _ ocurre un loop donde falla la instalacion y reinicia (15.15)
* Despliegue desde 0
* Lift & Shift
    * Migrar disco duro virtual a Azure y ya esta funcionando

#### Resource provider
* Backup y actualizaciones automaticas
* Manejo desde Azure SQL
* Flexiblidad de licencias
    * Poder usar licencia de Windows Server
    * Es dificil usar licencia de SQL Server, pero posible si es de un proveedor externo comprada en bulk
    * Reduce el costo del servicio

#### Rendimiento y almacenamiento
* Uso de cache de almacenamiento
* TempDB en SSD
* Uso de Premium Storage Manage Disks y Ultra Disks

#### Alta disponibilidad
* VM Built-in HA (level service agreement)
* Storage Built-in DR
* File Snapshot Backups, etc...

#### Extension SQL Server Agent
* Backup automaticos
* Parches de seguridad automaticos
* Integracion con Azure Key Vault
* Integracion con Azure Defender
* Visualizacion de uso de discos en el portal de Azure
* Licencia de SQL flexible
*

#### Modelos de pago
* Pago por minuto
* BYOL (Bring Your Own License)
    * Transferir licencia dentro de los primeros 10 días del despliegue
        * Licencia debe estar en programa de Software Assurance

#### Familias VMS
##### General Purpose
Uso: Testing, development, BDD pequeñas a medianas, Web Servers con poco trafico

##### Memory optimized
Uso: Adecuado para la mayoria de cargas de trabajo de BDD

##### Compute optimized
Uso: Web Servers con trafico moderado, procesamiento por lotes

##### Storage optimized
* Almacenamiento ultra rápido efímero
Uso: Cargas de trabajo intensivas para BDD

### IaaS vs PaaS
* Business Continuity
* High Availability
* Automated backups
* Long term backup retention
* Geo-replication
* Scale
* Advanced security
* Version-less
* Built-in monitoring
* Built-in intelligence

### SQL Server Managed Instance
#### Opciones de despliegue
* Despliegue desde 0
* Herramientas de migración

#### Uso de funciones a nivel de instancia
* Service brokers
* SQL Agents

#### Caracteristicas
* Capacidad de uso de multiples schemas
* Version-less

#### Tipos
##### General purpose
Adecuado para la mayoria de las cargas

##### Business critical
Adecuado para cargas de trabajo que requieren baja latencia, recuperacion ante desastres rapida y una replica de lectura.
Agrega varias maquinas replica en un ring, si se cae la principal, se enciende un respaldo en 10-30 segundos.

#### Azure ARC
Se pueden administrar bases de datos afuera de Azure.

#### Tipo de conexion
Podemos usar redigir seguramente cuando solo se conecta la API a la base de datos.

### Azure SQL Database
#### Caracteristicas
* Elastic pool
* Serverless
* Hyperscale
* Servicio administrado por Azure

#### Diferenciadores
* Alta disponibilidad 99.995%
* 5s RPO y 30s RTO
    * Recovery point objective (RPO): The amount of acceptable data loss if a recovery needs to be done.
    * Recovery time objective (RTO): The amount of time that it takes to complete a recovery or restore.

#### Opciones
##### Single database
* Hyperscale (almacenamiento hasta 100TB)
* Serverless
* Servicio administrado por Azure

##### Elastic pool
Compartir recursos para:
* Optimizar costos
* Optimizar administracion

Servicio administrado por Azure

#### Modelos de compra
* DTU (Data Transaction Unit): 1 a 4 transacciones por segundo, modelo simple
* vCore model: 
    * Recomendado
    * Se elige computo y almacenamiento por separado

##### vCore
* General purpose
    * Para la mayoria de cargas
    * Serverless
    * Usa almacenamiento remoto
* Business critical
    * Adecuado para cargas que requieren baja latencia, recuperacin ante desastres rapida y una replica de lectura
    * Almacenamiento local
    * Mas caro
    * In-memory, guardar algunas tablas en memoria RAM
* Hyperscale
    * Adecuado para cargas que requieren gran cantidad de almacenamiento y multiples replicas de lectura

### Serverless
* Line of business apps
* E-commerce
* Dev/test workloads



#### Managed instance
* sp_configure
* Trace flags
* tempdb
* Model and master, collations por default, tamaño inicial de las bases de datos
* ERRORLOG options
* Edition, se cambia informacion en portal
* Configuracion de red
* Configuracion de almacenamiento

##### Configuracion
* Ninguna configuracion que pida parar o reiniciar el servidor
* Instant File initialization, no escribe las cosas primero en cero
* Locked pages in memory
* FILESTREAM and availability groups
* Server collation, set de caracteres y como se realizar operaciones de igualdad y comparación
* Startup parameters
* ERRORLOG configuration
* Error reporting and customer feedback
* ALTER SERVER CONFIGURATION
* "Mixed Mode" security is forced
* Logon Audit done through SQL Audit
* Server Proxy Account 

#### Azure SQL Database
* ALTER DATABASE
    * File maintenance (MI only)
    * SET options
    * "Edition"
    * dbcompat
* ALTER DATABASE SCOPED
* SQL DB
    * Stale page detection
    * Collations
    * Default options ON (right)
* Networking configturation
* Space management

### Configuracion de almacenamiento
#### Azure SQL Managed Instance
Max storage = tamaño maxio de la instancia

Las bases de datos usan el tamaño inicial y crecimiento de la BDD model

MSG 1105
: Base de datos sin espacio
MSG 1133 
: Instancia sin espacio

#### Azure SQL Database
* Data max size - tamaño maximo de la BDD
* El maxsize ira creciendo hasta Data Max Size
* El log de transacciones puede creder hasta un 30% de Data max size
* El log de transacciones es truncado, comprimido y almacenado de manera automática

### Niveles de compatibilidad
Se pueden cambiar el nivel de compatibilidad para tener la velocidad de los queries a una velocidad similar a otra version.

### Azure Preview Features
3 etapas. 

Cuando se usan los previews, si no se trabaja con el equipo de microsoft, no usar en produccion dado que no se garantiza el acuerdo de servicio en cuanto a  disponibilidad.

### Desarrollo
Hace request para usar una funcion

#### Publica
Uno selecciona, quiero usar cierta funcion

#### Servicio nuevo o caracteristicas del servicio
Ya es estable, esta en el portafolio de funcionalidades de Azure.

### Migración
Azure Migrate se puede usar para migrar nuestros datos. Pero no cumple todas las necesidades al realizar la migración.


## Cargar datos
* Bulk copy
* Bulk insert
* Azure SSIS
* Azure Data Factory
* Spark Connectors
* Database copy
* bacpac
* Restore Natively
