# Guía de Seguridad - MONTERIAVENDE

## 🔒 **Medidas de Seguridad Implementadas**

Este sitio Jekyll ha sido configurado con múltiples capas de seguridad para proteger contra amenazas comunes web.

### **1. Headers de Seguridad HTTP**

#### **Content Security Policy (CSP)**

- **Archivo:** `_includes/security-headers.html`
- **Función:** Previene ataques XSS controlando qué recursos pueden cargar las páginas
- **Configuración:** Permite solo recursos del mismo origen y CDNs confiables (Google Fonts, etc.)

#### **X-Frame-Options**

- **Función:** Previene ataques de clickjacking
- **Valor:** `SAMEORIGIN` - solo permite embeber en el mismo dominio

#### **X-Content-Type-Options**

- **Función:** Previene MIME type sniffing
- **Valor:** `nosniff`

#### **X-XSS-Protection**

- **Función:** Activa la protección XSS integrada del navegador
- **Valor:** `1; mode=block`

#### **Referrer Policy**

- **Función:** Controla qué información se envía en el header Referrer
- **Valor:** `strict-origin-when-cross-origin`

#### **Permissions Policy**

- **Función:** Desactiva APIs no necesarias del navegador
- **APIs desactivadas:** Geolocalización, micrófono, cámara, pagos, USB

### **2. Configuración del Servidor (.htaccess)**

#### **Protección de Archivos Sensibles**

- Bloquea acceso a archivos de configuración: `.yml`, `.json`, `.md`
- Protege directorios del sistema: `.git`, `.jekyll-cache`, `_config.yml`
- Deniega acceso a archivos de backup: `.bak`, `.backup`, `.old`

#### **Headers de Seguridad a Nivel Servidor**

- Duplica los headers de seguridad HTML a nivel HTTP
- Configura cache seguro para archivos estáticos
- Desactiva server signature por seguridad

#### **Protección Anti-Bot**

- Bloquea bots maliciosos conocidos: AhrefsBot, MJ12bot, etc.
- Previene hotlinking de imágenes
- Desactiva listado de directorios

### **3. Robots.txt Securizado**

#### **Bloqueo de Directorios Sensibles**

```
Disallow: /.git/
Disallow: /.github/
Disallow: /.jekyll-cache/
Disallow: /.vscode/
```

#### **Control de Bots Maliciosos**

- Lista negra de bots que consumen recursos
- Control de frecuencia de rastreo para bots grandes
- Referencia al sitemap seguro

### **4. Configuración Jekyll Segura**

#### **Modo Seguro Activado**

```yaml
safe: true
lsi: false
highlighter: rouge
```

#### **Exclusión de Archivos Sensibles**

- Excluye automáticamente archivos de desarrollo del build final
- Protege archivos de configuración, logs, y backups

### **5. Filtros de Contenido**

#### **Sanitización Automática**

- Archivo: `_includes/security-filters.html`
- Escapa HTML peligroso automáticamente
- Filtra caracteres maliciosos en URLs
- Valida emails y URLs externas

### **6. Monitoreo de Seguridad**

#### **Script de Verificación**

- Archivo: `security-check.sh`
- Verifica configuración de seguridad automáticamente
- Detecta archivos expuestos accidentalmente
- Revisa headers y configuraciones

## 🛡️ **Mejores Prácticas Aplicadas**

### **Principio de Menor Privilegio**

- Solo se cargan recursos absolutamente necesarios
- APIs del navegador desactivadas por defecto
- Permisos mínimos para archivos y directorios

### **Defensa en Profundidad**

- **Capa 1:** Headers HTTP de seguridad
- **Capa 2:** Configuración del servidor (.htaccess)
- **Capa 3:** Robots.txt y control de acceso
- **Capa 4:** Filtros de contenido Jekyll
- **Capa 5:** Monitoreo y auditoría

### **Principio de Fallo Seguro**

- Si falla la carga de un recurso, el sitio sigue funcionando
- Headers de seguridad por defecto son restrictivos
- Configuración conservadora que se puede relajar si es necesario

## 🔧 **Configuración por Tipo de Hosting**

### **GitHub Pages**

```yaml
# En _config.yml
plugins:
  - jekyll-seo-tag
  - jekyll-sitemap
# Los headers se configuran vía HTML meta tags
```

### **Netlify**

```toml
# En netlify.toml
[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "SAMEORIGIN"
    X-XSS-Protection = "1; mode=block"
    X-Content-Type-Options = "nosniff"
```

### **Apache/VPS**

- Usar `.htaccess` incluido
- Verificar que `mod_headers` esté activo
- Configurar certificado SSL

### **Nginx**

```nginx
# En server block
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header X-Content-Type-Options "nosniff" always;
```

## 🚨 **Procedimiento de Incidentes de Seguridad**

### **1. Detección**

- Ejecutar `bash security-check.sh` regularmente
- Monitorear logs del servidor
- Revisar Google Search Console para alertas

### **2. Evaluación**

- Determinar tipo y severidad del problema
- Verificar si hay datos comprometidos
- Evaluar impacto en usuarios

### **3. Contención**

- Aplicar parches inmediatos
- Bloquear IPs maliciosas si es necesario
- Activar modo de mantenimiento si es crítico

### **4. Recuperación**

- Restaurar desde backup limpio si es necesario
- Aplicar todas las actualizaciones de seguridad
- Verificar integridad del sitio

### **5. Post-Incidente**

- Documentar lo ocurrido
- Mejorar medidas preventivas
- Actualizar procedimientos

## 📋 **Checklist de Seguridad Mensual**

### **Verificaciones Técnicas**

- [ ] Ejecutar `bash security-check.sh`
- [ ] Verificar certificado SSL (si aplica)
- [ ] Revisar logs de acceso para patrones sospechosos
- [ ] Actualizar dependencias: `bundle update`
- [ ] Verificar integridad del sitemap y robots.txt

### **Verificaciones de Contenido**

- [ ] Revisar formularios de contacto (si los hay)
- [ ] Verificar que información sensible no esté expuesta
- [ ] Comprobar que páginas privadas tengan `noindex`
- [ ] Validar enlaces externos

### **Monitoreo**

- [ ] Revisar Google Search Console
- [ ] Verificar Google Analytics para tráfico anormal
- [ ] Comprobar rendimiento del sitio
- [ ] Revisar comentarios/feedback de usuarios

## 🔐 **Configuración HTTPS**

### **Obtener Certificado SSL**

```bash
# Para VPS con Certbot (Let's Encrypt)
sudo certbot --apache -d tudominio.com -d www.tudominio.com
```

### **Activar HSTS**

Una vez que tengas HTTPS funcionando, descomenta en `.htaccess`:

```apache
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
```

### **Actualizar URLs**

```yaml
# En _config.yml
url: "https://tudominio.com"
```

## 📊 **Métricas de Seguridad**

### **Indicadores Clave**

- **Headers de seguridad:** 100% implementados
- **Archivos sensibles protegidos:** 100%
- **Certificado SSL:** ✅ (cuando se configure)
- **Score de seguridad:** Verificar en securityheaders.com

### **Herramientas de Testing**

- **SecurityHeaders.com:** Verificar headers HTTP
- **SSLLabs.com:** Evaluar configuración SSL
- **GTmetrix:** Verificar rendimiento y seguridad
- **Google PageSpeed Insights:** Auditoría general

## 🆘 **Contacto de Emergencia**

Si detectas un problema de seguridad:

1. **NO** publiques el problema públicamente
2. Documenta los pasos para reproducir el problema
3. Contacta al administrador del sitio
4. Si es crítico, activa el modo de mantenimiento

## 📚 **Recursos Adicionales**

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Jekyll Security Guidelines](https://jekyllrb.com/docs/security/)
- [Content Security Policy Guide](https://content-security-policy.com/)
- [HTTP Security Headers](https://securityheaders.com/)

---

**Última actualización:** 19 de julio de 2025  
**Versión:** 1.0  
**Próxima revisión:** 19 de agosto de 2025
