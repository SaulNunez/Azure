# Diseño basado en rendimiento

## Normalización
### Primera forma normal
* Todos los atributos son atomicos
* Existencia de llave primaria única
* La clave primara no contiene atributos nulos
* No debe existir variación en el numero de columnas
* Independencia en el orden
* No deben existir grupos repetidos

### Segunda forma normal
* SI los atributos que no forman parte de ninguna clave dependen

### Tercera formal normal
* Todo atributo no clave debe 

## Denormalización
### Tipo estrella
Separa la información en verdades y en dimensiones. Las dimensiones es la forma en la que queremos analizar la información.

### Tipo copo de nieve
Similar al tipo estrella pero separa información repetida en tablas separadas para reducir consumo de memoria.

## Tipos de datos
### Exact numerics
* bigint
* numeric
* bit
* smallint
* decimal
* int
* money
* smallmoney

## Approximate numerics
* float
* real

### Character strings
* char
* varchar
* text

### Unicode strings
* nchar
* nvarchar
* ntext

### Date and time
* date
* datetimeoffset
* datetime
* smalldatetime
* datetime2
* time

### Binary strings
* binary
* varbinary
* image

## Conversiónn de datos

## Precedencia
Si necesita SQL Server cambia un tipo de dato, lo hara al tipo de dato con la mayor precedencia (menor número)

1. user-defined data types
2. sql_variant
3. xml
4. datetimeoffset
5. datetime2
6. datetime
7. smalldatetime
8. date
9. time
10. float
11. real

## Indexes
### Column store
A partir de 1024 filas tiene optimizaciones para bulk-insert.

### Memory optimized
Todo en memoria RAM:

* Hash: Utilizando una función para dividir en buckets de datos.
* Non-clustered: Crea un índice separado utilizando un árbol binario haciendo referencia a los registros.