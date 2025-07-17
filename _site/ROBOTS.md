# Sistema de Meta Robots - MONTERIAVENDE

## 🎯 **Cómo Funciona**

El sistema de meta robots implementado en `_layouts/default.html` tiene **3 niveles de prioridad**:

```html
<meta
  name="robots"
  content="{% if page.robots %}{{ page.robots }}{% elsif page.noindex %}noindex, follow{% else %}index, follow{% endif %}"
/>
```

### **Nivel 1: Campo `robots` (Más específico)**

Si defines `robots:` en el front matter, usa ese valor exacto.

### **Nivel 2: Campo `noindex` (Compatibilidad)**

Si no hay `robots` pero hay `noindex: true`, usa `noindex, follow`.

### **Nivel 3: Por defecto**

Si no hay ninguno, usa `index, follow` (comportamiento normal de indexación).

## 📝 **¿Cuándo Usar Cada Opción?**

### **✅ NO necesitas agregar nada (95% de casos):**

- Posts normales de blog
- Páginas de productos/servicios
- Contenido principal del sitio
- Páginas que quieres que aparezcan en Google

**Ejemplo:**

```yaml
---
layout: post
title: "Cómo hacer algo en Montería"
date: 2025-07-16
categories: [servicios]
# No necesitas robots: se indexará automáticamente
---
```

**Resultado:** `<meta name="robots" content="index, follow" />`

### **✅ Usa `noindex: true` para:**

- Páginas de categorías (ya configuradas)
- Páginas de archivo
- Páginas intermedias

**Ejemplo:**

```yaml
---
layout: default
title: "Productos"
noindex: true
---
```

**Resultado:** `<meta name="robots" content="noindex, follow" />`

### **✅ Usa `robots:` para control específico:**

- Páginas legales
- Páginas de error personalizadas
- Contenido temporal
- Control avanzado de indexación

**Ejemplos:**

```yaml
---
layout: page
title: "Política de Privacidad"
robots: "noindex, nofollow"
---
```

```yaml
---
layout: page
title: "Términos y Condiciones"
robots: "noindex, follow"
---
```

```yaml
---
layout: post
title: "Guía Completa SEO"
robots: "index, follow, max-image-preview:large"
---
```

## 🔧 **Valores Comunes para `robots:`**

| Valor                                    | Significado                     | Cuándo usar                        |
| ---------------------------------------- | ------------------------------- | ---------------------------------- |
| `index, follow`                          | Indexar página y seguir enlaces | **Por defecto** - contenido normal |
| `noindex, follow`                        | No indexar pero seguir enlaces  | Páginas de categorías, archivo     |
| `index, nofollow`                        | Indexar pero no seguir enlaces  | Páginas con enlaces externos       |
| `noindex, nofollow`                      | No indexar ni seguir enlaces    | Páginas privadas, legales          |
| `index, follow, noarchive`               | Indexar sin guardar caché       | Contenido dinámico                 |
| `index, follow, max-snippet:150`         | Indexar con snippet limitado    | Control de descripción             |
| `index, follow, max-image-preview:large` | Indexar con imágenes grandes    | Posts con imágenes importantes     |

## 📋 **Ejemplos Prácticos por Tipo de Página**

### **Posts de Blog (Normal)**

```yaml
---
layout: post
title: "Certificado de Tradición y Libertad"
date: 2025-07-16
categories: [servicios]
# Sin robots: se indexa automáticamente
---
```

**Resultado:** `index, follow`

### **Páginas de Categorías**

```yaml
---
layout: default
title: "Productos"
permalink: /productos/
noindex: true
---
```

**Resultado:** `noindex, follow`

### **Páginas Legales**

```yaml
---
layout: page
title: "Política de Privacidad"
permalink: /privacidad/
robots: "noindex, nofollow"
---
```

**Resultado:** `noindex, nofollow`

### **Páginas de Error**

```yaml
---
layout: page
title: "Página no encontrada"
permalink: /404.html
robots: "noindex, nofollow"
---
```

**Resultado:** `noindex, nofollow`

### **Página de Contacto**

```yaml
---
layout: page
title: "Contacto"
permalink: /contacto/
robots: "index, nofollow"
---
```

**Resultado:** `index, nofollow`

### **Páginas de Gracias**

```yaml
---
layout: page
title: "Gracias por contactarnos"
permalink: /gracias/
robots: "noindex, nofollow"
---
```

**Resultado:** `noindex, nofollow`

### **Posts con Control Avanzado**

```yaml
---
layout: post
title: "Guía Completa 2025"
robots: "index, follow, max-snippet:160, max-image-preview:large"
---
```

**Resultado:** `index, follow, max-snippet:160, max-image-preview:large`

## 🎯 **Recomendaciones por Tipo de Sitio**

### **Blog/Sitio de Noticias:**

- **Posts normales:** Sin robots (indexación automática)
- **Categorías:** `noindex: true`
- **Archivo:** `noindex: true`
- **Páginas legales:** `robots: "noindex, nofollow"`

### **Sitio de Servicios:**

- **Servicios principales:** Sin robots
- **Páginas de proceso:** `robots: "noindex, follow"`
- **Formularios:** `robots: "index, nofollow"`
- **Confirmaciones:** `robots: "noindex, nofollow"`

### **E-commerce:**

- **Productos:** Sin robots
- **Categorías:** `noindex: true`
- **Carrito:** `robots: "noindex, nofollow"`
- **Checkout:** `robots: "noindex, nofollow"`

## 🚀 **Casos de Uso Específicos**

### **Contenido Temporal:**

```yaml
---
layout: post
title: "Oferta Especial Enero 2025"
robots: "index, follow"
# Cambiar a noindex después de la fecha
---
```

### **Páginas de Prueba:**

```yaml
---
layout: page
title: "Página de Prueba"
robots: "noindex, nofollow"
---
```

### **Contenido Duplicado:**

```yaml
---
layout: post
title: "Resumen del Artículo Principal"
robots: "noindex, follow"
---
```

### **Páginas de Recursos:**

```yaml
---
layout: page
title: "Descargas y Recursos"
robots: "index, follow, max-snippet:100"
---
```

## 🔍 **Verificación del Sistema**

Para verificar que el sistema funciona:

1. **Verificar posts normales:**

   ```bash
   curl -s http://127.0.0.1:4000/servicios/certificado-tradicion-libertad-monteria/ | grep "robots"
   ```

2. **Verificar páginas de categorías:**

   ```bash
   curl -s http://127.0.0.1:4000/productos/ | grep "robots"
   ```

3. **Verificar páginas con robots personalizado:**
   ```bash
   curl -s http://127.0.0.1:4000/mi-pagina/ | grep "robots"
   ```

## 📊 **Estado Actual del Sitio**

### **Configuración Actual:**

- **Posts:** `index, follow` (automático)
- **Página principal:** `index, follow`
- **Categorías productos:** `noindex, follow`
- **Categorías servicios:** `noindex, follow`

### **Archivos Configurados:**

- `_layouts/default.html` - Lógica principal
- `categorias/productos.md` - `noindex: true`
- `categorias/servicios.md` - `noindex: true`
- `_posts/2025-07-04-certificado-tradicion-libertad-monteria.md` - `robots: "index, follow"`

## 🎯 **Mejores Prácticas**

### **✅ Hacer:**

- Usar `robots:` solo cuando necesites control específico
- Dejar la mayoría de posts sin robots (indexación automática)
- Usar `noindex, follow` para categorías y archivo
- Usar `noindex, nofollow` para páginas privadas

### **❌ Evitar:**

- Poner `robots:` en todos los posts
- Usar `nofollow` en páginas con enlaces internos importantes
- Cambiar la configuración frecuentemente
- Bloquear páginas importantes accidentalmente

## 🔧 **Mantenimiento**

### **Revisión Mensual:**

- Verificar que páginas importantes tengan `index, follow`
- Revisar que páginas de categorías tengan `noindex, follow`
- Comprobar que páginas legales tengan `noindex, nofollow`

### **Comandos Útiles:**

```bash
# Buscar todas las páginas con robots personalizado
grep -r "robots:" _posts/ categorias/ *.md

# Verificar configuración de una página específica
curl -s http://127.0.0.1:4000/URL/ | grep "robots"
```

## 📝 **Notas Importantes**

1. **El sistema es retrocompatible:** Páginas existentes siguen funcionando
2. **Prioridad:** `robots:` > `noindex:` > por defecto
3. **Flexibilidad:** Puedes usar cualquier valor válido de robots
4. **Mantenimiento:** Solo necesitas ajustar casos específicos
5. **Sitemap automático:** Las páginas con `noindex` se excluyen automáticamente del sitemap

## 🗺️ **Integración con Sitemap**

El sitemap (`sitemap.xml`) está sincronizado con el sistema de robots:

### **✅ Páginas incluidas en sitemap:**

- Páginas con `index, follow` (por defecto)
- Páginas con `robots: "index, nofollow"`
- Páginas con `robots: "index, follow, ..."`

### **❌ Páginas excluidas del sitemap:**

- Páginas con `noindex: true`
- Páginas con `robots: "noindex, follow"`
- Páginas con `robots: "noindex, nofollow"`
- Páginas con `sitemap: false`
- Página 404

### **Verificación:**

```bash
# Ver el sitemap generado
curl -s http://127.0.0.1:4000/sitemap.xml | grep -E "<loc>|</loc>"

# Verificar que páginas noindex no aparezcan
curl -s http://127.0.0.1:4000/sitemap.xml | grep -v "/productos/" | grep -v "/servicios/"
```

---

**Última actualización:** 16 de julio de 2025  
**Versión del sistema:** 1.1  
**Archivos principales:** `_layouts/default.html`, `sitemap.xml`
