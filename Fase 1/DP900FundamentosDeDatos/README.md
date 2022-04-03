# Azure Data Fundamentals

## Qué son los datos?
Son una colección de hechos como pueden ser números, descripciones u observaciones utilizadas para almacenar información. 
 
Bases de datos: Lugar donde tenemos almacenados los datos.
Sistema gestor de bases de datos: Sistema que nos permite manipular y gestionar el sistema.

## Bases de datos relacionales
Guarda los datos en un modelo de tabla, la informacion puede estar relacionada entre sí.

### Bases de datos no relacionales
* Basadas en documentos
* Familia de columnas
* Basadas en grafos

## Sistema de procesamiento de transacciones
Transaccion: Interaccion con una estructura de datos compleja, compuesta por varios procesos secuenciales, debe cumplir las propiedades ACID.

### ACID
* Atomicidad, operación solo esta no realizada o realizada.
* Consistencia, un cambio debe producir un estado valido.
* Aislamiento, un cambio no debe afectar a otros cambios.
* Durabilidad, una vez completado el cambio, este debe conservarse.

## Análisis de datos
1. Base de datos de producción, donde como administradores de bases de datos hacemos labores administrativos como monitoreo o backup, optimizacion, diseño de schema. Adicionalmente, datos de no estructurados
    1. Se extraen los datos y se transforman, ej. como limpiar el texto o cambiar fechas.
2. Data warehouse, donde almacenamos cantidades masivas de información, de distintos lugares.
3. Se construye un modelo analítico, ej. se puede analizar en multiples dimensiones, ej. compras durante un mes.
4. Generación de reportes, gráficos y extracción de conocimiento.

## Roles
Database administrator: Responsable del diseño, implementacion, mantenimiento y operacion de las bases de datos.
Data Engineer: Gestionar cargas de trabajo. Crean planes para la ingestion, limpieza, transformacion y almacenamiento de datos.
Data Analyst: Responsables de extraer información y conocimiento de los datos. Diseñan e implentan modelos analíticos.

## Servicios de Datos en Azure
* Azure SQL: Una solucion PaaS

|Rol|Tareas|
|---|---|
|Database Administrator|Crean y administran bases de datos necesarios para la línea de negocio |
|Data Engineer|Utilizan este tipo de servicios como origen de datos para operaciones ETL |
|Data Analyst|Es posible que hagan consultas a estas bases de datos para la generación de reportes |

* SQL Managed Instance: Instancia completa de SQL server con mantenimiento automático
* Azure SQL VM: Una máquina virtual con el software SQL Server instalado
* Azure Database para BDD Relacionales
    * Database for MySQL
    * Database for MariaDB
    * Database for Postgres
* CosmoDB
    * Maneja documentos, grafos, llave-valor, familia de columnas

|Rol |Tareas|
|--|--|
|Database Administrator|Pueden crear y administrar estas bases de datos, aunque comúnmente esta tarea la realizan los desarrolladores |
|Database Engineer|Utilizan este tipo de servicios como origen de datos para operaciones ETL |
|Data Analyst|Generalmente hacen uso indirecto de estos datos |

* Azure Storage Account: Provee de un único lugar para almacenar todos los objetos de datos, contenedores, archivos, discos, etc. Disponible mediante HTTPS.

|Rol|Tareas|
|--|--|
|Data Engineer|Utilizan este tipo de servicios como origen de datos para operaciones ETL |

* Azure Disks: Discos de almacenamiento tradicional usado por máquinas virtuales u otros servicios.
* Azure Files: Servicio usado para compartir archivos mediante el protocolo SMB y HTTP.
* Azure Blob Storage: Almacena cantidad masivas de datos no estructurados.
    * Niveles de acceso:
        * Hot, lectura rapida, se cobra poco por lectura, pero más por guardarla.
        * Cool, mas por consulta, pero menos por costos de almacenamiento.
        * Archive, almacenamos datos y se nos cobra poco por tenerlos guardados, pero la lectura es lentísima por el proceso de "hidratación". Almacenar backups o datos de auditoría.
* Azure Data Factory: Servicio que permite cargar, transformar y transferir datos.

|Rol|Tareas|
|--|--|
|Data Engineer|Utilizan este servicio para construir las operaciones de ETL|

* Azure Synapse Analytics: 
    * Pipelines: Basada en Azure Data Factory
    * SQL: Base de datos optimizada para almacen de datos.
    * Apache Spark: Sistema Open Source de procesamiento de datos.
    * Azure Synapse Data Explorer: Sistema de análisis de datos para consultas en tiempo real.

|Rol|Tareas|
|--|--|
|Data Engineer|Pueden utilizar este servicio como una solución unificada, creando planes para la ingestión, limpieza, transformación y almacenamiento de datos|
|Data Analyst|Pueden usar SQL y Spark a través de notebooks para explorar y analizar datos, así como aprovechar la integración con servicios como Azure Machine Learning y Microsoft Power BI para crear modelos de datos y extraer información de los datos.|

* Azure Databricks: Otra plataforma, funcionalidad similar a Synapse Analytics.

|Rol|Tareas|
|--|--|
|Data Engineer|Pueden utilizar este servicio crear almacenes de datos para su posterior análisis|
|Data Analyst|Pueden utilizar notebooks para analizar y explorar los datos, así como la interfaz web de databricks para filtrar y visualizar los datos|

* Azure HDInsight, colección de servicios de procesamiento de datos de Apache.
    * Spark
    * Hadoop
    * HBase
    * Kafka
    * Storm

|Rol|Tareas|
|--|--|
|Data Engineer|Utilizan estos servicios para las operaciones ETL|

* Azure Stream Analytics: Transformar datos en tiempo real, de dispositivos IoT por ejemplo.

|Rol|Tareas|
|--|--|
|Data Engineer|Utilizan estos servicios para las operaciones ETL|

* Azure Purview: Provee de una solución de gobernanza de datos que permtie crear un mapa de datos y rastrear el camino.

|Rol|Tareas|
|--|--|
|Data Engineer|Utiliza este servicio para la gobernanza de datos|

* Azure Data Explorer: Solucion para consultar logs y telemetría.

|Rol|Tareas|
|--|--|
|Data Analyst|Utiliza este servicio para analizar datos que contengan una marca de tiempo|

* Microsoft Power BI: Plataforma que permite a los analistas de datos crear reportes y visualizaciones interactivas de datos.

## Relaciones
### Entidades debiles
Por entidad: Requieren de la llave primara de otra entidad para diferenciarse
Por existencia: Conceptualmente no pueden existir sin la existencia de otra entidad fuerte

## Normalización
### 1F
* Todos los atributos son atomicos.
* Existencia de llave primaria unica
* La clave primara no contiene atributos nulos.
* No debe existir variación en el número de columnas.
* Debe existir una independencia del orden tanto de las filas como de las columnas.
* Eliminar grupos repetidos

### 2F
* Si los atributos que no forman parte de ninguna clave depende de forma completa de la clave primaria. Es decir, que no existen dependencias parciales.
* Todos los atributos que no son clave principal deben depender unicamente de la clave principal.

### 3F
* Todo atributo no clave debe proporcionar información sobre la clave, sobre toda la clave y nada más que la clave.

# Lenguaje SQL
* Data Definition Language
    * CREATE
    * ALTER
    * DROP
    * RENAME
* Data Control Languague
    * GRANT
    * DENY
    * REVOKE
* Data Manipulation Language
    * SELECT
    * INSERT
    * UPDATE
    * DELETE

## Algunos objetos en BDD Relacionales
* Vistas: Es una tabla virtual basada en una consulta SELECT.
* Procedimientos almacenados: Definen una serie de declaraciones SQL, permiten encapsular lógica de negocios.
* Indices: Permite optimizar la búsqueda dentro de una tabla.

## Bases de datos no relacionales
### Clave - valor
Solo soporta operaciones lectura y escritura.
Muy utiles para la lectura/escritura de grandes cantidades de datos en poco tiempo.

Ejemplo: Redis

### Basada en documentos
Sus capacidades dependen del DBMS, el almacenamiento de los campos es transparente mediante formatos como JSON o XML.
Muy versátiles por su estructura dinámica, permiten consultas complejas.

Ejemplo: MongoDB, CouchDB, CosmosDB

### Familia de columnas
Permite agrupar campos de datos en Familias lo cual optimiza algunos tipos de consultas.

Ejemplo: Apache Cassandra

### Basada en grafos
Permite guardar datos de diferentes entidades asi como las relaciones entre las mismas. Permite que consultas complejas sean faciles de realizar.

Ejemplo: Neo4j AuraDB, Titan, OrientDB

## Cosmos DB
### API


## Azure Account Storage

### Azure Blob Storage

Almacena cantidades masivas de datos no estructurados.
Ejemplos de uso:
* Despachar documentos directamente al navegador.
* Guardar documentos para acceso distribuido.
* Streaming de video y audio.
* Almacenar backups.

#### Tipos de blobs

##### Block Blobs
Una serie de bloques.

**Tamaño maximo: 4.7TB**

Pensado para almacenar archivos grandes que no cambian frecuentemente.

##### Append Blobs
Optimizado para operaciones tipo append.

Solo se puede escribir al final de un archivo, actualizar o eliminar bloques no es permitido.

##### Page Blobs
El archivo es administrado como una serie de páginas de 512 bytes.

**Tamaño maximo: 8TB**

Optimizado para operaciones de escritura y lectura aleatorias. 
Usado para implementar almacenamiento en discos virtuales.

### Azure Data Lake Storage Gen 2
Version alternativa de blob storage con seguridad, rendimiento y administración mejoradas.

Mejoras:
* Jerarquía de documentos con directorios reales
* Posibilidad de uso de permisos POSIX
* Integración con Azure HDInsights, Synapse Analytics y DataBricks

### Azure Files

Servicio usado para compartir archivos mediante el protocolo SMB, NFS y HTTP.

**Límite de almacenamiento 100TB, límite de tamaño de archivo 1TB.**

### Azure Tables

Servicio NoSQL de almacenamiento de datos clave/valor. *(Documentación Microsoft)*

Pero parece mas familia de columnas, dado que hay entradas que carescan de algunas columnas.

