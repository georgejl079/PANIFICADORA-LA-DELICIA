-- ============================================
-- LA DELICIA — Datos iniciales de apariencia
-- ============================================
-- Ejecutar DESPUÉS de 001_schema.sql

INSERT INTO store_appearance (key, value, type) VALUES
  ('primary', '#8B4513', 'color'),
  ('primary_dark', '#6B3410', 'color'),
  ('accent', '#F5B400', 'color'),
  ('bg', '#FFFBF5', 'color'),
  ('surface', '#FDF5E6', 'color'),
  ('text', '#2C1810', 'color'),
  ('logo_url', '', 'text'),
  ('font_main', 'Inter', 'text'),
  ('font_headings', 'Oswald', 'text') ON CONFLICT (key) DO NOTHING;
