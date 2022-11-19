# Automatización

## DevOps
### Definicion oficial de Microsoft
Son herramientas, marcos de trabajo y cultura que permite agregar valor constantemente al cliente.

### Azure Continuous Integration


### Azure Continous Deployment
#### Continuous Delivery
Todo cambio al repositorio es cambio que se puede desplegar.
Aunque eleccion si hacerle deployment puede hacerse de manera manual.

#### Continous Deployment
Todo lo del repositorio se puede desplegar automaticamente.

#### Porque usar CD?
* Que parece es más seguro 1 o 100 cambios?
* Contexto de lo que estabamos trabajando, programado sabe que hizo en cierta seccion del programa
* La version de desarrollo es la versión en producción
* Solución más rápida de problemas
* Experiencia continua de mejora del producto para los usuarios

#### Requisitos
* Alta calidad de los tests
* Commits o merge continuos


## Opciones de despliegue
* AZ Powershell
* AZ Cli
* Azure Portal
* ARM Templates (es lo que crean todas estas herramientas)

## Manejo de infraestructura
### Despliegue tradicional (sin IaC)
#### Problemas
* Alto potencial de error
* Ocultación de detalles de implementación
* Riesgos de cambios por parte del proveedor de nube
* Conocimiento centrado en una persona/grupo

### Despliege Infrastructure as Code
#### Ventajas
* Creación, replicación y correción
* Parametrización
* Control de versiones
* Mejor entendimiento

#### Desventajas
* Tiempo de aprendizaje considerable
* Uso de herramientas adicionales
* Tiempo inicial de implementación

#### Opciones
* HashiCorp Terraform
* Pulumi
* Ansible
* Chief
* Opciones de Azure

### Herramientas
#### Tipo de definición
##### Declativa
* Describe el resultado esperado
* El sisteam se encargue de descubrir los pasos
* Terraform, Pulumi

##### Imperativa
* Describe los pasos a seguir de manera explícita

##### Lenguajes de programación
* Uso de ciclos, etc.
* Conocimiento de lenguaje
* Uso de herramientas como linters, etc.
* Pulumi

##### YAML
* Terraform

### Despliegue con ARM templates
#### Ventajas
* Repetible
* Orquestrable
* Exportable
* Permite autorización
* Modular

### BICEP
* Soporte continuo
* Sintaxis simple
* Fácil de usar

## Automatización de tareas en Azure

### Elastic Jobs
![Diagrama de funcionamiento](https://docs.microsoft.com/en-us/azure/sql-database/media/elastic-jobs-overview/conceptual-diagram.png)

#### Casos de uso
* Automatizar tareas de administracion que se ejecutan a un tiempo fijo.
* Movimiento de datos
* Recompilacion y agregacion de datos para informes u otros fines.
* Carga de datos desde Azure Blob Storage
* Procesamiento de datos en un gran número de bases de datos

### Elastic Automation
Permite automatizar cualquier cosa en nuestra cuenta de Azure.

#### Runbook
Unidad mínima de ejecución compuesta de una serie de acciones que Azure puede ejecutar.
Se puede ejecutar codigo: 
* Powershell
* Python
*  Graphical workbook (basado en Powershell)

#### Modulos
Librerias o paquetes de python o powershell instalados en el entorno de ejecución.

#### Schedule
Cuando se ejecuta un Runbook.
### Azure Functions
* Normalmente sin estado, pero Durable Functions proporciona estado.
* Imperativo
* Alrededor de una decoena de tipos de enlacnes integrados
* Escritura de código
* Azure Applications Insights para supervision
* Se puede ejecutar localmente o en la nube

### Azure Logics Apps
Con estado
Orientado al diseñador
Gran coleccion de conectores. Enterprise Integration Pack para escenarios B2B.
Gran coleccion de acciones listas para usar.
Supervisión: Azure Portal, log analytics
Solo se ejecuta en la nubre

## Azure Gobernanza
### Gobernanza
Proceso general por el que se establecen reglas, directivas y se garantiza que esas reglas y directivas se aplican.

### Objetivo
Cumplir con estándars del sector y empresariales.

### Requisitos
Para aplicar correctamente la gobernanza y cumplimiento es importante entender los requerimientos.

### Control de acceso basado en roles
![Matriz rol/ambito en azure](https://docs.microsoft.com/es-es/azure/cloud-adoption-framework/ready/azure-setup-guide/media/manage-access/role-examples.png)

#### Ambito/scope
Sobre que tengo acceso.

### Uso de etiquetas
* Administración de recursos
* Optimización y administración de operaciones
* Seguridad
* Gobernanza y cumplimiento normativo
* Automatización y optimización de las cargas de trabajo

### Azure Policy
Azure Policy evalua los recuros y resalta los que no cumplen las directivas que hemos creado. Azure Policy también  puede impedir que se creen recursos no conformes.
* Crear una definición de directiva
* Asignar la definición a los recursos
* Revisar los resultados de evaluación

Las iniciativas son un grupo de definiciones de directivas relacionadas.

### Azure initiative
Grupo de azure policies.

### Azure Blueprints
Organiza la implementación de varias plantillas de recursos y de otros artefactos, como son los siguientes:
* Asignación de roles
* Asignación de directivas
* Plantillas de Azure Resource Manager
* Grupo de recursos

## Notas Kahoot
* Es posible almacenar tareas en un procedimiento almacenado.
* SQL Server Agent puede correr Paquetes de SQL Server
* *Rebuild*, recalcula estadisticas indice
* Quita archivos antiguos relacionados a plan de mantenimiento: *Maintenance cleanup*
* Elastic Jobs solo puede correr T-SQL, es una de sus desventajas
* Scope para un trabajo elastico SQL: Target group
* Azure automation: Python y Powershell