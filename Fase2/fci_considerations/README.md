# FCI Considerations

## Creacion del Domain Controller
Notas para examen: No se puede unir maquinas al dominio usando Azure Active Directory, Azure AD Domain Services es ajeno a este primero.
### VM with AD
Es posibles desplegar un servicio de Active Directory dentro de una o mas VMs utilizando un Template Deployment o desde 0.

### Azure AD Domain Services
Es posible utilizar este servicio para poder unir las maquinas al dominio y administrar grupos y usuarios.

## Configuracion de los nodos
Para cada una de las maquinas hay que hacer lo siguientes>
* Unir las VMs al mismo dominio
* Instalar la caracteristica Failover-Clustering

## Configuración de la red
### Direcciones IP Secundarias
En cada nodo crear IPs secundarias para:
* Windows Server Failover Cluster
* Failover Cluster Instance
* Domain Transaction Controller

**Esta es la manera sujerida para Windows Failover clusters**

### Azure Load Balancers
Para cada elemento que requiera IP hay que crear un LB que apunte a todos los nodos y crear un probe port.

## Configuración de almacenamiento
### Opciones
#### Storage Spaces Direct
Minimo 4 discos (solo vamos a poder usar 3) y al instalar el cluster se tiene que habilitar esta opción.

#### Azure Shared Disks
Es posible utilizar este servicio para poder unir las maquinas al dominio y administrar grupos y usuarios.

#### Inicialización
Para cada disco en cada maquina virtual hay que crear un nuevo volumen, formatearlo, se sugiere etiquetarlos.
Configuración sugerida para Failover Cluster Instance
* 1 disco para data
* 1 disco para logs
* 1 disco para Domain Transaction Coordinator

#### Testeo del cluster
Hay que usar el siguiente comando para probar si la configuración del cluster es correcta:   
Para Storage Spaces Direct
```powershell
Test-Cluster -Node ("NodeA","NodeB") -Include "Storage Spaces Direct", "Inventory", "Network", "System Configuration"
```

```powershell
Test-Cluster -Node ("NodeA","NodeB")
```

#### Testeo cluster
```powershell
# -Name             Nombre    
# Lista de nodos
# -StaticAddress    IP secundaria creada anteriormente
New-Cluster -Name MyWSFC -Node Node1,Node2,...,NodeN -StaticAddress w.x.y.z
```
En 2022 es posible configurarlo desde el portal, pero en el examen, como se actualiza a finales de cada año powershell sigue siendo la unica manera.

## Creacion del witness
En caso que se caigan suficientes nodos para que se cayera el cluster completo, se pueda recuperar el estado del cluster.
### Shared Disk Witness
Se configura por defecto cuando usamos Azure Shared Disks o S2D.

### Cloud Witness
Usando Azure Fileshare podemos configurarlo como Witness, es la **configuración recomendada**.
No perdemos un disco duro y sale más barato.👀


## Configuración del Distributed Transaction Coordinator
Una vez configurado el cluster debemos crear un Distributed Transaction Coordinator.
Este DTC debe tener su propia IP y su propio disco compartido.

## Instalación del FCI
En un nod debemos instalar SQL Server con la opción **New SQL Server Failover Cluster Installation** y en el resto con la opcion de **Add node to SQL Server Failover Cluster**.
![IU instalación SQL Server](https://www.mssqltips.com/tipimages2/6608_install-sql-server-2019-standard-edition.003.png)

## FCI para SQL Server on premises
### Razones de uso
Es una solucion de HA:
* En caso de requerir actualizaciones
* Incidentes pantallazo azul
* Mantenimiento planeado del servidor
* Problemas no planeados de hardware

### Single point of Failure
El almacenamiento compartido es el unico punto de falla, no nos protege de:
* Corrupción de datos
* Ooops queries
* Ataques como SQL Injection

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


## Log Shipping
Una BDD realizar sus backups y otra BDD esta restaurandolos. No requiere que ambas BDD esten en el mismo cluster,
basta que la BDD de destino pueda acceder a un medio de almacenamiento compartido.
 