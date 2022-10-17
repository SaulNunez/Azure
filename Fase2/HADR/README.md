# HADR

## Recovery Time Objective
Cantidad maxima de tiempo disponible para poner los recursos en linea despues de una interrupcion o un problema.

### Para certificacion
Pensarlo a nivel de aplicación, cuanto tiempo tardara en estar disponible nuestra aplicacion de nuevo a usuarios.

Ej. si nos dan RTO del servidor y de la base de datos, el RTO que busca la certificacion es el mayor.

## Recovery Point Objetive
Cuanta información estamos dispuestos a perder.

Momento especifico al que se debe recuperar una base de datos y equivale a la cantidad maxima de perdida de datos que la empresa esta dispuesta a aceptar.

## Proceso de definicion RTO y RPO
Tomar en cuenta:
* Necesidades empresariales
* Habilidad de los administradores
* No solo BDD sino aplicaciones
* Conocer costo por inactividad y costo de solución

## HADR en IaaS

### Diferentes opciones tratadas en la certificacion

Nombre de la instancia | Protege
--- | ---
Instancias de cluster de conumtacion por error FCI Always ON | Instancia
Grupo de disponibilidad GD Always ON | Base de datos
Trasvase de registros | Base de datos

### Failover Cluster Instances
Multiples maquinas virtuales. Si un nodo falla, sus recursos se transladaran a otro nodo.
Todos los recursos de la instancia se transladan al nuevo nodo, por lo que una vez hecha la transición se puede usar de manera normal.

Primera instancia es normal, la segunda se configurar como un Failover instance.

[Mas información aquí](../fci_considerations/)

#### Razones para usar
Es una solucion de HA:
* En caso de requerir actualizaciones
* Incidentes pantallazo azul
* Mantenimiento planeado del servidor
* Problemas no planeados de hardware


#### Single point of failure
El almacenamiento compartido es el unico punto de falla.

### Always On Availability Group
Un AG se despliega en un cluster de manera similar a un FCI, sin embargo cada instancia es independiente y se provee proteccion a nivel de base de datos.
La base de datos principal envia logs de transacciones y las replicas se restauran de manera asincrona o sincrona.

Nota: Eventos extendidos fuera de la base de datos, usuarios (no contained en la base de datos) no se transladaran a la otra maquina virtual.

Nota 2: Podemos configurar nuestra segunda maquina como una replica de lectura.

#### Razones para usar AG
* En caso de requerir actualizaciones
* Incidentes de pantallazo azul
* Mantenimiento planeado del servidor
* Problemas del hardware
Usado principalmente como opcion de HA.

## Log Shipping
Se basa en una BDD realizando sus backups y la otra BDD restaurandolos.
No requiere que ambas BDD esten en el mismo cluster, ni requiere configurar compleja.
Los backups estan en un almacenamiento compartido.

## Database Mirroring
Dos instancias, que se comunicaban por la red. Tenia ventajas similares al grupo de disponibilidad.

Se dejo de usar porque Windows Failover Cluster fue una solución mas robusta a lo largo del tiempo.


## HADR in Azure VMs
### Availability Sets
Garantizar que dentro de un Data Center las maquinas virtuales no corran en el mismo servidor.
Protegen contra:
* Fallas de hardware
* Fallas de red
* Fallas de alimentación de energía

### Availability Zones
Garantizan que dentro de una region las maquinas virtuales no corran en la misma zona.
Protegen contra:
* Fallas de hardware
* Fallas de red
* Fallas de alimentación de energía

### Virtual Machine Scale Set
Similar al Availability Set pero se encarga Azure de administrar que se replique la maquina virtual.

### Azure Site Recovery
Permite restablecer una maquina vritual en caso de una caida, esto es a nivel de BDD y desconoce de los servicios que estan corriendo asi que no es posible garantizar un RPO.

RTO aproximado de 2 horas.

**Disponible en la opción de Disaster recovery de la VM.**

## HADR en Azure SQL Server

### Active Geo-Replication
![Arquitectura de Active Geo-Replication](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/active-geo-replication-overview/geo-replication-updated.png?view=azuresql)

#### Disponible en
Se puede usar en:
* Azure SQL

#### Desventajas
Nos tenemos que encargar de conectarnos a la otra instancia cuando se caiga nuestra base de datos

### Auto Failover Groups
![Arquitectura de Auto Failover Groups](https://docs.microsoft.com/en-us/azure/sql-database/media/sql-database-auto-failover-group/auto-failover-group.png)

#### Disponible en
Se puede usar en:
* Azure SQL
* Azure SQL Managed Instance

Si nuestra aplicacion soporta logica de reintento, esto deberia ser facil.
Se puede tener un RPO muy pequeño (10 segundos).
RTO de x minutos en, en general purpose de 5 a 10 minutos.

## HADR en PaaS (Postgres y MySQL)

Capability | Basic | General Purpose | Memory optimized
--- | --- | --- | ---
PTR  from backup | Any restore point within the retention period RTO- varies RPO < 15 min | Any restore point within the retention period RTO- varies RPO < 15 min | Any restore point within the retention period RTO- varies RPO < 15 min
Geo-restore from geo-replicated backups | Not supported | RTO- varies RPO < 1h | RTO- varies RPO < 1h
Read replicas |  RTO - Minutes PRO < 5 min| RTO - Minutes PRO < 5 min |  RTO - Minutes PRO < 5 min