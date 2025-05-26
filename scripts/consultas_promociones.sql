--Recargas con descripción de la promoción aplicada
SELECT r.recarga_id, r.fecha, r.monto, p.nombre 
AS nombre_promocion, p.descripcion
FROM recargas r
JOIN recargas_promociones rp ON r.recarga_id = rp.recarga_id
JOIN promociones p ON rp.promocion_id = p.id;

--Monto total recargado por cada tipo de promoción en los últimos 3 meses
SELECT p.nombre AS nombre_promocion,
SUM(r.monto) AS total_monto_recargado
FROM recargas r
JOIN recargas_promociones rp ON r.recarga_id = rp.recarga_id
JOIN promociones p ON rp.promocion_id = p.id
WHERE r.fecha >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY p.nombre
ORDER BY total_monto_recargado DESC;

--Promociones cuyo nombre contenga la palabra "bonus"
SELECT id, nombre, descripcion
FROM promociones
WHERE nombre ILIKE '%bonus%';
