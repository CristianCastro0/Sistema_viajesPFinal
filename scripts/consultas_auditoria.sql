- Consultas para auditoría de tarjetas
1. Cantidad de cambios de estado por mes durante el último año
SELECT
  EXTRACT(YEAR FROM fecha_cambio) AS año,
  EXTRACT(MONTH FROM fecha_cambio) AS mes,
  COUNT(*) AS cantidad_cambios
FROM auditoria_estado_tarjeta
WHERE fecha_cambio >= date_trunc('year', current_date) - INTERVAL '1 year'
GROUP BY año, mes
ORDER BY año, mes;

2. Las 5 tarjetas con mayor número de cambios de estado
SELECT
  tarjeta_id,
  COUNT(*) AS cantidad_cambios
FROM auditoria_estado_tarjeta
GROUP BY tarjeta_id
ORDER BY cantidad_cambios DESC
LIMIT 5;
