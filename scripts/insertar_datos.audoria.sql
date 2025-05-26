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
