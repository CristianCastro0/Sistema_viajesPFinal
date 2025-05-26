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
