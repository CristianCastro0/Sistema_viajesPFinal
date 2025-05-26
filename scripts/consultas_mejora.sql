-- continuamos con las consultas
-- 1 Promedio de rating por estación
SELECT
  e.nombre      AS estacion,
  AVG(rf.rating) AS promedio_rating
FROM retroalimentacion rf
JOIN viajes v  ON rf.viaje_id = v.viaje_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
GROUP BY e.estacion_id, e.nombre
ORDER BY promedio_rating DESC;


-- 2 Top 3 usuarios con más retroalimentaciones y su rating promedio
SELECT
  u.nombre || ' ' || u.apellido AS usuario,
  COUNT(*)                     AS total_comentarios,
  AVG(rf.rating)               AS promedio_rating
FROM retroalimentacion rf
JOIN usuarios u ON rf.usuario_id = u.usuario_id
GROUP BY u.usuario_id, usuario
ORDER BY total_comentarios DESC
LIMIT 3;


-- 3 Consultar comentarios que contengan la palabra 'queja'
SELECT
  rf.retro_id,
  rf.usuario_id,
  rf.comentario,
  rf.fecha_envio
FROM retroalimentacion rf
WHERE rf.comentario LIKE '%queja%';
