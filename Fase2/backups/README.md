# Backups

## System databases
* master
* model
* msdb

Recomendado hacer backups despues de crear logins o trabajos.

## User databases
Las creadas por el usuario.

## Tipos de backups
### Full
Contiene todo

### Differential


### Log
Contiene todas las transacciones desde el ultimo log backup.

### Copy Only
Backup que es independiente a la secuencia de los demas backups.

### Partial
Contiene solo información de ciertos grupos de archivos (incluye primary, read/write)

### File
Backup de solo algunos archivos o grupos de archivos.

## Restricciones al momento de hacer backups
No se puede hacer backups de datos que estan en modo OFFLINE.

Problemas de concurrencia:
* Shrink file, shrink database
* Create/delete database
* Add/remove file

## Modelos de recuperación
Modelo | Descripción | Perdida de datos | Point-in-time restore
--- | --- | --- | ---
Simple | No se guardan log backups | Cambios despues del ultimo backup estan desprotegidos | No
Full | Se registran todas las transacciones | Ninguna, a menos que el registro de transacciones se encuentra dañado | Si
Bulk-logged | Se registran menos detalles en operaciones de tipo bulk para reducir espacio | Ninguna, a menos que el registro de transacciones se encuentre dañado | Se puede restaurar al final de cada log backup | Point-in-time no es posible

## Backup on premises
[Ejercicio](./backup_database.ipynb)

## Restore
[Ejecicio](./restore_database.ipynb)

* `STANDY` puede dejar la base de datos en modo de solo lectura.
* `NORECOVERY` no puedes hacer nada en la base de datos.
* `RECOVERY`
   
El examen de certificacion `NORECOVERY` es la opción asumida como correcta. Es la que menos tarda y se pueden aplicar backups posteriores.
   
Backups diferenciales, se puede aplicar el ultimo.

En backup log, tienes que aplicar anteriores, porque incluye logs desde el ultimo log.

## Opciones de backups en Azure VM
* Manuales
* Backup center
    * Azure VM
    * SQL in Azure VM
* Automated backup

## Donde se pueden hacer backups
* Fileshare
* Blob-storage
* Disco en una maquina virtual

## Valores por default 
* Backup Storage Redundancy: Geo-redundant
* Retencion de backups no se puede cambiar a mas de algunos dias. 35 dias en hyperscale, 7 en los demas(?)
* Se puede establecer recuperación a largo plazo. 
