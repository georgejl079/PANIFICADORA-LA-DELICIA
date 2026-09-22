-- ============================================
-- LA DELICIA — Esquema de base de datos PostgreSQL
-- ============================================
-- Ejecutar en Supabase Dashboard → SQL Editor

-- Tabla: configuración general de la tienda
CREATE TABLE IF NOT EXISTS store_config (
  key TEXT PRIMARY KEY,
  value TEXT,
  type TEXT DEFAULT 'text'
);

-- Tabla: slides del carrusel hero
CREATE TABLE IF NOT EXISTS hero_slides (
  id SERIAL PRIMARY KEY,
  src TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: categorías de productos
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  image TEXT,
  tagline TEXT,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: promociones
CREATE TABLE IF NOT EXISTS promotions (
  id SERIAL PRIMARY KEY,
  badge TEXT NOT NULL,
  title TEXT NOT NULL,
  sub TEXT NOT NULL,
  image TEXT NOT NULL,
  cat_id INTEGER,
  full_description TEXT,
  valid_until TEXT,
  conditions TEXT,
  active INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cat_id) REFERENCES categories(id)
);

-- Tabla: sucursales
CREATE TABLE IF NOT EXISTS branches (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  location TEXT NOT NULL,
  initials TEXT NOT NULL,
  address TEXT NOT NULL,
  phone TEXT NOT NULL,
  whatsapp TEXT NOT NULL,
  hours TEXT NOT NULL,
  facebook TEXT,
  instagram TEXT,
  image TEXT,
  active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: instalaciones
CREATE TABLE IF NOT EXISTS facilities (
  id SERIAL PRIMARY KEY,
  label TEXT NOT NULL,
  icon TEXT NOT NULL,
  image TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: productos
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  sku TEXT UNIQUE,
  name TEXT NOT NULL,
  brand TEXT DEFAULT 'LA DELICIA',
  price DECIMAL(10,2) NOT NULL,
  cat_id INTEGER,
  img TEXT,
  images TEXT,
  description TEXT,
  details TEXT,
  stock INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cat_id) REFERENCES categories(id)
);

-- Tabla: usuarios admin
CREATE TABLE IF NOT EXISTS admin_users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  name TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: apariencia / marca
CREATE TABLE IF NOT EXISTS store_appearance (
  key TEXT PRIMARY KEY,
  value TEXT,
  type TEXT DEFAULT 'text'
);

-- Índices para mejorar rendimiento
CREATE INDEX IF NOT EXISTS idx_products_cat ON products(cat_id);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active);
CREATE INDEX IF NOT EXISTS idx_products_sort ON products(sort_order);
CREATE INDEX IF NOT EXISTS idx_promotions_active ON promotions(active);
CREATE INDEX IF NOT EXISTS idx_categories_slug ON categories(slug);
CREATE INDEX IF NOT EXISTS idx_categories_sort ON categories(sort_order);
