## Compresion de datos

## Ventajas
* Menor capacidad de espacio requerida
* Menor cantidad de paginas leidas o escritas en ciertas queries

## Desventajas
* Mayor uso de CPU para comprimir/descomprimir los datos durante las operaciones de lectura/escritura

# Tipos de compresión
* Rowstore
    * Row compression
    * Page compression
* Columnstore
    * Columnstore compression
    * Columnstore archival compression

## Row compresion
Cambia la manera en la que se almacenan los tipos de datos para reducir espacio.

## Page compression
Aplica row compresion, seguido de prefix y dictionary compression. Esta es la que aplica mayor nivel de compresión.

## Columstore compression
Hecho por default en un columnstore.

## Columnstore archival compression


