## Integrantes

Brayan S. Fuentes Rios
Cristian C. Castelblanco Castro

## 📌 Introducción

Este documento describe el proyecto de Sistema de Viajes y Recargas, su diseño de base de datos, las mejoras implementadas y ejemplos de consultas SQL que validan su correcto funcionamiento. Está pensado como guía rápida para desarrolladores y analistas.

## 🎯 Objetivos Generales

Diseño y normalización de una base de datos relacional que soporte operaciones de recarga y registro de viajes.

Implementar mecanismos de auditoría y histórico para seguimiento de cambios de estado.

Añadir soporte a promociones en recargas, con forma de bonos o descuentos.

Registrar la fuente de validación de cada viaje (dispositivo físico o móvil).

Proponer y añadir una mejora adicional que aporte valor al análisis de la operación.

## 📂 Estructura de la Base de Datos

USUARIOS: datos personales y fecha de registro.

TARJETAS: relación con usuario, fechas de adquisición y actualización, estado actual.

RECARGAS: monto, fecha, punto de recarga, tarjeta y promoción aplicada.

VIAJES: fecha, estación de abordaje, tarifa y tarjeta usada.

PUNTOS_RECARGA: ubicación y localidad.

ESTACIONES: detalle de estaciones, su localidad y geolocalización.

TARIFAS: valores asociados a cada viaje.

LOCALIDADES: nombres y claves primarias.

## 🛠 Mejoras Implementadas

1. Auditoría del Estado de Tarjetas

Tabla: tarjeta_auditoria (guarda cambios de estado con sellos de tiempo).

Consultas clave:

Cambios por mes (último año).

Top 5 tarjetas con más movimientos.

2. Promociones en Recargas

Tabla: promociones (nombre, descripción).

Campo añadido: promocion_id en recargas.

Consultas clave:

Recargas con detalle de promoción.

Total recargado por promoción (últimos 3 meses).

Promociones que incluyan “bonus”.

3. Registro de Dispositivos de Validación

Tablas: dispositivos (tipo, ubicación), validaciones (viaje, dispositivo, fecha).

Consultas clave:

Viajes sin validación.

Validaciones por móviles en abril/2025.

Dispositivo con más validaciones.

4. Mejora Adicional: Retroalimentación de Usuarios

Tabla: retroalimentacion (viaje, usuario, rating, comentario, fecha).

Consultas clave:

Promedio de rating por estación.

Top 3 usuarios con más comentarios.

Comentarios que contengan “queja”.


## 🚀 Población de Datos de Prueba
 
Se incluyen datos de ejemplo que permiten validar el funcionamiento del sistema y verificar que las consultas arrojan resultados coherentes. La población de datos se organiza en las siguientes categorías:
 
Estados de tarjetas (auditoría): Cambios de estado de las tarjetas a lo largo del tiempo.
 
Promociones y recargas: Diferentes tipos de promociones aplicadas a recargas realizadas por los usuarios.
 
Dispositivos y validaciones: Validaciones realizadas por los usuarios al momento de abordar mediante distintos dispositivos.
 
Retroalimentación de usuarios: Comentarios, calificaciones y fechas relacionados con los viajes realizados.
 
 
 
## 📋 Ejecución de Consultas
 
Para realizar las pruebas, sigue estos pasos:
 
1. Importar las tablas (DDL): Ejecuta el script que crea todas las tablas en PostgreSQL.
 
 
2. Insertar los datos de prueba: Ejecuta los scripts INSERT que contienen los datos mencionados anteriormente. Es importante seguir este orden:

 para el primer punto Auditoria Insertar los datos en las siguientes tablas
 
**TARJETA_AUDITORIA**
 
 para el segundo punto Promociones Inertar los datos en las siguientes tablas
 
**PROMOCIONES**

 para el tercer punto Validadores Insertar los  datos en las sigientes tablas
 
**VALIDADORES**
 
**VALIDACIONES**

Para el cuarto punto Retroalimentacion (Mejora) Insertar los datos en las siguientes tablas
 
**RETROALIMENTACION**
 
3. Ejecutar las consultas: Dirígete a la sección de Scripts y consultas, copia las consultas y ejecútalas en el entorno de PostgreSQL.
 
 
4. Verificar resultados: Asegúrate de que los datos devueltos tengan sentido respecto a los datos de ejemplo y analiza la información obtenida.
 

## 🔍 Ejemplo de Consulta

-- Top 5 tarjetas con más cambios de estado

SELECT tarjeta_id, COUNT(*) AS cambios
FROM tarjeta_auditoria
GROUP BY tarjeta_id
ORDER BY cambios DESC
LIMIT 5;

## 📈 Conclusiones

La ampliación del modelo de datos con auditorías, promociones, validaciones y retroalimentación permite:

Trazabilidad completa de cambios y eventos.

Análisis comercial de promociones.

Estadísticas de uso según dispositivo y retroalimentación.

Facilita la toma de decisiones operativas y de negocio.

Este README sirve como base para extender aún más el sistema y adaptarlo a nuevos requerimientos.

## Diagrama de Entidad-Relación
 
```mermaid
erDiagram
    USUARIOS {
        INT usuario_id PK
        VARCHAR nombre
        VARCHAR apellido
        VARCHAR genero
        DATE fecha_registro
        DATE fecha_nacimiento
        VARCHAR correo_electronico
        VARCHAR celular
        VARCHAR ciudad_nacimiento
        INT localidad_id FK
    }
    LOCALIDADES {
        INT localidad_id PK
        VARCHAR nombre
    }
    TARJETAS {
        INT tarjeta_id PK
        INT usuario_id FK
        DATE fecha_adquisicion
        VARCHAR estado
        DATE fecha_actualizacion
    }
    TARJETA_AUDITORIA {
        INT auditoria_id PK
        INT tarjeta_id FK
        VARCHAR estado_anterior
        VARCHAR estado_nuevo
        DATE fecha_cambio
    }
    PROMOCIONES {
        INT promocion_id PK
        VARCHAR nombre
        TEXT descripcion
    }
    RECARGAS {
        INT recarga_id PK
        DATE fecha
        NUMERIC monto
        INT punto_recarga_id FK
        INT tarjeta_id FK
        INT promocion_id FK
    }
    PUNTOS_RECARGA {
        INT punto_recarga_id PK
        VARCHAR direccion
        INT localidad_id FK
    }
    ESTACIONES {
        INT estacion_id PK
        VARCHAR nombre
        INT localidad_id FK
    }
    TARIFAS {
        INT tarifa_id PK
        NUMERIC valor
    }
    VIAJES {
        INT viaje_id PK
        DATE fecha
        INT estacion_abordaje_id FK
        INT tarifa_id FK
        INT tarjeta_id FK
    }
    VALIDADORES {
        INT dispositivo_id PK
        VARCHAR tipo
        VARCHAR ubicacion
    }
    VALIDACIONES {
        INT validacion_id PK
        INT viaje_id FK
        INT dispositivo_id FK
        DATE fecha_validacion
    }
    RETROALIMENTACION {
        INT retro_id PK
        INT viaje_id FK
        INT usuario_id FK
        INT rating
        TEXT comentario
        DATE fecha_envio
    }
 
    LOCALIDADES ||--o{ USUARIOS          : tiene
    LOCALIDADES ||--o{ PUNTOS_RECARGA    : ubica
    LOCALIDADES ||--o{ ESTACIONES        : ubica
 
    USUARIOS ||--o{ TARJETAS           : posee
    TARJETAS ||--o{ RECARGAS           : recibe
    TARJETAS ||--o{ VIAJES             : usa
    TARJETAS ||--o{ TARJETA_AUDITORIA  : audita
 
    PUNTOS_RECARGA ||--o{ RECARGAS       : registra
 
    ESTACIONES ||--o{ VIAJES            : inicia
 
    TARIFAS ||--o{ VIAJES               : fija
 
    RECARGAS }o--|| PROMOCIONES         : aplica
 
    VIAJES ||--o{ VALIDACIONES         : validado_por
    VALIDACIONES }o--|| VALIDADORES       : usa
 
    VIAJES ||--o{ RETROALIMENTACION    : reseña
    USUARIOS ||--o{ RETROALIMENTACION   : escribe
 
