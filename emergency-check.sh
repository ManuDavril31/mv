#!/bin/bash

# Script de verificación de compromiso inmediata
# Ejecutar: bash emergency-check.sh

echo "🚨 VERIFICACIÓN DE COMPROMISO DE SEGURIDAD"
echo "=========================================="
echo "Fecha: $(date)"
echo ""

# Verificar archivos maliciosos en el sitio
echo "🔍 1. VERIFICANDO ARCHIVOS MALICIOSOS..."
echo "----------------------------------------"

# Buscar contenido de gambling/slots
if grep -r "PEKA77\|gambling\|slot\|casino\|jackpot" ./ --exclude-dir=_site --exclude-dir=.git 2>/dev/null; then
    echo "❌ ALERTA: Contenido malicioso encontrado en archivos locales"
else
    echo "✅ OK: No se encontró contenido malicioso en archivos locales"
fi

# Buscar archivos PHP sospechosos (Jekyll no debería tenerlos)
echo ""
echo "🔍 2. VERIFICANDO ARCHIVOS PHP SOSPECHOSOS..."
echo "--------------------------------------------"
PHP_FILES=$(find . -name "*.php" -not -path "./_site/*" 2>/dev/null)
if [ -n "$PHP_FILES" ]; then
    echo "❌ ALERTA: Archivos PHP encontrados (Jekyll no debería tenerlos):"
    echo "$PHP_FILES"
else
    echo "✅ OK: No se encontraron archivos PHP sospechosos"
fi

# Verificar archivos ocultos sospechosos
echo ""
echo "🔍 3. VERIFICANDO ARCHIVOS OCULTOS..."
echo "-----------------------------------"
HIDDEN_FILES=$(find . -type f -name ".*" -not -path "./.git/*" -not -name ".gitignore" -not -name ".htaccess" 2>/dev/null)
if [ -n "$HIDDEN_FILES" ]; then
    echo "⚠️  ADVERTENCIA: Archivos ocultos encontrados:"
    echo "$HIDDEN_FILES"
else
    echo "✅ OK: Solo archivos ocultos conocidos encontrados"
fi

# Verificar modificaciones recientes sospechosas
echo ""
echo "🔍 4. VERIFICANDO MODIFICACIONES RECIENTES..."
echo "-------------------------------------------"
RECENT_FILES=$(find . -type f -mtime -1 -not -path "./_site/*" -not -path "./.git/*" 2>/dev/null | head -10)
if [ -n "$RECENT_FILES" ]; then
    echo "📅 Archivos modificados en las últimas 24 horas:"
    echo "$RECENT_FILES"
else
    echo "✅ OK: No hay modificaciones recientes"
fi

# Verificar .htaccess
echo ""
echo "🔍 5. VERIFICANDO .htaccess..."
echo "----------------------------"
if [ -f ".htaccess" ]; then
    if grep -q "gambling\|casino\|slot\|redirect" .htaccess 2>/dev/null; then
        echo "❌ ALERTA: .htaccess contiene contenido sospechoso"
        echo "Contenido sospechoso:"
        grep "gambling\|casino\|slot\|redirect" .htaccess
    else
        echo "✅ OK: .htaccess parece limpio"
    fi
else
    echo "ℹ️  .htaccess no encontrado"
fi

# Verificar configuración Jekyll
echo ""
echo "🔍 6. VERIFICANDO _config.yml..."
echo "------------------------------"
if [ -f "_config.yml" ]; then
    if grep -q "gambling\|casino\|slot\|peka77" _config.yml 2>/dev/null; then
        echo "❌ ALERTA: _config.yml comprometido"
    else
        echo "✅ OK: _config.yml parece limpio"
    fi
else
    echo "❌ ERROR: _config.yml no encontrado"
fi

# Verificar conectividad al subdomain sospechoso
echo ""
echo "🔍 7. VERIFICANDO SUBDOMAIN SOSPECHOSO..."
echo "---------------------------------------"
if curl -s --connect-timeout 5 "http://ftp.guiasimo.com" | grep -q "PEKA77\|gambling\|slot" 2>/dev/null; then
    echo "❌ ALERTA CRÍTICA: http://ftp.guiasimo.com ESTÁ SIRVIENDO CONTENIDO MALICIOSO"
    echo "Acción requerida: Contactar hosting provider INMEDIATAMENTE"
else
    echo "ℹ️  No se pudo conectar al subdomain sospechoso (puede ser bueno)"
fi

# Verificar DNS
echo ""
echo "🔍 8. VERIFICANDO CONFIGURACIÓN DNS..."
echo "------------------------------------"
if command -v nslookup >/dev/null 2>&1; then
    echo "Verificando ftp.guiasimo.com:"
    nslookup ftp.guiasimo.com 2>/dev/null || echo "No se pudo resolver ftp.guiasimo.com"
    echo ""
    echo "Verificando guiasimo.com:"
    nslookup guiasimo.com 2>/dev/null || echo "No se pudo resolver guiasimo.com"
else
    echo "⚠️  nslookup no disponible, verificar DNS manualmente"
fi

# Resumen y acciones recomendadas
echo ""
echo "📋 RESUMEN Y ACCIONES RECOMENDADAS"
echo "=================================="
echo ""
echo "🚨 ACCIONES INMEDIATAS REQUERIDAS:"
echo "1. 🔒 CAMBIAR contraseñas de FTP/hosting AHORA"
echo "2. 🔍 CONTACTAR al hosting provider sobre ftp.guiasimo.com"
echo "3. 🛡️ VERIFICAR configuración DNS en tu proveedor"
echo "4. 📞 REPORTAR el incidente al hosting"
echo ""
echo "📚 Consultar SECURITY-INCIDENT.md para detalles completos"
echo ""
echo "⏰ Verificación completada: $(date)"

# Crear log de la verificación
echo "$(date): Verificación de compromiso ejecutada" >> security-check.log
