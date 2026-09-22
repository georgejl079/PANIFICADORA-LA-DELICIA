-- ============================================
-- LA DELICIA — Row Level Security (RLS)
-- ============================================
-- Ejecutar DESPUÉS de 001_schema.sql y 002_seed.sql
-- IMPORTANTE: Este archivo usa sintaxis PostgreSQL para Supabase

-- 1. HABILITAR RLS EN TODAS LAS TABLAS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE facilities ENABLE ROW LEVEL SECURITY;
ALTER TABLE hero_slides ENABLE ROW LEVEL SECURITY;
ALTER TABLE store_config ENABLE ROW LEVEL SECURITY;
ALTER TABLE store_appearance ENABLE ROW LEVEL SECURITY;

-- 2. POLÍTICAS DE LECTURA PÚBLICA (sitio web)
-- Permiten que cualquier persona vea los datos públicos del sitio
CREATE POLICY "Public read products" ON products FOR SELECT USING (true);
CREATE POLICY "Public read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public read promotions" ON promotions FOR SELECT USING (true);
CREATE POLICY "Public read branches" ON branches FOR SELECT USING (true);
CREATE POLICY "Public read facilities" ON facilities FOR SELECT USING (true);
CREATE POLICY "Public read hero_slides" ON hero_slides FOR SELECT USING (true);
CREATE POLICY "Public read store_config" ON store_config FOR SELECT USING (true);
CREATE POLICY "Public read store_appearance" ON store_appearance FOR SELECT USING (true);

-- 3. POLÍTICAS DE ESCRITURA (solo admin autenticado)
-- Solo usuarios con sesión activa pueden modificar datos
CREATE POLICY "Admin write products" ON products FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write categories" ON categories FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write promotions" ON promotions FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write branches" ON branches FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write facilities" ON facilities FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write hero_slides" ON hero_slides FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write store_config" ON store_config FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin write store_appearance" ON store_appearance FOR ALL USING (auth.role() = 'authenticated');

-- 4. POLÍTICAS PARA STORAGE (imágenes)
-- Lectura pública: cualquiera puede ver las imágenes
CREATE POLICY "Public read storage" ON storage.objects FOR SELECT USING (bucket_id = 'ladelicia-uploads');
-- Escritura: solo admin autenticado puede subir/editar/eliminar
CREATE POLICY "Admin write storage" ON storage.objects FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Admin update storage" ON storage.objects FOR UPDATE USING (auth.role() = 'authenticated');
CREATE POLICY "Admin delete storage" ON storage.objects FOR DELETE USING (auth.role() = 'authenticated');

-- 5. ÍNDICES PARA MEJOR RENDIMIENTO
CREATE INDEX IF NOT EXISTS idx_products_cat ON products(cat_id);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active);
CREATE INDEX IF NOT EXISTS idx_products_sort ON products(sort_order);
CREATE INDEX IF NOT EXISTS idx_promotions_active ON promotions(active);
CREATE INDEX IF NOT EXISTS idx_categories_slug ON categories(slug);
CREATE INDEX IF NOT EXISTS idx_categories_sort ON categories(sort_order);
