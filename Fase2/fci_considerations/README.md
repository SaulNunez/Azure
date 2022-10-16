# FCI Considerations

## Creacion del Domain Controller
### VM with AD
Es posibles desplegar un servicio de Active Directory dentro de una o mas VMs

### Azure AD Domain Services


## Configuracion de los nodos
Para cada una de las maquinas hay que hacer lo siguientes>
* Unir las VMs al mismo dominio
* Instalar la caracteristica Failover-Clustering

## Creacion del witness
### Shared Disk Witness
Se configura por defecto cuando usamos Azure Shared Disks o S2D.

### Cloud Witness
Usando Azure Fileshare podemos configurarlo como Witness, es la configuración recomendada.

#### Creacion del Cloud Witness
##### 

## Configuración del DTC
Una vez configurado el cluster debemos crear un Distributed Transaction Coordinator.
Este DTC debe tener su propia IP y su propio disco compartido.

## Instalación del FCI
En un nod debemos instalar SQL Server con la opción **Failover Cluster Instance** y en el resto con la opcion de **Add node to FCI**.


## Terminos en examen de certificación
WSFC - Windows Server Failover Cluster
S2D - Storage Spaces Direct
FCI - Failover Cluster Instances
AG - Availability Groups

## Kahoot
RTO - Recovery Time Objetive
RPO - Cuantos datos pudieramos perder
Availability Server - Se puede hacer con cualqueir maquina virtual
Availability zones - En cualquier maquina veritual
Azure site recovery - Se puede hacer con cualquier VM
Azure Site recovery RTO - 2 horas
Azure Site Recovery - No se adapta a los servicios que estan corriendo. Restaura a nivel de maquina virtual
Always On Failover Cluster Instances - SQL Server IaaS o On Premises
Always On Availability Groups - VMS o On Premises
Log Shipping - SQL Server IaaS, VMs o On Premises
Always On Availability Groups - Falso, no hay almacenamiento compartido
Failover Cluster - No protege de corrupcion
Log Shipping - No requiere un Windows Server Failover Cluster
Active Geo Replication - SQL Server PaaS
Auto Failover Groups, redirige trabfico de manera automatica
Active Geo Replication - Solo esta disponible en Azure SQL
Azure AD Domain Services - Permite unir las VMs a un solo dominio
Para configurar IP adresses para FCI -  Podemos usar internal load balancer
Recomendada para almacenamiento para WSFC - Azure Shared Disks o adicionalmente Storage Spaces Direct
Witness - Nos ayuda a conservar estado del cluster en caso que se caigan varios nodos
Tipo witness recomendado WSFC - Cloud Witness
Listener - Configurar para redirigir trafico
SQL Server nos dejara instalar un FCI sin la necesidad de un Cluster DTC - Verdadero, aunque no es buena practica
Storage Spaces Direct discos duros minimos - 4, 3 disponibles como espacio compartido

// Agregar contenido aqui

## Log Shipping
Una BDD realizar sus backups y otra BDD esta restaurandolos. No requiere que ambas BDD esten en el mismo cluster,
basta que la BDD de destino pueda acceder a un medio de almacenamiento compartido.
 