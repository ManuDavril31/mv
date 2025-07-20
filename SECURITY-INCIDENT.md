# 🚨 INVESTIGACIÓN DE COMPROMISO DE SEGURIDAD - MONTERIAVENDE

## 📋 **Reporte de Incidente**

**Fecha:** 19 de julio de 2025  
**Tipo de incidente:** Posible compromiso de sitio web  
**URL afectada:** `http://ftp.guiasimo.com`  
**Contenido malicioso:** PEKA77 - Slot Jackpot Progressive (gambling)

## 🔍 **Análisis Inicial**

### **Posibles Causas:**

1. **Compromiso de FTP:**

   - Credenciales FTP filtradas o débiles
   - Acceso no autorizado al servidor
   - Archivos maliciosos subidos vía FTP

2. **Subdomain Hijacking:**

   - Subdomain `ftp.` no configurado apropiadamente
   - DNS pointing a servidor controlado por atacantes
   - Wildcard DNS mal configurado

3. **Inyección de Contenido:**

   - Scripts maliciosos en archivos existentes
   - .htaccess comprometido
   - Base de datos infectada (si usas CMS adicional)

4. **Compromiso de Hosting:**
   - Panel de control comprometido
   - Servidor compartido infectado
   - Escalamiento de privilegios

## 🛡️ **PLAN DE RESPUESTA INMEDIATA**

### **FASE 1: CONTENCIÓN (URGENTE)**

#### **1.1 Cambiar Credenciales Inmediatamente**

```bash
# Lista de credenciales a cambiar:
- ✅ FTP/SFTP del hosting
- ✅ Panel de control del hosting (cPanel, Plesk, etc.)
- ✅ DNS management (Cloudflare, etc.)
- ✅ Git/GitHub (si está conectado)
- ✅ Email asociado al dominio
```

#### **1.2 Verificar Configuración DNS**

```bash
# Comandos de verificación:
nslookup ftp.guiasimo.com
dig ftp.guiasimo.com
dig guiasimo.com
```

#### **1.3 Revisar Archivos del Sitio**

```bash
# Buscar archivos sospechosos:
find . -name "*.php" -exec grep -l "PEKA77\|jackpot\|gambling" {} \;
find . -name "*.html" -exec grep -l "slot\|casino" {} \;
find . -type f -newer -1 # Archivos modificados en último día
```

### **FASE 2: INVESTIGACIÓN**

#### **2.1 Verificar Integridad de Archivos**

```bash
# Comparar con versión conocida limpia:
diff -r /backup/sitio/limpio .
git status # Ver cambios no autorizados
```

#### **2.2 Analizar Logs**

```bash
# Revisar logs del servidor (si tienes acceso):
tail -100 /var/log/apache2/access.log | grep -i "peka\|slot\|gambling"
tail -100 /var/log/vsftpd.log # Logs FTP
```

### **FASE 3: LIMPIEZA**

#### **3.1 Eliminar Contenido Malicioso**

```bash
# Buscar y eliminar archivos sospechosos:
find . -name "*peka*" -type f -delete
find . -name "*slot*" -type f -delete
find . -exec grep -l "gambling\|casino\|jackpot" {} \; # Revisar manualmente
```

#### **3.2 Restaurar desde Backup Limpio**

```bash
# Si tienes backup verificado como limpio:
cp -r /backup/sitio/limpio/* ./
```

## 🔐 **MEDIDAS DE PROTECCIÓN INMEDIATAS**

### **A. Fortificar FTP/SFTP**

```apache
# En .htaccess - Bloquear acceso a archivos sensibles
<Files "*.log">
    Order allow,deny
    Deny from all
</Files>

<Files "*.backup">
    Order allow,deny
    Deny from all
</Files>

# Bloquear IPs sospechosas (ajustar según logs)
<RequireAll>
    Require all granted
    Require not ip 192.168.1.100  # Ejemplo - sustituir con IP real
</RequireAll>
```

### **B. Configurar DNS Seguro**

```dns
# Eliminar wildcard DNS si existe:
*.guiasimo.com -> NO DEBE EXISTIR

# Configurar solo subdominios necesarios:
www.guiasimo.com -> Tu IP
guiasimo.com -> Tu IP
# NO configurar: ftp.guiasimo.com (a menos que lo uses)
```

### **C. Headers de Seguridad Adicionales**

```html
<!-- Agregar a _includes/security-headers.html -->
<!-- Reportar violaciones CSP -->
<meta
  http-equiv="Content-Security-Policy"
  content="...; report-uri https://tudominio.com/csp-report;"
/>

<!-- Prevenir ataques de inyección adicionales -->
<meta http-equiv="X-Permitted-Cross-Domain-Policies" content="none" />
<meta
  name="robots"
  content="noindex, nofollow, noarchive, nosnippet, noimageindex"
  data-temp="incident-response"
/>
```

## 📊 **COMANDOS DE VERIFICACIÓN INMEDIATA**

### **1. Verificar si tu sitio real está comprometido:**

```bash
# Desde tu directorio Jekyll:
grep -r "PEKA77\|gambling\|slot\|casino" ./ --exclude-dir=_site
find . -name "*.php" # Jekyll no debería tener archivos PHP
find . -type f -name ".*" # Archivos ocultos sospechosos
```

### **2. Verificar configuración DNS:**

```bash
# Verificar todos los subdominios:
dig guiasimo.com
dig www.guiasimo.com
dig ftp.guiasimo.com
dig mail.guiasimo.com

# Verificar registros MX y TXT:
dig guiasimo.com MX
dig guiasimo.com TXT
```

### **3. Verificar archivos de configuración:**

```bash
# Revisar .htaccess:
cat .htaccess | grep -v "^#" | grep -v "^$"

# Revisar robots.txt:
cat robots.txt

# Revisar _config.yml:
grep -v "^#" _config.yml
```

## 🚑 **RESPUESTA DE EMERGENCIA**

### **Acciones Inmediatas (Hacer AHORA):**

1. **🔒 Cambiar contraseñas:**

   - FTP/hosting panel
   - DNS provider
   - Email del dominio

2. **🔍 Investigar origen:**

   - Verificar subdomain `ftp.guiasimo.com`
   - Revisar configuración DNS
   - Buscar archivos maliciosos

3. **🛡️ Contener daño:**
   - Deshabilitar FTP temporalmente
   - Activar modo mantenimiento si es necesario
   - Contactar al hosting provider

### **Si Encuentras Archivos Maliciosos:**

```bash
# Crear backup de evidencia antes de limpiar:
mkdir /tmp/evidencia-$(date +%Y%m%d)
cp -r ./archivos-sospechosos /tmp/evidencia-$(date +%Y%m%d)/

# Después eliminar archivos maliciosos:
rm -f ./archivo-malicioso.php
```

## 📞 **Contactos de Emergencia**

1. **Hosting Provider:** [Contactar inmediatamente]
2. **DNS Provider:** [Verificar configuración]
3. **Registrar del Dominio:** [Si DNS está comprometido]

## 📋 **Checklist de Verificación**

- [ ] Contraseñas cambiadas
- [ ] DNS verificado y limpio
- [ ] Archivos maliciosos eliminados
- [ ] Logs del servidor revisados
- [ ] Sitemap y robots.txt verificados
- [ ] Headers de seguridad actualizados
- [ ] FTP/SFTP reconfigurado con claves más fuertes
- [ ] Backup limpio restaurado
- [ ] Monitoreo adicional configurado

## 🔍 **Monitoreo Continuo**

Después de la limpieza, implementar vigilancia:

```bash
# Script de monitoreo diario:
#!/bin/bash
echo "Verificando compromiso diario..."
grep -r "gambling\|casino\|slot" ./ 2>/dev/null && echo "¡ALERTA!"
find . -name "*.php" 2>/dev/null && echo "¡Archivos PHP encontrados!"
curl -s "http://ftp.guiasimo.com" | grep -q "PEKA77" && echo "¡Subdomain aún comprometido!"
```

---

**⚠️ ESTE ES UN INCIDENTE DE SEGURIDAD ACTIVO**  
**📞 Contactar al hosting provider INMEDIATAMENTE**  
**🔒 Cambiar contraseñas ANTES de continuar**
