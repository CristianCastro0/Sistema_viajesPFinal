- Creación de nuevas tablas

CREATE TABLE tarjeta_auditoria (
auditoria_id SERIAL PRIMARY KEY,
tarjeta_id INT NOT NULL REFERENCES tarjetas(tarjeta_id),
estado_anterior VARCHAR(20),
estado_nuevo VARCHAR(20),
fecha_cambio DATE NOT NULL
);

CREATE TABLE dispositivos (
    dispositivo_id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100)
);

CREATE TABLE dispositivo_validacion (
    id SERIAL PRIMARY KEY,
    viaje_id INTEGER NOT NULL,
    dispositivo_id INTEGER NOT NULL,
    fecha_validacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (viaje_id) REFERENCES viajes(viaje_id),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(dispositivo_id)
);
