#!/bin/bash

# Script de verificación de seguridad para sitio Jekyll
# Usar: bash security-check.sh

echo "🔒 VERIFICACIÓN DE SEGURIDAD - MONTERIAVENDE"
echo "==========================================="

# Verificar que el sitio esté construido
if [ ! -d "_site" ]; then
    echo "❌ Error: Sitio no construido. Ejecuta 'bundle exec jekyll build' primero."
    exit 1
fi

echo "✅ Verificando estructura del sitio..."

# Verificar que archivos sensibles no estén en _site
SENSITIVE_FILES=(
    "_config.yml"
    "Gemfile"
    "Gemfile.lock"
    ".git"
    ".vscode"
    "README.md"
    "ROBOTS.md"
    "BREADCRUMBS.md"
)

echo "🔍 Verificando archivos sensibles..."
for file in "${SENSITIVE_FILES[@]}"; do
    if [ -e "_site/$file" ]; then
        echo "❌ ALERTA: Archivo sensible encontrado en _site: $file"
    else
        echo "✅ OK: $file no está expuesto"
    fi
done

# Verificar headers de seguridad en HTML generado
echo "🔍 Verificando headers de seguridad en HTML..."
if grep -q "Content-Security-Policy" _site/index.html; then
    echo "✅ OK: Content-Security-Policy encontrado"
else
    echo "❌ FALTA: Content-Security-Policy"
fi

if grep -q "X-Frame-Options" _site/index.html; then
    echo "✅ OK: X-Frame-Options encontrado"
else
    echo "❌ FALTA: X-Frame-Options"
fi

if grep -q "X-Content-Type-Options" _site/index.html; then
    echo "✅ OK: X-Content-Type-Options encontrado"
else
    echo "❌ FALTA: X-Content-Type-Options"
fi

# Verificar robots.txt
echo "🔍 Verificando robots.txt..."
if [ -f "_site/robots.txt" ]; then
    echo "✅ OK: robots.txt existe"
    if grep -q "Disallow: /.git/" _site/robots.txt; then
        echo "✅ OK: Protección .git en robots.txt"
    else
        echo "❌ FALTA: Protección .git en robots.txt"
    fi
else
    echo "❌ FALTA: robots.txt"
fi

# Verificar sitemap
echo "🔍 Verificando sitemap.xml..."
if [ -f "_site/sitemap.xml" ]; then
    echo "✅ OK: sitemap.xml existe"
    
    # Contar URLs en sitemap
    URL_COUNT=$(grep -c "<url>" _site/sitemap.xml)
    echo "📊 URLs en sitemap: $URL_COUNT"
    
    # Verificar que páginas sensibles no estén en sitemap
    if grep -q "ROBOTS" _site/sitemap.xml; then
        echo "❌ ALERTA: ROBOTS.md encontrado en sitemap"
    else
        echo "✅ OK: ROBOTS.md no está en sitemap"
    fi
    
    if grep -q "BREADCRUMBS" _site/sitemap.xml; then
        echo "❌ ALERTA: BREADCRUMBS.md encontrado en sitemap"
    else
        echo "✅ OK: BREADCRUMBS.md no está en sitemap"
    fi
else
    echo "❌ FALTA: sitemap.xml"
fi

# Verificar .htaccess
echo "🔍 Verificando .htaccess..."
if [ -f "_site/.htaccess" ]; then
    echo "✅ OK: .htaccess existe"
    if grep -q "X-Frame-Options" _site/.htaccess; then
        echo "✅ OK: Headers de seguridad en .htaccess"
    else
        echo "❌ FALTA: Headers de seguridad en .htaccess"
    fi
else
    echo "❌ FALTA: .htaccess"
fi

# Buscar posibles vulnerabilidades en el HTML
echo "🔍 Buscando posibles vulnerabilidades..."
if grep -r "javascript:" _site/ 2>/dev/null | grep -v ".js:"; then
    echo "❌ ALERTA: javascript: URLs encontradas"
else
    echo "✅ OK: No se encontraron javascript: URLs"
fi

if grep -r "onclick\|onload\|onerror" _site/ 2>/dev/null | head -5; then
    echo "⚠️  ADVERTENCIA: Eventos inline encontrados (revisar si son necesarios)"
else
    echo "✅ OK: No se encontraron eventos inline"
fi

# Verificar permisos de archivos (solo en sistemas Unix)
if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "cygwin" ]]; then
    echo "🔍 Verificando permisos de archivos..."
    
    # Verificar que archivos sensibles no tengan permisos de escritura para todos
    if [ -f ".htaccess" ]; then
        PERMS=$(stat -c "%a" .htaccess 2>/dev/null || echo "644")
        if [ "$PERMS" -gt "644" ]; then
            echo "❌ ALERTA: .htaccess tiene permisos demasiado amplios: $PERMS"
        else
            echo "✅ OK: Permisos de .htaccess son seguros"
        fi
    fi
fi

# Resumen
echo ""
echo "🏁 VERIFICACIÓN COMPLETADA"
echo "========================="
echo "Revisa los elementos marcados con ❌ y ⚠️"
echo ""
echo "📚 Para más información, consulta SECURITY.md"
