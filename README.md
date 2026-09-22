# LA DELICIA — Ecommerce con Supabase

Sitio web de panadería con panel de administración, alojado en Cloudflare Pages y datos en Supabase.

## 🧪 Ver demo local (sin Supabase)

Abrí directamente en tu navegador:

```
public/admin-demo.html
```

Es una versión funcional con datos de ejemplo para que veas cómo se ve y cómo funciona el panel, sin necesidad de configurar Supabase.

---

## 🚀 Pasos de configuración

### 1. Crear proyecto en Supabase

1. Ir a https://supabase.com y crear una cuenta
2. Crear un nuevo proyecto (nombre: `ladelicia`)
3. Esperar que se cree (2-3 minutos)
4. Ir a **Settings → API** y copiar:
   - `Project URL`
   - `anon public` key

### 2. Crear bucket de Storage

1. En Supabase Dashboard, ir a **Storage**
2. Crear un nuevo bucket llamado `ladelicia-uploads`
3. En **Policies**, crear política pública:
   - `Policy name`: Public read access
   - `Allowed operation`: SELECT
   - `Target roles`: anon, authenticated
   - `Policy definition`: `true`

### 3. Ejecutar migración SQL

1. Ir a **SQL Editor** en Supabase Dashboard
2. Ejecutar el contenido de `supabase/migrations/001_schema.sql`
3. Ejecutar el contenido de `supabase/migrations/002_seed.sql`
4. Ejecutar el contenido de `supabase/migrations/003_appearance.sql`
5. Ejecutar el contenido de `supabase/migrations/004_rls.sql` (CRÍTICO para seguridad)

### 4. Insertar datos iniciales

Ejecutar este SQL en el SQL Editor de Supabase para cargar datos de ejemplo:

```sql
-- Configuración de la tienda
INSERT INTO store_config (key, value, type) VALUES
  ('store_name', 'LA DELICIA', 'text'),
  ('tagline', 'Panadería Artesanal', 'text'),
  ('story', 'LA DELICIA nació del amor por el buen pan y el deseo de compartir momentos especiales alrededor de una mesa. Desde nuestros inicios, nos hemos dedicado a elaborar pan fresco, tortas, facturas y delicias horneadas con ingredientes de la más alta calidad.', 'text'),
  ('mission', 'Endulzar y acompañar cada momento de nuestros clientes ofreciendo productos horneados frescos, deliciosos y de calidad.', 'text'),
  ('vision', 'Ser la panadería artesanal líder en Bolivia, reconocida por la excelencia de nuestros productos.', 'text'),
  ('values', 'Amor por lo artesanal, compromiso con la calidad, cercanía con nuestros clientes.', 'text'),
  ('hours', 'Lun – Dom: 6:00 – 21:00', 'text'),
  ('address', 'Yacuiba, Bolivia', 'text'),
  ('email', 'pedidos@ladelicia.bo', 'text'),
  ('instagram', '@ladelicia.bo', 'text'),
  ('phone', '59169340915', 'text');

-- Categorías
INSERT INTO categories (name, slug, image, tagline, sort_order) VALUES
  ('Panes', 'panes', 'pan-con-queso.jpg', 'Recién horneado', 1),
  ('Panes Especiales', 'especiales', 'pan-de-chola.jpg', 'Para toda ocasión', 2),
  ('Panes Molde', 'molde', 'pan-integral.jpg', 'Suaves y esponjosos', 3),
  ('Pan Hamburguesas', 'hamburguesa', 'panchito-comun.jpg', 'Para tus comidas', 4),
  ('Chatitas', 'chatitas', 'chatita-chica.jpg', 'Crujientes y deliciosas', 5),
  ('Integrales', 'integrales', 'pan-integral.jpg', 'Saludables y ricos', 6);

-- Productos de ejemplo
INSERT INTO products (sku, name, brand, price, cat_id, img, images, description, details, stock, active) VALUES
  ('LD-PAN-001', 'Pan Con Queso', 'LA DELICIA', 5, 1, 'pan-con-queso.jpg', '["pan-con-queso.jpg"]', '<p>Delicioso pan con queso, elaborado con ingredientes de primera calidad. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Sabor": "Queso", "Horneado": "Diario"}', 50, 1),
  ('LD-PAN-002', 'Chamillo', 'LA DELICIA', 5, 1, 'chamillo.jpg', '["chamillo.jpg"]', '<p>El clásico Chamillo, suave y espolvoreado con azúcar. Bolsa de 6 unidades.</p>', '{"Presentación": "Bolsa 6 Unidades", "Tipo": "Tradicional", "Horneado": "Diario"}', 50, 1),
  ('LD-CHA-010', 'Chatita Chica', 'LA DELICIA', 8, 5, 'chatita-chica.jpg', '["chatita-chica.jpg"]', '<p>Chatitas chicas, galletas integrales crocantes. Bolsa de 250 gramos.</p>', '{"Presentación": "Bolsa 250g", "Tipo": "Integral", "Textura": "Crocante"}', 30, 1);

-- Promoción de ejemplo
INSERT INTO promotions (badge, title, sub, image, cat_id, full_description, valid_until, conditions, active) VALUES
  ('FRESCO', 'Pan Caliente', 'Recién horneado cada mañana', 'pan-con-queso.jpg', 1,
   'Disfruta de nuestro pan recién horneado, crujiente por fuera y suave por dentro.',
   'Todos los días desde las 6:00 AM',
   '["Precio por unidad", "Delivery disponible"]', 1);

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
```

### 5. Configurar credenciales en los HTML

Editar ambos archivos y reemplazar las credenciales:

**En `public/index.html`** (línea ~donde aparece):
```javascript
const SUPABASE_URL = 'https://tu-proyecto.supabase.co';
const SUPABASE_ANON_KEY = 'tu-anon-key-aquí';
```

**En `public/admin.html`**:
```javascript
const SUPABASE_URL = 'https://tu-proyecto.supabase.co';
const SUPABASE_ANON_KEY = 'tu-anon-key-aquí';
```

### 6. Crear usuario admin

**Opción A: Usar Supabase Auth (recomendado)**

1. En Supabase Dashboard, ir a **Authentication → Users**
2. Click **Add user → Create new user**
3. Ingresar email y contraseña del admin
4. Marcar **Email confirmed**

**Opción B: Desde SQL Editor**

```sql
-- Primero necesitás bcrypt, o podés crear el usuario desde Authentication
```

### 7. Deploy en Cloudflare Pages

1. Subir todo el proyecto a GitHub/GitLab
2. En Cloudflare Dashboard → Pages → Create project → Conectar repo
3. Configurar:
   - **Build command**: (vacío, porque es HTML puro)
   - **Publish directory**: `public`
4. Deploy automático

### 8. Acceder al panel admin

Ir a: `https://tu-dominio.bo/admin.html`

---

## 📁 Estructura del proyecto

```
La delicia/
├── public/
│   ├── index.html           ← Sitio público
│   ├── admin.html           ← Panel de administración
│   └── admin-demo.html      ← Demo local sin Supabase
├── supabase/migrations/
│   ├── 001_schema.sql
│   ├── 002_seed.sql
│   ├── 003_appearance.sql
│   └── 004_rls.sql          ← Seguridad RLS
├── SECURITY.md              ← Guía de seguridad
├── DEPLOY.md                ← Guía de deploy paso a paso
├── package.json
├── .gitignore
└── README.md
```

## 🚀 Deploy rápido

Ver **[DEPLOY.md](DEPLOY.md)** para instrucciones paso a paso.

### Resumen express

1. **Supabase**: crear proyecto, ejecutar SQL, crear bucket, crear usuario admin
2. **GitHub**: subir código
3. **Cloudflare Pages**: conectar repo, configurar variables de entorno, deploy

## 🔧 Tecnologías

- **Frontend**: HTML + CSS + JavaScript vanilla
- **Backend/Datos**: Supabase (PostgreSQL + Storage + Auth)
- **Hosting**: Cloudflare Pages
- **Costo**: $0/mes

## ✅ Funcionalidades del panel admin

- ✅ Configuración de la tienda (datos, horario, contacto)
- ✅ Gestión de carrusel hero (portada)
- ✅ CRUD de categorías
- ✅ CRUD de promociones
- ✅ CRUD de productos (precios, stock, imágenes)
- ✅ CRUD de sucursales
- ✅ CRUD de instalaciones
- ✅ **Apariencia** (colores, logo, tipografía) — sin código
- ✅ **Búsqueda y filtros** de productos (nombre, SKU, categoría, estado)
- ✅ **Ordenamiento** de categorías y productos (botones ↑ ↓)
- ✅ **Activar/desactivar** productos con toggle
- ✅ Subida de imágenes a Supabase Storage
- ✅ Login con Supabase Auth

## 🔒 Seguridad

### Configuración obligatoria antes de lanzar

1. **Ejecutar `004_rls.sql` en Supabase** (Row Level Security)
   - Habilita RLS en todas las tablas
   - Crea políticas de lectura pública para el sitio web
   - Crea políticas de escritura solo para admin autenticado
   - Configura Storage policies para imágenes

2. **Variables de entorno en Cloudflare Pages**
   - No hardcodear credenciales de Supabase en el código
   - Ir a Pages → Settings → Environment Variables
   - Agregar `SUPABASE_URL` y `SUPABASE_ANON_KEY`

3. **Habilitar 2FA en Supabase Auth**
   - Dashboard → Authentication → Settings
   - Habilitar "Two-factor authentication"
   - Obligar al admin a usar 2FA

4. **Usar la función `escapeHtml()`**
   - Ya incluida en `index.html` y `admin.html`
   - Previene ataques XSS en campos de texto
   - Aplicar a todos los datos que se insertan en el DOM

### ¿Es seguro?

- **Código frontend**: visible, igual que cualquier sitio web
- **Base de datos**: protegida por RLS, solo lectura pública
- **Panel admin**: protegido por login + 2FA
- **Imágenes**: acceso público controlado por Storage policies

Para más detalles, ver: [SECURITY.md](SECURITY.md)

## 📝 Notas importantes

1. **Imágenes**: Podés subir imágenes de dos formas:
   - URL externa (ej: desde tu hosting actual)
   - Subir directamente desde el panel admin (se guarda en Supabase Storage)

2. **Migración de datos existentes**: Tu `index.html` actual tiene datos hardcodeados. Ejecutá el SQL de inicialización para cargar los datos iniciales en Supabase.

3. **Variables de entorno**: Para mayor seguridad, podés usar variables de entorno en Cloudflare Pages en vez de hardcodear las credenciales de Supabase.

4. **Plan gratuito de Supabase**:
   - 500 MB de base de datos
   - 1 GB de storage (para imágenes)
   - 50k usuarios autenticados
   - 2 GB de ancho de banda

   Para 100 productos con imágenes, esto alcanza perfectamente.

5. **Apariencia personalizable**: El panel admin incluye una sección "Apariencia" donde podés cambiar:
   - Colores del sitio (primario, acento, fondo, etc.)
   - Logo
   - Tipografías
   
   Sin necesidad de modificar código. Los cambios se guardan en Supabase y se aplican automáticamente en el sitio público.

## 🆘 Soporte

Si tenés problemas:
1. Verificar que las credenciales de Supabase sean correctas
2. Verificar que las tablas se crearon correctamente
3. Verificar que el bucket de Storage existe y tiene la política pública
4. Revisar la consola del navegador para errores

## 📄 Licencia

Proyecto privado para LA DELICIA Panadería Artesanal.
