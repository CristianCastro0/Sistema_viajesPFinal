-- Consultas sobre dispositivos validadores

-- en este caso creamos dos tablas 

--tabla dispositivos
CREATE TABLE dispositivos (
dispositivo_id SERIAL PRIMARY KEY,
tipo VARCHAR(20), --e.g. 'móvil', 'torniquete'
ubicacion VARCHAR(100)
  );

--tabla validacion
CREATE TABLE validaciones (
validacion_id SERIAL PRIMARY KEY,
viaje_id INT REFERENCES viajes(viaje_id),
dispositivo_id INT REFERENCES dispositivos(dispositivo_id),
fecha_validacion DATE NOT NULL
);

--Datos de ejemplo

INSERT INTO dispositivos(tipo, ubicacion) VALUES
  ('móvil',     'Validador móvil A'),
  ('torniquete','Torniquete Norte'),
  ('móvil',     'Validador móvil B');
-- ...... 97+

INSERT INTO viajes(fecha, estacion_abordaje_id, tarifa_id, tarjeta_id) VALUES
  ('2025-04-01', 1, 1, 1),
  ('2025-04-02', 2, 2, 2),
  ('2025-04-03', 1, 1, 3),
  ('2025-04-04', 3, 3, 1),
  ('2025-04-05', 2, 2, 2),
  ('2025-04-06', 1, 1, 3);

INSERT INTO validaciones(viaje_id, dispositivo_id, fecha_validacion) VALUES
  (1, 1, '2025-04-01'),
  (2, 2, '2025-04-02'),
  (3, 1, '2025-04-03'),
  (4, 3, '2025-04-04'),
  (5, 1, '2025-04-05');
-- ....... 95+

-- Consultas

--1 Viajes sin registro de validación
SELECT
  v.viaje_id,
  v.fecha,
  v.tarjeta_id
FROM viajes v
LEFT JOIN validaciones va ON v.viaje_id = va.viaje_id
WHERE va.validacion_id IS NULL;

--2 Validaciones realizadas por dispositivos de tipo móvil en abril de 2025
SELECT
  d.dispositivo_id,
  d.ubicacion,
  COUNT(*) AS total_validaciones
FROM validaciones va
JOIN dispositivos d ON va.dispositivo_id = d.dispositivo_id
WHERE d.tipo = 'móvil'
  AND EXTRACT(YEAR  FROM va.fecha_validacion) = 2025
  AND EXTRACT(MONTH FROM va.fecha_validacion) = 4
GROUP BY d.dispositivo_id, d.ubicacion
ORDER BY total_validaciones DESC;

-- 3 Dispositivo con mayor cantidad de validaciones
SELECT
  va.dispositivo_id,
  COUNT(*) AS total_validaciones
FROM validaciones va
GROUP BY va.dispositivo_id
ORDER BY total_validaciones DESC
LIMIT 1;
