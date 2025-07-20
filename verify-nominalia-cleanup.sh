#!/bin/bash

# Script de verificación post-limpieza DNS Nominalia
# Ejecutar después de limpiar el DNS: bash verify-nominalia-cleanup.sh

echo "🔍 VERIFICACIÓN POST-LIMPIEZA NOMINALIA"
echo "======================================"
echo "Fecha: $(date)"
echo "Dominio: guiasimo.com"
echo ""

echo "📋 VERIFICANDO LIMPIEZA DNS..."
echo "==============================="

# Verificar que ftp.guiasimo.com ya no existe
echo ""
echo "1. 🚫 Verificando que ftp.guiasimo.com ya NO resuelve..."
echo "--------------------------------------------------------"

if nslookup ftp.guiasimo.com 2>/dev/null | grep -q "NXDOMAIN\|can't find"; then
    echo "✅ EXCELENTE: ftp.guiasimo.com ya no existe (NXDOMAIN)"
    FTP_CLEAN=true
else
    echo "❌ PROBLEMA: ftp.guiasimo.com aún resuelve"
    echo "Resultado nslookup:"
    nslookup ftp.guiasimo.com 2>/dev/null || echo "Error en nslookup"
    FTP_CLEAN=false
fi

# Verificar que el sitio principal sigue funcionando
echo ""
echo "2. ✅ Verificando que guiasimo.com sigue funcionando..."
echo "----------------------------------------------------"

if nslookup guiasimo.com 2>/dev/null | grep -q "185.199"; then
    echo "✅ PERFECTO: guiasimo.com apunta a GitHub Pages correctamente"
    MAIN_OK=true
else
    echo "⚠️  ADVERTENCIA: Verificar configuración de guiasimo.com"
    echo "Resultado nslookup:"
    nslookup guiasimo.com 2>/dev/null || echo "Error en nslookup"
    MAIN_OK=false
fi

# Verificar que el contenido malicioso ya no es accesible
echo ""
echo "3. 🛡️ Verificando que contenido malicioso ya no es accesible..."
echo "-------------------------------------------------------------"

if curl -s --connect-timeout 10 http://ftp.guiasimo.com 2>/dev/null | grep -q "PEKA77\|gambling\|casino"; then
    echo "❌ CRÍTICO: Contenido malicioso AÚN ACCESIBLE"
    echo "Acción: Contactar Nominalia inmediatamente"
    MALWARE_GONE=false
else
    if curl -s --connect-timeout 5 http://ftp.guiasimo.com >/dev/null 2>&1; then
        echo "⚠️  ADVERTENCIA: ftp.guiasimo.com responde pero sin contenido malicioso"
        MALWARE_GONE=partial
    else
        echo "✅ EXCELENTE: ftp.guiasimo.com no es accesible"
        MALWARE_GONE=true
    fi
fi

# Verificar www también
echo ""
echo "4. 🌐 Verificando www.guiasimo.com..."
echo "-----------------------------------"

if nslookup www.guiasimo.com 2>/dev/null | grep -q "github"; then
    echo "✅ CORRECTO: www.guiasimo.com apunta a GitHub"
    WWW_OK=true
else
    echo "ℹ️  INFO: Verificar configuración de www (puede ser normal)"
    WWW_OK=partial
fi

# Verificar propagación DNS global
echo ""
echo "5. 🌍 Verificando propagación DNS global..."
echo "------------------------------------------"

echo "Verificando desde diferentes servidores DNS:"

# Google DNS
if nslookup ftp.guiasimo.com 8.8.8.8 2>/dev/null | grep -q "NXDOMAIN\|can't find"; then
    echo "✅ Google DNS (8.8.8.8): ftp.guiasimo.com no existe"
    GOOGLE_DNS_CLEAN=true
else
    echo "⚠️  Google DNS (8.8.8.8): ftp.guiasimo.com aún visible"
    GOOGLE_DNS_CLEAN=false
fi

# Cloudflare DNS  
if nslookup ftp.guiasimo.com 1.1.1.1 2>/dev/null | grep -q "NXDOMAIN\|can't find"; then
    echo "✅ Cloudflare DNS (1.1.1.1): ftp.guiasimo.com no existe"
    CLOUDFLARE_DNS_CLEAN=true
else
    echo "⚠️  Cloudflare DNS (1.1.1.1): ftp.guiasimo.com aún visible"
    CLOUDFLARE_DNS_CLEAN=false
fi

# Resumen y puntuación
echo ""
echo "📊 RESUMEN DE LIMPIEZA"
echo "====================="

SCORE=0
TOTAL=6

if [ "$FTP_CLEAN" = true ]; then
    echo "✅ ftp.guiasimo.com eliminado correctamente"
    ((SCORE++))
else
    echo "❌ ftp.guiasimo.com aún existe"
fi

if [ "$MAIN_OK" = true ]; then
    echo "✅ guiasimo.com funciona correctamente"
    ((SCORE++))
else
    echo "❌ guiasimo.com tiene problemas"
fi

if [ "$MALWARE_GONE" = true ]; then
    echo "✅ Contenido malicioso eliminado"
    ((SCORE++))
elif [ "$MALWARE_GONE" = partial ]; then
    echo "⚠️  Contenido malicioso parcialmente eliminado"
    ((SCORE++))
else
    echo "❌ Contenido malicioso aún accesible"
fi

if [ "$WWW_OK" = true ]; then
    echo "✅ www.guiasimo.com configurado correctamente"
    ((SCORE++))
elif [ "$WWW_OK" = partial ]; then
    echo "⚠️  www.guiasimo.com configuración aceptable"
    ((SCORE++))
fi

if [ "$GOOGLE_DNS_CLEAN" = true ]; then
    echo "✅ Limpieza propagada a Google DNS"
    ((SCORE++))
else
    echo "⏳ Esperando propagación a Google DNS"
fi

if [ "$CLOUDFLARE_DNS_CLEAN" = true ]; then
    echo "✅ Limpieza propagada a Cloudflare DNS"
    ((SCORE++))
else
    echo "⏳ Esperando propagación a Cloudflare DNS"
fi

# Resultado final
echo ""
echo "🎯 PUNTUACIÓN: $SCORE/$TOTAL"

if [ $SCORE -eq $TOTAL ]; then
    echo "🎉 PERFECTO: Limpieza completada exitosamente"
    echo "✅ Tu dominio está seguro y limpio"
elif [ $SCORE -ge 4 ]; then
    echo "👍 BIEN: Limpieza mayormente exitosa"
    echo "⏳ Esperar un poco más para propagación DNS completa"
elif [ $SCORE -ge 2 ]; then
    echo "⚠️  PARCIAL: Limpieza en progreso"
    echo "🔄 Ejecutar de nuevo en 10-15 minutos"
else
    echo "❌ PROBLEMA: Limpieza no completada"
    echo "📞 Contactar soporte de Nominalia"
fi

# Próximos pasos
echo ""
echo "📋 PRÓXIMOS PASOS:"
echo "=================="

if [ "$FTP_CLEAN" != true ]; then
    echo "1. 🔧 URGENTE: Revisar configuración DNS en Nominalia"
    echo "   - Asegurar que registro 'ftp' está eliminado"
    echo "   - Verificar que no hay wildcards '*'"
fi

if [ "$MALWARE_GONE" != true ]; then
    echo "2. 📞 CRÍTICO: Contactar Nominalia inmediatamente"
    echo "   - Reportar que subdomain malicioso sigue activo"
    echo "   - Solicitar limpieza manual"
fi

if [ $SCORE -ge 4 ]; then
    echo "3. 🔍 MONITOREO: Verificar de nuevo en 1-2 horas"
    echo "   - La propagación DNS puede tomar tiempo"
    echo "   - Ejecutar este script nuevamente"
fi

echo ""
echo "⏰ Verificación completada: $(date)"
echo "📁 Log guardado en verification-log.txt"

# Guardar log
echo "$(date): Verificación Nominalia - Score: $SCORE/$TOTAL" >> verification-log.txt
