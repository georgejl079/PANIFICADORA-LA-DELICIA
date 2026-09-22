# Guía de Deploy — LA DELICIA

Pasos exactos para publicar el sitio en **Supabase** + **Cloudflare Pages**.

---

## PARTE 1: Configurar Supabase

### Paso 1.1 — Crear proyecto

1. Ir a https://supabase.com y registrarse
2. Click en **"New project"**
3. Completar:
   - **Name**: `ladelicia`
   - **Database Password**: guardá esta contraseña en un lugar seguro
   - **Region**: elegir la más cercana a Bolivia/Argentina
4. Click en **"Create new project"**
5. Esperar 2-3 minutos a que se cree

### Paso 1.2 — Obtener credenciales

1. En el proyecto, ir a **Settings** (ícono de engranaje)
2. Click en **API**
3. Copiar y guardar:
   - **Project URL**: `https://tu-proyecto.supabase.co`
   - **anon public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

### Paso 1.3 — Crear bucket de Storage

1. Ir a **Storage** en el menú lateral
2. Click en **"New bucket"**
3. Nombre: `ladelicia-uploads`
4. Marcar **"Public bucket"** → ON
5. Click en **"Create bucket"**

### Paso 1.4 — Ejecutar migraciones SQL

1. Ir a **SQL Editor** en el menú lateral
2. Click en **"New query"**
3. Abrir el archivo `supabase/migrations/001_schema.sql`
4. Copiar TODO el contenido y pegarlo en el SQL Editor
5. Click en **"Run"** (o Ctrl+Enter)
6. Repetir con los archivos:
   - `002_seed.sql`
   - `003_appearance.sql`
   - `004_rls.sql` ← **CRÍTICO para seguridad**

**Nota:** Si hay error de "relation already exists", ignorar. Las tablas ya existen.

### Paso 1.5 — Crear usuario admin

1. Ir a **Authentication** → **Users**
2. Click en **"Add user"** → **"Create new user"**
3. Completar:
   - **Email**: `admin@ladelicia.bo` (o el que quieras)
   - **Password**: contraseña fuerte (mínimo 8 caracteres, con números y símbolos)
   - **Auto-confirm email**: ✅ (marcar)
4. Click en **"Create user"**

### Paso 1.6 — Habilitar 2FA (recomendado)

1. Ir a **Authentication** → **Settings**
2. Buscar **"Two-factor authentication"**
3. Marcar **"Enable two-factor authentication"**
4. Guardar cambios

---

## PARTE 2: Configurar Cloudflare Pages

### Paso 2.1 — Subir código a GitHub/GitLab

**Opción A: Usar Git (recomendado)**

```bash
# En la carpeta del proyecto
cd "C:\Users\PC\Desktop\La delicia"

# Inicializar git (si no lo hiciste)
git init
git add .
git commit -m "Initial commit: LA DELICIA ecommerce"

# Crear repo en GitHub/GitLab y conectar
git remote add origin https://github.com/tu-usuario/ladelicia.git
git branch -M main
git push -u origin main
```

**Opción B: Subir archivos directamente**

1. Ir a https://github.com y crear un repo nuevo llamado `ladelicia`
2. Arrastrar todos los archivos/carpetas del proyecto al repo
3. Commit

### Paso 2.2 — Conectar a Cloudflare Pages

1. Ir a https://dash.cloudflare.com → **Pages**
2. Click en **"Create a project"** → **"Connect to Git"**
3. Autorizar Cloudflare a acceder a tu GitHub/GitLab
4. Seleccionar el repo `ladelicia`
5. Configurar:
   - **Production branch**: `main`
   - **Build command**: (dejar vacío)
   - **Build output directory**: `public`
   - **Root directory**: (dejar vacío)
6. Click en **"Save and Deploy"**

### Paso 2.3 — Configurar variables de entorno

**IMPORTANTE:** No hardcodear credenciales en el código.

1. En Cloudflare Pages → tu proyecto → **Settings** → **Environment Variables**
2. Agregar estas variables:

| Variable | Valor | Ambiente |
|---|---|---|
| `SUPABASE_URL` | `https://tu-proyecto.supabase.co` | Production + Preview |
| `SUPABASE_ANON_KEY` | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` | Production + Preview |

3. Click en **"Save"**

**Nota:** Después de agregar variables de entorno, debés modificar el código para usarlas. Ver Paso 2.4.

### Paso 2.4 — Modificar código para usar variables de entorno

**En `public/index.html`** (línea ~1421):
```javascript
// Antes:
const SUPABASE_URL = 'TU_SUPABASE_URL';
const SUPABASE_ANION_KEY = 'TU_SUPABASE_ANON_KEY';

// Después:
const SUPABASE_URL = process.env.SUPABASE_URL || 'https://fallback.supabase.co';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'fallback-key';
```

**En `public/admin.html`** (línea ~162):
```javascript
// Mismo cambio que arriba
```

**Nota:** Cloudflare Pages reemplaza `process.env.VAR` en el build. Si no usás build, podés hardcodear las credenciales, pero **no es recomendado**.

### Paso 2.5 — Redesplegar

1. En Cloudflare Pages → **Deployments**
2. Click en **"Retry deployment"** o hacer un nuevo commit en GitHub

---

## PARTE 3: Verificar funcionamiento

### Verificar sitio público

1. Ir a `https://tu-proyecto.pages.dev` (URL que da Cloudflare)
2. Verificar que se vea:
   - Carrusel de imágenes
   - Categorías
   - Productos
   - Página "Nosotros"

### Verificar panel admin

1. Ir a `https://tu-proyecto.pages.dev/admin.html`
2. Login con el usuario creado en Paso 1.5
3. Verificar que se pueda:
   - Ver dashboard
   - Crear/editar productos
   - Subir imágenes
   - Cambiar colores en Apariencia

### Verificar seguridad

1. **Cerrar sesión** en el panel admin
2. Intentar acceder a `https://tu-proyecto.pages.dev/admin.html` → debe redirigir al login
3. Intentar modificar datos desde el navegador (DevTools) → debe fallar por RLS
4. Verificar que las tablas de Supabase tengan RLS activado

---

## PARTE 4: Configurar dominio personalizado (opcional)

### Paso 4.1 — Agregar dominio en Cloudflare Pages

1. En Cloudflare Pages → tu proyecto → **Custom domains**
2. Click en **"Set up a custom domain"**
3. Ingresar: `panaderialadelicia.bo` (o tu dominio)
4. Click en **"Continue"**

### Paso 4.2 — Configurar DNS

1. Ir a Cloudflare Dashboard → **DNS**
2. Agregar registro:
   - **Type**: `CNAME`
   - **Name**: `@` o `www`
   - **Target**: `tu-proyecto.pages.dev`
   - **Proxy**: ✅ (naranja)

### Paso 4.3 — Esperar propagación

- Puede tardar 5-30 minutos
- Una vez listo, el sitio estará en `https://panaderialadelicia.bo`

---

## ✅ Checklist final

- [ ] Proyecto Supabase creado
- [ ] Credenciales obtenidas
- [ ] Bucket Storage creado
- [ ] Migraciones SQL ejecutadas (001, 002, 003, 004)
- [ ] Usuario admin creado
- [ ] 2FA habilitado
- [ ] Código subido a GitHub/GitLab
- [ ] Cloudflare Pages conectado al repo
- [ ] Variables de entorno configuradas
- [ ] Sitio público funcionando
- [ ] Panel admin funcionando
- [ ] Dominio personalizado configurado (opcional)

---

## 🆘 Solución de problemas comunes

### Error: "Invalid API key"
- Verificar que `SUPABASE_ANON_KEY` sea correcto
- Verificar que no haya espacios extra

### Error: "Row Level Security policy violated"
- Verificar que se ejecutó `004_rls.sql`
- Verificar que el usuario esté autenticado

### Error: "Bucket not found"
- Verificar que el bucket se llame exactamente `ladelicia-uploads`
- Verificar que sea público

### Las imágenes no se muestran
- Verificar que las URLs de imágenes sean correctas
- Verificar que el bucket tenga política pública de lectura

### El panel admin no carga
- Verificar credenciales de Supabase
- Verificar consola del navegador (F12) para errores

---

## 📞 Soporte

Si tenés problemas:
1. Verificar este documento
2. Revisar `README.md` para detalles técnicos
3. Revisar `SECURITY.md` para configuración de seguridad
4. Contactar a KEY STUDIO: https://keystudio.bo
