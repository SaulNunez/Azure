# Protección de datos en reposo y en transito

## Tipos de cifrado
* Cifrado en reposo
* Cifrado en transito
* Crifrado en uso
    * Cifrar datos en memoria

## Transparent Data Encryption
* Cifrado en reposo.
* Cifrado a nivel de página, no de tabla ni de columna.
* No requiere ningún cambio  a nivel de aplicación.
* SQL Server: Habilitado por defecto a partir de 2017.
* SQL Managed instances: Habilitado por defecto a partir del 2019.
* Maquina virtual de SQL: Azure Disk Encryption habilitado.

![Transparent Data Encryption Arquitecture](https://docs.microsoft.com/en-us/sql/relational-databases/security/encryption/media/tde-architecture.png?view=sql-server-ver16)

[Notebook Transparent Data Encryption](./TransparentDataEncryptionExercise.ipynb)

## Reglas de firewall para servidor y base de datos
![How the firewall works in Azure SQL](https://docs.microsoft.com/en-us/azure/azure-sql/database/media/firewall-configure/sqldb-firewall-1.png?view=azuresql)

Obtener informacion de Firewall desde Azure SQL.

Alguien en reglas a nivel servidor puede acceder a todas las bases de datos. Solo debe ser utilizado por administradores de la base de datos.

Para administrar Firewall del servidor se usan las reglas.

[Notebook Configurar Firewall](./ConfigurarFirewall.ipynb)

### Como revisar reglas del Firewall
```sql
SELECT * FROM sys.firewall_rules
```

Regla 0.0.0.0 a 0.0.0.0 en contexto de azure es a todos los recursos en mi subcripción.

## Metodos de conexion privados
* Service Endpoint
* Private Link

## Always encrypted
Cuando hay conexion a la base de datos el servidor pide huella del certificado web. El punto es que el que tiene acceso a los certificados tengan acceso a los datos. Cuando se manda, se cifra la información camino al cliente.


Escenarios de utilidad | Donde guardar el certificado
-|-
Client and Data on premises | Guardar certificado en key store sin acceso a los administradores. Por ejemplo, en otro servidor sin acceso.
Client on premises Data in Azure | Guardar certificado en Azure Key Vault.
Client and Data in Azure | Guardar certificado en Azure Key Vault. No se puede proteger totalmente, dueño de la subscripcion puede acceder a todos los servicios de Key Vault y de la base de datos.

#### String de Conexion
Agregar `Column Encryption Setting=Enabled`.

#### Insercion y update
Requiere que se haga mediante procedimientos.

### Tipos de cifrado
Deterministico
* Menos seguro
* Mas flexible

Random
* Mas seguro
* Menos flexible

### Permisos para always encrypted

x | Alter any column master key | Alter any column encryption key | View any column master key definition | View any column encryption key definition
 -|-|-|-|-
Administracion de llaves | ✅ | ✅ | ✅ | ✅


### Secure enclaves
Lugares en RAM exclusivos para realizar operaciones de desencriptación.

## Conexiones cifradas
Se cifran mediante TLS. Version minima de TLS soportada 1.0. 

## Injección SQL

## Controles de cumplimiento

### Data classification
A partir de 2019 podemos consultar los metadatos de clasificación en la vista de sistema.

```sql
SELECT *  FROM sys.sensitivity_classifications;
```

```sql
ADD SENSITIVITY CLASSIFICIATION TO
    [Application].[People].[EmailAddress]
WITH (LABEL="PII", INFORMATION_TYPE='Email');
```

### GDPR
#### Public
Datos preparados y aprobados para compartirse de forma pública.

#### General
Datos que pueden compartirse con externos según se requiera.

#### Confidential
Datos no de una persona fisica, pero que si se liberan pudieran causar daño al negocio.

#### Highly Confidential
Datos que si se filtran pueden dañar gravemente al negocio.

### Acciones registradas por defecto
#### `BATCH_COMPLETED_GROUP`
Audita todas las consultas y procedimientos almacenados que se ejecutan en la base de datos.

#### `SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP`
Esto indica que una entidad de seguridad inicio sesion correctamente en la base de datos.

#### `FAILED_DATABASE_AUTHENTICATION_GROUP`
Esto indica que una entidad de seguridad no pudo iniciar sesión en la base de datos.

### Enmascaramiento dinamico de datos
Ocultar datos de manera visible para que no se vean cuando se hacen consultas.

Tipos de enmascaramiento
* Default
* Partial, por ejemplo para tarjeta de credito, ver solo los ultimo 4 digitos.
* Solo ver la primera letra, para corresot electronicos
* Numeros
* Cadena personalizada

[Practica](./03-DynamicDataMaskingExercise.ipynb)

### Seguridad a nivel de renglón
[Practica](./04-RowSecurityExercise.ipynb)

#### Filter predicates
Access | Definición
----|----
SELECT | No se pueden ver las filas filtradas
UPDATE | No se pueden actualizar las filas filtradas
DELETE | No se pueden eliminar las filas filtradas
INSERT | No aplicable

#### Block predicates
Access | Definición
---|---
AFTER INSERT | Impide que los usuarios inserten filas con valores que infrinjan el predicado
AFTER UPDATE | Impide que los usuarios actualicen filas a valores que infrinjan el predicado
BEFORE UPDATE | Impide que los usuarios actualicen filas que infrinjan el predicado en la actualidad
BEFORE DELETE | Bloquea las operaciones de eliminación si la fila infringe el predicado

### Microsoft Defender for Azure SQL
Proteje de:
* SQL Injection
* Unusual Access
* Common Attacks
* Brute Force Attacks

### SQL Database Ledger
![Ledger overview](https://docs.microsoft.com/en-us/sql/relational-databases/security/ledger/media/ledger/ledger-table-architecture.png?view=sql-server-ver16)

[Documentacion oficial](https://docs.microsoft.com/en-us/sql/relational-databases/security/ledger/ledger-overview?view=sql-server-ver16)

Revisa que la base de datos no se haya modificado de manera externa.

### Azure Purview
Lugar centralizado para administrar.
* Clasificacion de confidencialidad
