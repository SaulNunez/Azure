# Corrupción de datos

## Razones comunes
* Bugs SQL Server
* Fallas en hardware
* Virus o malware
* Fallas durante el proceso de actualizacion
* Apagado repentino de SQL Server

## Notas practica
```sql
DBCC CHECKDB('CorruptionTestDB') WITH NO_INFOMSGS, EXTENDED_LOGICAL_CHECKS;
```
* Se puede hacer backup a la base de datos cuando esta corrupta, es la opción por *default*.
* Se puede hacer backup revisando checksum antes de escribir página.

## Cosas que *no* hacer
* Reiniciar SQL Server
* Detach/Attach Database
* Apagar SQL Server

## Cosas que hacer
* Detener trabajos para borrar backups
* Identificar el alcance de la corrupción
* Alertar a los afectados e interesados
* Revisar el historial de los trabajos de backup y checkdb
* Revisar si hay una solución sencilla viable
* Dividir esfuerzos para restaurar la base de datos

## Estrategia de recuperación
* Revisar indice que se daño
* Si se checa el checksum cada semana en el backup completo
    * Tener al menos 8 dias de backups diarios
    