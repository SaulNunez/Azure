# Fase 1 - Aprende: Microsoft Certified: Azure Database Administrator Associate
## Razones por la que es mas barata la nube
* Es posible reducir gastos operativos
* Ejecuta la infraestructura de manera mas eficaz
* Se escala el servicio conforme a las necesidades

## Paseo por los servicios
### Proceso
* Azure virtual machines
* Azure virtual machine scale sets
* Azure Kubernetes Service
* Azure Service Fabric
* Azure Batch
* Azure Container Instances
* Azure Functions
* Azure functions, correr acciones segun eventos. Ej. al subir archivos, al crear una entrada en la base de datos

### Redes
* Azure Virtual Network, restringir acceso a nuestros servidores, ej. solo permitir conectar a las bases de datos con cierta llave SSH 
* Azure Load Balancer
* Azure VPN Gateway
* Azure Content Delivery Network
* Azure DNS
* Azure DDoS Protection
* Azure Traffic Manager, redigirir a ciertos servidores usuarios beta
* Azure ExpressRoute
* Azure Network Watcher
* Azure Firewall

### Almacenamiento
* Azure Blob Storage
* Azure File Storage
* Azure Queue Storage, almacenarlos en fila para hacer tareas con ellos
* Azure Table Storage

### Movil
* Sincronización de datos sin conexión
* Conectividad a datos locales
* Difusión de notificaciones de inserción
* Escalado automático para satisfacer las necesidades del negocio

### BDD
* Azure Cosmos DB, solucion NoSQL basada en documentos
* Azure SQL Database, SQL Server
* Azure Database for MySQL
* Azure Database for PostgreSQL
* SQL Server en Azure Virtual Machines
* Azure Synapse Analytics
* Azure Database Migration Service
* Azure Cache for Redis
* Azure Database for MariaDB

### Web
* Azure App Service, desplegar una aplicacion web usando cierto framework y se encarga de configurarla para producción.
* Azure Notification Hubs
* Azure API Management
* Azure Cognitive Search
* Service Azure SignalR

### IoT
* IoT Edge, recibir mensajes y procesarlos
* IoT Hub, canal de comunicacion entre Azure y los dispositivos
* IoT Central, UI para administrar dispositivos, para prototipos
* Azure Sphere, hardware protegido contra modificación 

### Macrodatos
* Azure Synapse Analytics
* HDInsight de Azure
* Azure Databric

### AI
* Azure Machine Learning Service, experimentos, caro
* Azure Machine Learning Studio, caro
* Azure Cognitive Services
* Azure AI Bots, bots de preguntas y respuestas, bot conversacional, bots transaccionales (para Whatsapp por ejemplo) para modificar base de datos o ejecutar ciertos server functions.

### DevOps
* Azure DevOps
* Azure DevTest Labs

## Ventajas de la nube
* Escalabilidad
    * Horizontal, crear un servidor adicional corriendo este servicio
    * Vertical, asignar recursos adicionales al servidor
* Elasticidad, escalabilidad es automatica
* Alta disponibilidad
* Agilidad
* Recuperación
* Distribución geográfica

En las regiones, contienen al menos tres zonas de disponibilidad

### Módelo de pago en Azure
* Sin costes por adelantado
    * Excepcion: Reservar maquinas virtuales, contratos con una empresa donde se comprometan cierto nivel de gastos en Azure
* No es necesario comprar ni administrar infraestructuras costosas que es posible que los usuario no aprovechen del todo
* Se puede pagar para obtener recursos adicionales cuando se necesiten.
* Se puede dejar de pagar por los recursos que ya no se necesiten.

## Modelos de servicio en la nube
IaaS, infraestructura, ej. maquinas virtuales
PaaS
    * una plataforma para desplegar aplicacion
    * Serverless, ya no se encarga uno de la parte del servidor
SaaS, ej. 

CapEx, gastos de capital
OpEx, gastos operativos

## Grupos de administracion 
* Hasta 10,000 grupos de aministracion
* Limite de seis nivels de profundidad, no incluye el nivel raíz ni el nivel de subscripción.
* Para poder dividir los gastos en diferentes facturas

## Opciones de shell
* Azure Powershell, solo para Windows
* Azure CLI, disponible en MacOS y Linux

## Azure Herramientas de supervisión
### Objetivos
* Obtener respuestas, información y alertas para asegurarse que ha optimizado el uso de la nube.
* Determinar la causa principal de los problemas no planeados.
* Preparase de antemano para interrupciones planeadas.

### Azure Advisor
Genera recomendaciones en las siguientes áreas:
* Confiabilidad
* Seguridad
* Rendimiento
* Costos
* Excelencia operativa

### Azure Monitor
The following diagram gives a high-level view of Azure Monitor. At the center of the diagram are the data stores for metrics and logs, which are the two fundamental types of data used by Azure Monitor. On the left are the sources of monitoring data that populate these data stores. On the right are the different functions that Azure Monitor performs with this collected data. This includes such actions as analysis, alerting, and streaming to external systems.
![Vista de alto nivel de Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/media/overview/overview.png)

### Azure Service Health
Visualizar y agrega alertas para:
* Problemas de servicio
* Mantenimiento planeado
* Avisos de estado

## Azure Seguridad
### Azure Security Center
Panel de alertas y sugerencias.
Supervisa el nivel de seguridad en los recursos, tanto en azure como en el entorno local.

### Azure Defender
Supervisa el nivel de seguridad en los recursos, tanto en azure como en el entorno local.
* Por pago por cada servicio
* Acceso Just-in-Time, no tenemos que tener el puerto SSH abierto todo el tiempo
* Control de aplicaciones
* Protección de red
* Revisar Integridad de Archivos

### Azure Sentinel
Administra  amenazas y permite responder a incidentes.
* Recompilar datos en la nube a gran escala
* Detectar amenazas no detectadas anteriormente
* Investigar amenazas con inteligencia artificial
* Responder a incidentes rápidamente

### Azure Key Vault
* Administracion de secretos
* Administrar claves de cifrado
* Administracion de certificados SSL/TLS
* Almacenar secretos respaldados por hardware

#### Ventajas
* Centralización
* Seguridad
* Monitoreo y Control
    * Podemos restringir acceso para que solo pueda acceder a una llave una maquina virtual, por ejemplo.
* Integración

### Azure Dedicated Host
Poder dedicar un servidor, unicamente para nosotros.

* Permite el cumplimiento de normativas.
* Permite elegir las características del servidor, tamaño de VMs, tipo de VMs.
* Otorga visibilidad y control de la infraestructura del servidor.
* Control sobre el horario de mantenimiento.

## Azure Seguridad de red

### Defensa en profundidad
Niveles en los que se tienen que proteger los datos y aplicaciones para que esten protegidos.

1. Datos, se vera a lo largo del curso 2
2. Aplicación, configuracion de permisos, etc.
3. Proceso
4. Red, usuario tiene que tener cuidado de como agregamos acceso a internet a nuestros servicios
5. Perimetro, Azure Backroom para interconexion entre datacenters de Microsoft, tiene algunos nodos a internet, estos se encuentran protegidos
6. Identidad y Acceso, Azure tiene varias certificaciones en este aspecto
7. Física

### Principios CIA
* Confidencialidad
* Integridad
* Disponibilidad

### Network

#### Key takeaways
* Una red virtual se limita a una unica region.
* Subred creada por default para la red virtual cuando se crea: `default`
* Por default, recursos entre distintas subredes se pueden comunicar
* No se puede comunicar recursos entre distintas regiones (por estar en distintas vnets)

### Azure Firewall
Proporciona una ubicacion central para crear, aplicar y registrar directivas de conectividad en la red y de aplicaciones entre subscripciones y redes virtuales.

### Azure DDoS Protection
#### Planes disponibles
* Básico
* Estandar

#### Tipos de ataques
* Volumétricos
* De protocolo
* Nivel de recurso

### Azure Network Security Groups

### Azure Vnet Peering
Conecta redes virtuales de tal forma que se administren como una sola.

* Bandwidth ilimitado
* Baja latencia
* Solo conecta Vnets de Azure
* Costo por ingreso y egreso
* Usa la red perimetral entre datacenters de Azure

### Azure VPN Gateway
Conecta redes mediante un canal encriptado.

* Bandwidth limitado.
* Latencia moderado
* Conecta cualquier red
* Puede usarse para conectarse a recursos de la compañia, ej. nube híbrida.

### Azure Load Balancer
Distribuye el tráfico entre diferentes servicios de Azure Compute.

* Es gratis con una sola ip pública.
* Solo puede usarse con servicios de Azure Compute.
* No se puede distribuir trabajo con servicios externos.
* No se puede usar un dominio con esta.

### Azure Application Gateway
Distribuye y administra el tráfico de aplicaciones web.

* Terminacion SSL.
* Redirección.
* Web firewall.
* Paginas de error personalizadas.
* Routing personalizado.

Puede usarse con cualquier IP.

## Azure Express Route
Crea un link físico mediante proveedores con los que Azure tiene un acuerdo.

## Proceso de configuracion basica de red
1. Crear una red virtual
2. Crear subred dentro del vnet
3. Asignar recursos
4. ...

## Azure: Servicios de Identidad
Autenticación: Determina si el usuario es quien dice ser.   
Autorización: Especifica a que datos peude acceder y que puede hacer con ellos.

### Azure Active Directory
* Autentificacion
* Inicio de sesión unico
* Administración de aplicaciones
* Administración de dispositivos

Premium, acceso condicional. Eg. si esta afuera de la empresa, usar autenticación multifactor.

#### Azure AD Connect
Permite sincronizar con dispositivos locales (?)

#### Autentificacion multifactor
Combinación de 2 o mas elementos.
* Algo que conoce (Contraseñas, etc.)
* Algo que tiene (Un dispositivo, una tarjeta, etc.)
* Algo que es (Huella dactilar, iris del ojo, etc.)

#### Opciones para autenticación multifactor en Azure AD
* Llamada
* SMS
* M Authenticator (única disponible en el free tier)

## Azure Gobernanza y cumplimiento
Gobernanza: Proceso general por el que se establecen reglas
Cumplimiento

### Plataforma de ...

### Gobernanza mediante subscripciones
* Facturacion
* Acceso
* 

### Control de acceso basado en roles

### Bloqueo de recursos
* CanNotDelete
* ReadOnly

### Azure Policy
Evalua los recursos y reslata los que no cumplen las directivas que hemos creado. En Azure Policy puede impedir que se creen recursos no conformes.
* Crear una definicion de directiva
* Asignar la definicion a los recursos
* Revisar los recursos de evaluacion

Pueden trabajar con etiquetas, tipos de recursos
Las iniciativas son un grupo de definiciones de directivas relacionadas

### Uso de etiqueta
* Administracion de recursos
* Optimizacion y administracion de costes (ej. borrar automaticamente recursos de prueba)
* Administracion de operaciones
* Seguridad
* Gobernanza y cumplimiento normativo
* Automatización y optimización de las cargas de trabajo

### Azure Blueprint
Organiza la implementación de varias plantillas de recursos y de otros artefactos, cmo son los siguientes:
* Asignación de roles
* Asignación de directivas
* Plantillas de Azure Resource Manager
* Grupos de recursos

### Cumplimiento

Cumplimiento: Cumplir una ley..

### Microsoft Privacy Statement
Uso de datos

## Azure Planeacion de Costos

### Azure Calculadora TCO (Costo total de propiedad)
* Se puede usar sin cuenta *

Calcular diferencia de costos entre un servidor dentro de la empresa y mudarse a la nube de Microsoft.

### Tipos de subscripciones
* Gratuita
* Pago por uso
* Ofertas a miembros

### Formas de comprar servicios
* Contrato entreprise
* Por medio de la web
* Proveedor de soluciones

### Factores que afectan al costo
* Tipo de recuros
* Medidores de uso
* Uso de recursos
* Tipo de subscripcion
* Ubicacion
* Tráfico de red
    * Trafico entre zonas de red es mas barato

### Zonas de red
* Zona 1: Centro de Australia, Oeste de EE.UU., Este de EE.UU.

### Minimizar costos
* Azure Advisor
* Límites de gasto
* Reservas de Azure
* Tipo de subscripción
* Ubicación
* Tráfico de red

### Calculadora de costos
* Se puede usar sin cuenta *

### Minimizar costos
* Tamaño de VMs
* Des-asingar VMs
* Eliminar recursos
* IaaS to PaaS
* Elección de SO
* Reutilización de licencias

### Azure Cost Management
Servicio de azure que nos ayuda analizar y administrar los costos, entre las características importantes que contiene:
* Budgets
* Alertas
* Analisis
* Exportar

### Service Level Agreement
Nos indican el compromiso de Microsoft y el cliente para proveer un nivel de servicio.
Esto se hace por medio de porcentaje que se puede traducir a tiempo de inactividad de un servicio.