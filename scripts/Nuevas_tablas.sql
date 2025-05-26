- Creación de nuevas tablas

CREATE TABLE auditoria_estado_tarjeta (
    id SERIAL PRIMARY KEY,
    tarjeta_id INTEGER NOT NULL,
    estado_anterior VARCHAR(50),
    estado_nuevo VARCHAR(50),
    fecha_cambio TIMESTAMP NOT NULL DEFAULT NOW()
);

