# Repasos fin de curso

## Kahoot: Lessons learnt
* Modelo de compra que permite despliegue tipo serverless: V-core based
* Azure SQL Managed instance soporta autofailover
* En Azure SQL Database no se puede correr comandos para hacer backups, se puede descargar la base de datos, en Managed Instance se puede hacer backup a una URL
* En Azure SQL database no es posible modificar la frecuencia de log backups
* Always encrypted es un tipo de cifrado que nos puede ayudar para separar la administracion de los datos de la seguridad, usamos un almacen de certificados, si no tenemos acceso a ellos nopodemos entrar a los datos 
* Es posible configurar la extension SQL Server on VMs para hacer backups automaticos si se usa la version developer
* Con Query Store es posible ver si se optimizo bien un query
* Standard en Database Migration Service es gratuito
* Opcion de automatic tuning disponible en SQL Managed Instance: FORCE PLAN
* COn Query Store es posible ver que queries han  tenido regresion
* Los Elastic Jobs de Azure NO pueden correr comandos SSIS
* 35 dias es el periodo maximo de retencion para PointInTImeRestore en SQL Managed Instance
* Azure SQL soporta autofailover
* Para migrar usando DMA  o la extension de Azure Data Studio es necesario crear recurso destino
* Forma recomendada de configurar un witness dentro de un WSFC con CLoud witness
* En Azure SQL Database no es posibles usar point-in-time restore para sobreescribir la base de dato, se crea una nueva con los datos y ahi se copian los datos
* Con Query Store es posible identificar que queries se ejecutan mas comunmente
* No es posible configurar la extension de SQL Server on VMs para hacer backups automaticos si hay multiples instancias
* Log shipping es la solucion de DR mas simple, es posible integrarla sin crear un WSFC
* Transparent Data Encryption es el tipo de cifrado que se utiliza para proteger los datos en reposo
* En general purpose no se puede hacer un despliegue de tipo serverless
* Los Elastic Jobs de Azure NO pueden correr comandos powershell
* Azure SQL Managed Instance no soporta georeplicación
* Comando para iniciar failover de una Base de datos dentro de un elastic group: `Invoke-AzSqlDatabaseFailover`
* NO es posible hacer migracion online con DMA
* Los Elastic Jobs de Azure pueden correr comandos de T-SQL
* Se usa el puerto 1434 por SQL Server durante el proceso de migracion con DMS
* SQL Server usa el 1433 por default
* SQL Managed Instance podemos usar agentes de SQL Server
* Dynamic Data Masking es una herramientoa de seguridad que nos permite ocultar los datos a ciertos usuarios
* No es posible reutilizar tu licencia de SQL Server usando Data Migration Assistant, porque no determinan la creacion del servicio
* Auto-failover group, solucion PaaS de HADR que permite failover automatico en caso de error
* Data sync, es un servicio que permite sincronizar datos on-premises y en la nube de ciertas tablas y columnas
* Para migraciones online en Data Migration Assistant se requiere el nivel de compra Premium
* En caso de caida del servicio geo-replication no conmuta automaticamente a la BDD secundaria
* DMA nos ayuda a identificar posibles problemas de compatibilidad
* Con Query Store es posible indentificar las queries que consumen mas recursos
* Azure SQL Database soporta geo-replicacion