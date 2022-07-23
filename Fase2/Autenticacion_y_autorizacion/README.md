# Proteccion de los datos

## Autenticacion
Determina si el usuario es quien dice ser.

## Autorizacion
Espeficia a que datos tiene el acceso el usuario.

## Active Directory
### Azure Active Directory
Azure AD es utilizado por administradores, desarrolladores, usuarios y servicios en linea.

Azure AD Connect te permite sincronizar las identidades de un entorno local con la nube.

#### Funciones
Autenticacion
Inicio de sesion unico
Administracion de aplicaciones
Administracion de dispositivos

#### Autenticacion multifactor
Combinacion de 2 o mas de los elementos. Algo que el usuario
Conoce
Tiene
Es

## Alcance y jeranquia
Permisos a nivel servidor
Permisos a nivel BD
Permisos a nivel schema, estructura de las tablas
Permisos a nivel objeto, tabla, vista, funcion, etc.

## Traditional Login
### Login 
Identifica el metodo de autentificacion
Contraseña
Windows User
Azure AD
A nivel servidor, almacenado en master

### User
A nivel de BDD, se le asignan roles y permisos de BDD.

## Contained Users
No existe login asociado
Cada usuario tiene su propio metodo de autentificacion
1:34

## Roles

### Aplication roles

## Permisos
### Tablas y vistas
Select
Insert
Update
Delete
References
Control, todos los controles
Take ownership
View definition, nos muestra el codigo SQL de como se creo una vista
View change tracking

### Funciones y procedimientos almacenados
Alter
Control
Execute
View definitio
View chagne tracking

### Cadena de propiedad
Es un proceso que permite a los usuarios heredar los permisos de otros objetos.

### Principio de minimo privilegio
Consiste en la asignacion de los permisos necesario y suficientes a un usuario para desempeñar sus actividades dentro de su empresa, por un tiempo limitado, y con el minimo de derechos necesarios para sus tareas.

## Problemas comunes
* Información de login incorrecta
* Configuración incorrecta de Firewall o GS
* Estado del servicio
* Fallos transitorios

### Fallos transitorios
En carga alta de trabajo muy alta o reconfigurando características de hardware el cliente puede perder conexion a la BDD. Estos eventos duran menos de 60 segundos.

Problema | Acción a tomar
-|-
Login failure | Revisar Azure Service Health
Resource limit errors | Monitorear los recursos de la base de datos, configurar alertas y modifica los recursos antes de que se alcancen los limites.
Extended errors | Envia una peticion de soporte si tienes un problema de conectividad al dia o los problemas duran mas de 60 segundos.

#### Logica de reintento
Iniciar con un tiempo de espera e ir subiendo el tiempo de forma exponencial hasta 60 segundos.
Esta mecánica también es necesaria si se quiere hacer uso de serverless.

#### Diagnosticar problemas de conexión
*(En examen puede venir como ordenar en nivel correctos)*
* Revisar el estado del login en la vista `sys.sql_logins`
* Si el login esta desactivado, activarlo con `ALTER LOGIN <user> ENABLE`
* Si el login no existe crearlo
* Asignarle un rol u acceso a una o más bases de datos

## Datos adicionales
### BCP funciona con AD
Si funciona, en la version 15 en adelante.

## Data Factory archivo nombre dinámico
En la parte donde se da de alta archivo de origen. Hay una seccion para configurar parametros como hora, dia o mes, de forma que se pueda ejecutar de manera periodica.

## BCP funciona de manera transaccional
Con el parametro -m o --maxerrors definimos numero maximo de renglones a ignorar, si sucede mas de esa cantidad de errores en la ejecucion, entonces se hace rollback de todo.

## Esquemas embebidos
No, solo se puede un nivel de esquemas en 

