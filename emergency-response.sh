#!/bin/bash

# SCRIPT DE EMERGENCIA - EJECUTAR INMEDIATAMENTE
# bash emergency-response.sh

echo "🚨 RESPUESTA DE EMERGENCIA ACTIVADA"
echo "===================================="
echo "Fecha: $(date)"
echo ""

echo "📋 CHECKLIST DE ACCIONES CRÍTICAS:"
echo "================================="
echo ""

echo "1. 🔒 CAMBIAR CONTRASEÑAS (HACER AHORA):"
echo "   [ ] Hosting/FTP - cambiar contraseña inmediatamente"
echo "   [ ] Panel de control del hosting (cPanel/Plesk)"
echo "   [ ] DNS provider (Cloudflare/Namecheap/etc.)"
echo "   [ ] GitHub (si está conectado)"
echo "   [ ] Email del dominio"
echo ""

echo "2. 🛡️ CONFIGURAR DNS (URGENTE):"
echo "   [ ] Eliminar subdominio ftp.guiasimo.com"
echo "   [ ] Deshabilitar wildcard DNS (*) si existe"
echo "   [ ] Verificar registros A y CNAME"
echo ""

echo "3. 📞 CONTACTAR PROVEEDORES:"
echo "   [ ] Hosting provider - reportar compromiso"
echo "   [ ] DNS provider - verificar configuración"
echo "   [ ] Registrar del dominio si es necesario"
echo ""

echo "4. 🔍 COMANDOS DE VERIFICACIÓN DNS:"
echo "=================================="
echo ""
echo "# Verificar configuración actual:"
echo "nslookup ftp.guiasimo.com"
echo "nslookup guiasimo.com"
echo "dig ftp.guiasimo.com"
echo "dig guiasimo.com ANY"
echo ""

echo "5. 🚫 DESACTIVAR SUBDOMAIN MALICIOSO:"
echo "   En tu panel DNS, ELIMINAR:"
echo "   - Registro A: ftp.guiasimo.com"
echo "   - Registro CNAME: ftp.guiasimo.com"
echo "   - Cualquier wildcard: *.guiasimo.com"
echo ""

echo "6. 🔧 VERIFICAR .htaccess EN SERVIDOR:"
echo "   Conectar por FTP/SFTP y verificar:"
echo "   - ¿Hay archivos .htaccess no autorizados?"
echo "   - ¿Hay redirects sospechosos?"
echo "   - ¿Hay archivos PHP maliciosos?"
echo ""

echo "7. 📊 MONITOREO POST-LIMPIEZA:"
echo "   Después de limpiar, ejecutar cada hora:"
echo "   curl -s http://ftp.guiasimo.com"
echo "   Si devuelve error 404 o no conecta = ¡ÉXITO!"
echo ""

echo "⚠️  IMPORTANTE:"
echo "==============="
echo "- TU CÓDIGO JEKYLL LOCAL ESTÁ LIMPIO"
echo "- EL PROBLEMA ESTÁ EN EL DNS/HOSTING"
echo "- NO es un virus en tu computadora"
echo "- ES un ataque al nivel de infraestructura"
echo ""

echo "🔴 ESTADO CRÍTICO HASTA QUE SE COMPLETE LA LIMPIEZA"
echo "📞 CONTACTAR HOSTING PROVIDER INMEDIATAMENTE"

# Crear archivo de estado
echo "$(date): Respuesta de emergencia activada - Subdomain ftp.guiasimo.com comprometido" >> incident-log.txt

echo ""
echo "📋 Log guardado en: incident-log.txt"
echo "📚 Guía completa en: SECURITY-INCIDENT.md"
