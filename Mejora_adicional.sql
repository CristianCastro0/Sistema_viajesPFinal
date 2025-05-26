-- Mejora propuesta y consultas
-- Registro de opiniones de usuarios sobre viajes

--inicamos creando la tabla
CREATE TABLE retroalimentacion (
retro_id SERIAL PRIMARY KEY,
viaje_id INT REFERENCES viajes(viaje_id),
usuario_id INT REFERENCES usuarios(usuario_id),
rating INT CHECK (rating BETWEEN 1 AND 5),
comentario TEXT,
fecha_envio DATE NOT NULL
);

-- insertamos datos de ejemplo
INSERT INTO retroalimentacion(viaje_id, usuario_id, rating, comentario, fecha_envio) VALUES
  (1, 1, 5, 'Excelente servicio',       '2025-04-02'),
  (2, 2, 3, 'Regular, un poco lento',   '2025-04-03'),
  (3, 1, 4, 'Buen viaje',               '2025-04-04'),
  (4, 3, 2, 'Mala atención, queja',     '2025-04-05'),
  (5, 2, 5, 'Muy rápido y cómodo',      '2025-04-06'),
  (6, 1, 4, 'Buen precio',              '2025-04-07');

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
