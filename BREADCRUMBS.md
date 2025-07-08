# Sistema de Migas de Pan (Breadcrumbs) - MONTERIAVENDE

## ¿Qué son las migas de pan?

Las migas de pan son un elemento de navegación que muestra al usuario dónde se encuentra dentro de la estructura del sitio web, proporcionando un camino claro de vuelta a páginas anteriores.

## Funcionamiento

### Ubicación

- Las migas de pan aparecen automáticamente en todas las páginas excepto en la página de inicio
- Se muestran justo debajo del header y antes del contenido principal

### Tipos de páginas

#### Posts de blog

Para posts (como el certificado de tradición y libertad):

- **Estructura**: Inicio › Categoría › Título del post
- **Ejemplo**: Inicio › Guías › Solicitar Certificado de Tradición y Libertad en Montería

#### Páginas estáticas

Para páginas normales (como "Acerca"):

- **Estructura**: Inicio › Título de la página
- **Ejemplo**: Inicio › Acerca de MONTERIAVENDE

## Configuración

### Archivo `_config.yml`

```yaml
# Configuración de migas de pan
breadcrumbs:
  enabled: true
  home_text: "Inicio"
  separator: "›"

# Configuración de categorías para migas de pan
category_names:
  guia: "Guías"
  certificados: "Certificados"
  monteria: "Montería"
  productos: "Productos"
  servicios: "Servicios"
  formato: "Formatos"
  "hoja de vida": "Hoja de Vida"
```

### Categorías en posts

Para que funcionen correctamente, las categorías en los posts deben estar en formato de lista:

```yaml
---
layout: post
title: "Título del post"
categories: [categoria1, categoria2, categoria3]
---
```

**❌ Incorrecto:**

```yaml
categories: categoria1, categoria2, categoria3
```

**✅ Correcto:**

```yaml
categories: [categoria1, categoria2, categoria3]
```

## Archivos del sistema

### `_includes/breadcrumbs.html`

- Contiene la lógica principal para generar las migas de pan
- Detecta automáticamente el tipo de página (post vs página normal)
- Usa configuración del `_config.yml`

### CSS en `assets/estilos.css`

- Estilos responsivos para las migas de pan
- Se adapta a móviles con diseño vertical en pantallas pequeñas
- Colores coherentes con el tema del sitio

### Layout `_layouts/default.html`

- Incluye automáticamente las migas de pan en todas las páginas (excepto inicio)
- Condición:

```liquid
{% raw %}
{% unless page.url == '/' %}
  <!-- Código de las migas de pan -->
{% endunless %}
{% endraw %}
```

## Personalización

### Cambiar separador

En `_config.yml`:

```yaml
breadcrumbs:
  separator: "→" # o cualquier otro símbolo
```

### Cambiar texto de inicio

En `_config.yml`:

```yaml
breadcrumbs:
  home_text: "Home" # o el texto que prefieras
```

### Agregar nuevas categorías

En `_config.yml`:

```yaml
category_names:
  nueva_categoria: "Nombre a mostrar"
```

### Desactivar migas de pan

En `_config.yml`:

```yaml
breadcrumbs:
  enabled: false
```

## Características

### ✅ Funcionalidades incluidas

- **Responsivo**: Se adapta a móviles
- **Accesible**: Incluye `aria-label` para lectores de pantalla
- **SEO amigable**: Estructura semántica correcta
- **Configurable**: Fácil personalización
- **Automático**: No requiere configuración manual por página

### 🎨 Diseño

- **Estilo moderno**: Bordes redondeados y gradientes sutiles
- **Interactivo**: Efectos hover en los enlaces
- **Coherente**: Colores del tema del sitio
- **Icono de inicio**: Emoji de casa para mayor claridad

## Navegación

### En escritorio

```
🏠 Inicio › Categoría › Página actual
```

### En móviles (< 480px)

```
🏠 Inicio
Categoría
Página actual
```

## Beneficios para el usuario

1. **Orientación**: Saber dónde están en el sitio
2. **Navegación rápida**: Volver a secciones anteriores
3. **Estructura clara**: Entender la organización del contenido
4. **Experiencia mejorada**: Navegación más intuitiva

## Beneficios SEO

1. **Estructura de datos**: Ayuda a los motores de búsqueda
2. **Enlaces internos**: Mejora el link juice
3. **Navegación clara**: Facilita el crawling
4. **Experiencia de usuario**: Factor de ranking

¡El sistema está completamente implementado y funcionando!
