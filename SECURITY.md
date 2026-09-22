# Guía de Seguridad — LA DELICIA

## Arquitectura de seguridad

```
Navegador (HTML/JS público)
        ↓
   Supabase (Auth + RLS + Storage)
        ↓
   Base de datos (protegida)
```

## Checklist de seguridad

### Antes del lanzamiento

- [ ] Ejecutar `004_rls.sql` en Supabase SQL Editor
- [ ] Crear bucket `ladelicia-uploads` en Supabase Storage
- [ ] Configurar Storage policies (público para lectura)
- [ ] Reemplazar credenciales hardcodeadas por variables de entorno
- [ ] Habilitar 2FA en Supabase Auth
- [ ] Crear usuario admin con email y contraseña fuerte
- [ ] Verificar que RLS esté activo en todas las tablas

### Después del lanzamiento

- [ ] Monitorear logs de Supabase regularmente
- [ ] Hacer backup de la base de datos (Supabase lo hace automáticamente)
- [ ] Actualizar credenciales periódicamente
- [ ] Revisar usuarios con acceso al panel admin

## Medidas implementadas

### 1. Row Level Security (RLS)
- Lectura pública: cualquiera puede ver productos, categorías, etc.
- Escritura restringida: solo usuarios autenticados pueden modificar
- Aislamiento por tabla: cada tabla tiene sus propias políticas

### 2. Storage policies
- Lectura pública: imágenes accesibles desde el sitio web
- Escritura restringida: solo admin puede subir/eliminar imágenes

### 3. Autenticación
- Supabase Auth con email/password
- Soporte para 2FA (TOTP)
- Sesiones con expiración automática

### 4. Prevención de XSS
- Función `escapeHtml()` incluida en el código
- Sanitización de inputs antes de insertar en el DOM

### 5. Variables de entorno
- Credenciales de Supabase no hardcodeadas en producción
- Uso de Cloudflare Pages Environment Variables

## Amenazas y mitigaciones

| Amenaza | Mitigación |
|---------|------------|
| XSS (inyección de scripts) | `escapeHtml()` + RLS |
| Acceso no autorizado al panel | Login + 2FA + rate limiting |
| Robo de credenciales | Variables de entorno + 2FA |
| Scraping de datos | Lectura pública es esperable |
| Fuerza bruta | Rate limiting de Supabase |
| Inyección SQL | Imposible con RLS + ORM |

## Contacto

Si encontrás una vulnerabilidad, reportala por email a: seguridad@keystudio.bo
