-- ============================================
-- LA DELICIA — Datos iniciales de ejemplo
-- ============================================
-- Ejecutar DESPUÉS de 001_schema.sql

-- Configuración de la tienda
INSERT INTO store_config (key, value, type) VALUES
  ('store_name', 'LA DELICIA', 'text'),
  ('tagline', 'Panadería Artesanal', 'text'),
  ('story', 'LA DELICIA nació del amor por el buen pan y el deseo de compartir momentos especiales alrededor de una mesa. Desde nuestros inicios, nos hemos dedicado a elaborar pan fresco, tortas, facturas y delicias horneadas con ingredientes de la más alta calidad. Cada producto es preparado diariamente con dedicación y amor por el buen pan, manteniendo vivas las recetas tradicionales que nos han dado identidad.', 'text'),
  ('mission', 'Endulzar y acompañar cada momento de nuestros clientes ofreciendo productos horneados frescos, deliciosos y de calidad, con atención cercana y entrega puntual. Queremos ser la panadería de confianza de cada hogar, llevando a cada mesa el sabor de lo artesanal y el calor de lo recién horneado.', 'text'),
  ('vision', 'Ser la panadería artesanal líder en Bolivia, reconocida por la excelencia de nuestros productos, la calidez de nuestro servicio y nuestro compromiso con la tradición y la innovación.', 'text'),
  ('values', 'Amor por lo artesanal, compromiso con la calidad, cercanía con nuestros clientes, responsabilidad con nuestra comunidad y pasión por el buen pan.', 'text'),
  ('hours', 'Lun – Dom: 6:00 – 21:00', 'text'),
  ('address', 'Yacuiba, Bolivia', 'text'),
  ('email', 'pedidos@ladelicia.bo', 'text'),
  ('instagram', '@ladelicia.bo', 'text'),
  ('phone', '59169340915', 'text');

-- Apariencia inicial
INSERT INTO store_appearance (key, value, type) VALUES
  ('primary', '#8B4513', 'color'),
  ('primary_dark', '#6B3410', 'color'),
  ('accent', '#F5B400', 'color'),
  ('bg', '#FFFBF5', 'color'),
  ('surface', '#FDF5E6', 'color'),
  ('text', '#2C1810', 'color'),
  ('logo_url', '', 'text'),
  ('font_main', 'Inter', 'text'),
  ('font_headings', 'Oswald', 'text');

-- Categorías
INSERT INTO categories (name, slug, image, tagline, sort_order) VALUES
  ('Panes', 'panes', 'pan-con-queso.jpg', 'Recién horneado', 1),
  ('Panes Especiales', 'especiales', 'pan-de-chola.jpg', 'Para toda ocasión', 2),
  ('Panes Molde', 'molde', 'pan-integral.jpg', 'Suaves y esponjosos', 3),
  ('Pan Hamburguesas', 'hamburguesa', 'panchito-comun.jpg', 'Para tus comidas', 4),
  ('Chatitas', 'chatitas', 'chatita-chica.jpg', 'Crujientes y deliciosas', 5),
  ('Integrales', 'integrales', 'pan-integral.jpg', 'Saludables y ricos', 6);

-- Productos de ejemplo
INSERT INTO products (sku, name, brand, price, cat_id, img, images, description, details, stock, active, sort_order) VALUES
  ('LD-PAN-001', 'Pan Con Queso', 'LA DELICIA', 5.00, 1, 'pan-con-queso.jpg', '["pan-con-queso.jpg"]', '<p>Delicioso pan con queso, elaborado con <strong>ingredientes de primera calidad</strong>. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Sabor": "Queso", "Horneado": "Diario"}', 50, 1, 1),
  ('LD-PAN-002', 'Chamillo', 'LA DELICIA', 5.00, 1, 'chamillo.jpg', '["chamillo.jpg"]', '<p>El clásico Chamillo, suave y espolvoreado con azúcar. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Tipo": "Tradicional", "Horneado": "Diario"}', 50, 1, 2),
  ('LD-PAN-003', 'Pan De Chola', 'LA DELICIA', 5.00, 1, 'pan-de-chola.jpg', '["pan-de-chola.jpg"]', '<p>Pan de chola, una receta tradicional con el toque justo de dulzura. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Tipo": "Dulce", "Horneado": "Diario"}', 50, 1, 3),
  ('LD-PAN-004', 'Pan Integral 4 Semillas', 'LA DELICIA', 5.00, 1, 'pan-integral.jpg', '["pan-integral.jpg"]', '<p>Pan integral enriquecido con 4 semillas. Bolsa de 5 unidades.</p>', '{"Presentación": "Bolsa 5 Unidades", "Tipo": "Integral", "Semillas": "4 variedades"}', 40, 1, 4),
  ('LD-PAN-005', 'Panchito Comun', 'LA DELICIA', 5.00, 1, 'panchito-comun.jpg', '["panchito-comun.jpg"]', '<p>Panchitos comunes, ideales para hamburguesas o meriendas. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Tipo": "Común", "Uso": "Hamburguesas"}', 50, 1, 5),
  ('LD-PAN-006', 'Panchito Integral', 'LA DELICIA', 5.00, 1, 'panchito-integral.jpg', '["panchito-integral.jpg"]', '<p>Panchitos integrales, una opción más saludable. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Tipo": "Integral", "Uso": "Hamburguesas"}', 40, 1, 6),
  ('LD-CHA-010', 'Chatita Chica', 'LA DELICIA', 8.00, 5, 'chatita-chica.jpg', '["chatita-chica.jpg"]', '<p>Chatitas chicas, galletas integrales crocantes. Bolsa de 250 gramos.</p>', '{"Presentación": "Bolsa 250g", "Tipo": "Integral", "Textura": "Crocante"}', 30, 1, 7),
  ('LD-CHA-011', 'Chatita De Avena', 'LA DELICIA', 8.00, 5, 'chatita-avena.jpg', '["chatita-avena.jpg"]', '<p>Chatitas de avena, el snack perfecto para acompañar el café. Bolsa de 250 gramos.</p>', '{"Presentación": "Bolsa 250g", "Tipo": "Avena", "Textura": "Crocante"}', 30, 1, 8),
  ('LD-CHA-012', 'Chatita De Ajo', 'LA DELICIA', 8.00, 5, 'chatita-ajo.jpg', '["chatita-ajo.jpg"]', '<p>Chatitas de ajo, ideales para picar. Bolsa de 250 gramos.</p>', '{"Presentación": "Bolsa 250g", "Tipo": "Salada", "Sabor": "Ajo"}', 30, 1, 9);

-- Promoción de ejemplo
INSERT INTO promotions (badge, title, sub, image, cat_id, full_description, valid_until, conditions, active) VALUES
  ('FRESCO', 'Pan Caliente', 'Recién horneado cada mañana', 'pan-con-queso.jpg', 1,
   'Disfruta de nuestro pan recién horneado, crujiente por fuera y suave por dentro. Elaborado diariamente con ingredientes de primera calidad.',
   'Todos los días desde las 6:00 AM',
   '["Precio por unidad", "Delivery disponible", "Sujeto a stock del día"]', 1);

-- Sucursales
INSERT INTO branches (name, location, initials, address, phone, whatsapp, hours, facebook, instagram, active) VALUES
  ('LA DELICIA — Casa Matriz', 'Yacuiba', 'CM', 'Av. Principal #123, Zona Centro, Yacuiba', '69340915', '59169340915', 'Lun – Dom: 6:00 – 21:00', 'https://facebook.com/ladelicia.bo', 'https://instagram.com/ladelicia.bo', 1),
  ('LA DELICIA — Sucursal', 'Yacuiba', 'SU', 'Calle Comercio #456, Zona Sur, Yacuiba', '69340915', '59169340915', 'Lun – Dom: 6:00 – 21:00', 'https://facebook.com/ladelicia.bo', 'https://instagram.com/ladelicia.bo', 1);

-- Instalaciones
INSERT INTO facilities (label, icon, image, description, active) VALUES
  ('Fachada de la Panadería', 'fas fa-store', 'fachada.jpg', 'Así luce nuestra panadería por fuera. ¡Te esperamos!', 1),
  ('Vitrina de Productos', 'fas fa-cookie-bite', 'vitrina.jpg', 'Exhibición de nuestras delicias recién horneadas.', 1),
  ('Entrada Principal', 'fas fa-door-open', 'entrada.jpg', 'Bienvenido a LA DELICIA, tu panadería de confianza.', 1);

-- Slides del hero
INSERT INTO hero_slides (src, title, subtitle, sort_order, active) VALUES
  ('hero1.jpg', 'LA DELICIA', 'Pan artesanal recién horneado', 1, 1),
  ('hero2.jpg', 'LA DELICIA', 'Facturas y delicias dulces', 2, 1),
  ('hero3.jpg', 'LA DELICIA', 'Tortas para toda ocasión', 3, 1);
