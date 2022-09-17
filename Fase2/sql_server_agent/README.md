
## SQL Server Agent
### Job
Serie de acciones que el Agente de SQL Server puede ejecutar.
Se puede ejecutar:
* De acuerdo a uno o más schedules
* En respuesta a alguna alerta
* Llamando a **sp_start_job**

Nota: Se guardan en `msdb`, así que en un backup no se van a llevar. 
Si trabajo se interrumpe, entonces este trabajo no se volvera a ejecutar de manera automatica.
Es recomendable usarlos para mantenimiento de base de datos.

### Job step
Una sola tarea específica a realizar.
Cada tarea corre en su contexto de seguridad específico.
Ya sea en SQL Server (`EXECUTE AS`) o fuera del mismo (Proxy Account).
* Powershell commads
* SSIS package
* T-SQL statements
* Analysis Services server command
* Machine learning services
* Etc.

### Schedules
Determina cuando se ejecuta uno o más trabajos.
Ejemplos:
* Cuando el agente de SQL Server inicia
* Cuando el uso de CPU baje de cierto límite
* Una sola vez en un día y horario específico
* De forma recurrente en un horario definido

### Alerts
Respuesta automática a un evento determinado.
(Entre los eventos se encuentran jobs, condiciones de rendimiento, etc.)

Acciones a realizar:
* Notificaciones a un grupo de operadores (operators)
* Ejecutar un trabajo (job)

### Operators
Grupo de personas e informacion de contacto que 
comparten responsabilidades de mantenimiento 
sobre una o más instancias de SQL Server.

### Notification
Mandar información a un operador

## Manteinance plan
### Configurar en Microsoft SQL Server Management Studio
Configurar para las noficaciones por email: Management > Database Mail
Configurar alertas: SQL Server Agent > Alerts
Crear operadores: SQL Server Agent > Operators
Crear planes de mantenimiento (en certificación): Management > Maintenance Plans > Maintenance Plan Wizard

### Recomendaciones generales
* Si nosotros hacemos un CHECKDB cada N días, almacenar backups (full, differential y log) al menos N+1 días
* Un plan de mantenimineto por cada acción
* Dividir también por base de datos