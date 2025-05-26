-- auditoria para el estado de las tarjetas
--Creamos tabla
CREATE TABLE tarjeta_auditoria (
auditoria_id SERIAL PRIMARY KEY,
tarjeta_id INT NOT NULL REFERENCES tarjetas(tarjeta_id),
estado_anterior VARCHAR(20),
estado_nuevo VARCHAR(20),
fecha_cambio DATE NOT NULL
);

--  Datos de ejemplo
INSERT INTO tarjeta_auditoria(tarjeta_id, estado_anterior, estado_nuevo, fecha_cambio) VALUES
  (1, 'Activa',    'Bloqueada',    '2024-01-15'),
  (1, 'Bloqueada', 'Activa',       '2024-02-10'),
  (2, 'Activa',    'Cancelada',    '2024-03-05'),
  (3, 'Activa',    'Bloqueada',    '2024-04-20'),
  (1, 'Activa',    'Bloqueada',    '2024-05-01'),
  (2, 'Cancelada', 'Activa',       '2024-06-12'),
  (3, 'Bloqueada', 'Activa',       '2024-07-03'),
  (1, 'Bloqueada', 'Cancelada',    '2024-08-17'),
  (2, 'Activa',    'Bloqueada',    '2024-09-22'),
  (3, 'Activa',    'Cancelada',    '2024-10-30');
-- ......90+

-- Consultas
--1 Cantidad de cambios de estado por mes durante el último año
SELECT
  EXTRACT(YEAR  FROM fecha_cambio) AS año,
  EXTRACT(MONTH FROM fecha_cambio) AS mes,
  COUNT(*)                           AS cambios
FROM tarjeta_auditoria
WHERE fecha_cambio >= (CURRENT_DATE - INTERVAL '1 year')
GROUP BY año, mes
ORDER BY año DESC, mes DESC;

--2 Las 5 tarjetas con mayor número de cambios de estado
SELECT
  tarjeta_id,
  COUNT(*) AS total_cambios
FROM tarjeta_auditoria
GROUP BY tarjeta_id
ORDER BY total_cambios DESC
LIMIT 5;
