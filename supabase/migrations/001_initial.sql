-- Tabla: configuración general de la tienda
CREATE TABLE store_config (
  key TEXT PRIMARY KEY,
  value TEXT,
  type TEXT DEFAULT 'text'
);

-- Tabla: slides del carrusel hero
CREATE TABLE hero_slides (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  src TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: categorías
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  image TEXT,
  tagline TEXT,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: promociones
CREATE TABLE promotions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  badge TEXT NOT NULL,
  title TEXT NOT NULL,
  sub TEXT NOT NULL,
  image TEXT NOT NULL,
  cat_id INTEGER,
  full_description TEXT,
  valid_until TEXT,
  conditions TEXT,
  active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cat_id) REFERENCES categories(id)
);

-- Tabla: sucursales
CREATE TABLE branches (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  location TEXT NOT NULL,
  initials TEXT NOT NULL,
  address TEXT NOT NULL,
  phone TEXT NOT NULL,
  whatsapp TEXT NOT NULL,
  hours TEXT NOT NULL,
  facebook TEXT,
  instagram TEXT,
  active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: instalaciones
CREATE TABLE facilities (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  label TEXT NOT NULL,
  icon TEXT NOT NULL,
  image TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: productos
CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  sku TEXT UNIQUE,
  name TEXT NOT NULL,
  brand TEXT DEFAULT 'LA DELICIA',
  price REAL NOT NULL,
  cat_id INTEGER,
  img TEXT,
  images TEXT,
  description TEXT,
  details TEXT,
  stock INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cat_id) REFERENCES categories(id)
);

-- Tabla: usuarios admin
CREATE TABLE admin_users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  name TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Índices
CREATE INDEX idx_products_cat ON products(cat_id);
CREATE INDEX idx_products_active ON products(active);
CREATE INDEX idx_promotions_active ON promotions(active);
CREATE INDEX idx_categories_slug ON categories(slug);
