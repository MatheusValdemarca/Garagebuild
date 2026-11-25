-- GarageBuild: dados de exemplo
-- Senhas de teste (já com hash bcrypt):
--   admin@garagebuild.com   -> admin123
--   cliente@garagebuild.com -> cliente123

INSERT INTO users (id, name, email, password_hash, role) VALUES
  (1, 'Dono da Oficina', 'admin@garagebuild.com',   '$2b$10$Lku4Fc6HqrV516hygTfZhOQDfrPB2wRakOQUh4ykRBAe9HP1Vdse2', 'admin'),
  (2, 'Cliente Teste',   'cliente@garagebuild.com', '$2b$10$OYuh75DDuh8XztgA2a28x.oUU3EjEq4OqJzbkWTiAyOF9MBMzsMFu', 'cliente');

-- A turbina tinha 3 unidades; 1 já está reservada no projeto de exemplo (estoque atual = 2).
-- O rail de combustível está com estoque 0 e o kit de freio com estoque 1, para testar o erro 409.
INSERT INTO parts (id, name, category, price, stock) VALUES
  (1, 'Turbina Garrett GT2860RS',                  'Turbo',     4890.00, 2),
  (2, 'Intercooler Frontal de Alumínio 600 mm',    'Turbo',     1650.00, 5),
  (3, 'Jogo de Pistões Forjados 86,5 mm',          'Motor',     2750.00, 4),
  (4, 'Comando de Válvulas Esportivo 280',         'Motor',     1890.00, 2),
  (5, 'Bicos Injetores 550cc (jogo de 4)',         'Injeção',   1450.00, 6),
  (6, 'Rail de Combustível com Regulador',         'Injeção',    690.00, 0),
  (7, 'Coilover Regulável (jogo de 4)',            'Suspensão', 5200.00, 2),
  (8, 'Kit de Freio Dianteiro 4 Pistões',          'Freios',    3800.00, 1);

INSERT INTO builds (id, user_id, car_model, engine, goal, status) VALUES
  (1, 2, 'Chevrolet Celta 2010', '1.0 VHC 8v', 'Turbinar para chegar perto de 200 cv', 'planejando');

INSERT INTO build_parts (build_id, part_id, quantity) VALUES
  (1, 1, 1);