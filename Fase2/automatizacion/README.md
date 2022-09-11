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

## Fases de Continuous Deployment

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