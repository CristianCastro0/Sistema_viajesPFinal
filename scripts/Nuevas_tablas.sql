- Creación de nuevas tablas
    
-- tabla Tarjeta auditoria
CREATE TABLE tarjeta_auditoria (
auditoria_id SERIAL PRIMARY KEY,
tarjeta_id INT NOT NULL REFERENCES tarjetas(tarjeta_id),
estado_anterior VARCHAR(20),
estado_nuevo VARCHAR(20),
fecha_cambio DATE NOT NULL
);

--tabla promocion
CREATE TABLE promociones (
promocion_id SERIAL PRIMARY KEY,
nombre VARCHAR(50),
descripcion TEXT
);
ALTER TABLE recargas ADD COLUMN promocion_id INT REFERENCES promociones(promocion_id);

-- tabla dispositivo
CREATE TABLE dispositivos (
dispositivo_id SERIAL PRIMARY KEY,
tipo VARCHAR(50) NOT NULL,
ubicacion VARCHAR(100)
);

--tabla validcion
CREATE TABLE validaciones (
validacion_id SERIAL PRIMARY KEY,
viaje_id INT REFERENCES viajes(viaje_id),
dispositivo_id INT REFERENCES dispositivos(dispositivo_id),
fecha_validacion DATE NOT NULL
);

