# 🔍 VERIFICACIÓN DE SEGURIDAD PARA GITHUB PAGES

## 📋 **Checklist de Seguridad GitHub Pages**

### **1. ✅ VENTAJAS DE SEGURIDAD (Automáticas):**

- **🛡️ No hay servidor que hackear** - GitHub maneja todo
- **🔒 HTTPS automático** - SSL/TLS incluido
- **📝 Control de versiones** - Todo cambio queda registrado
- **🚫 Sin acceso FTP** - No pueden subir archivos maliciosos
- **⚡ CDN global** - Protección DDoS incluida
- **🔄 Builds automáticos** - Solo código autorizado se publica

### **2. 🔍 PUNTOS A VERIFICAR:**

#### **A. Repositorio GitHub:**

```bash
# Verificar historial reciente de commits:
git log --oneline -10

# Buscar cambios sospechosos:
git log --grep="casino\|gambling\|slot" --all

# Verificar archivos modificados recientemente:
git status
git diff HEAD~1
```

#### **B. Configuración del Repositorio:**

- [ ] Repositorio es privado o público controlado
- [ ] Solo tú tienes permisos de escritura
- [ ] No hay colaboradores desconocidos
- [ ] Tokens de acceso seguros

#### **C. Custom Domain (si usas):**

- [ ] Verificar en Settings > Pages
- [ ] CNAME file correcto
- [ ] DNS apunta a GitHub Pages IPs correctas

### **3. 🚨 SOBRE EL SUBDOMAIN MALICIOSO:**

**SI ESTÁS EN GITHUB PAGES, el problema NO es tu sitio, sino tu DNS:**

#### **Causas Posibles:**

1. **DNS Wildcard malicioso:** `*.tudominio.com`
2. **Subdomain no autorizado** en tu proveedor DNS
3. **DNS hijacking** en tu proveedor
4. **Registro DNS fantasma** que no recuerdas haber creado

#### **Solución:**

1. **Revisar panel DNS** (Cloudflare, Namecheap, etc.)
2. **Eliminar registros no autorizados**
3. **Deshabilitar wildcard DNS**

### **4. 📊 COMANDOS DE VERIFICACIÓN:**

```bash
# Ver configuración actual de GitHub Pages:
# Ve a: https://github.com/TUUSUARIO/TUREPO/settings/pages

# Verificar historial limpio:
git log --oneline --since="1 month ago"

# Buscar archivos sospechosos:
find . -name "*.php" # GitHub Pages no ejecuta PHP
find . -name "*casino*" -o -name "*gambling*"

# Verificar _config.yml:
cat _config.yml | grep -v "^#" | grep -v "^$"
```

### **5. ⚡ VERIFICACIÓN RÁPIDA:**

#### **Tu repositorio está limpio si:**

- [ ] No hay commits sospechosos en `git log`
- [ ] No hay archivos PHP en el repositorio
- [ ] \_config.yml solo tiene tu configuración
- [ ] No hay colaboradores desconocidos

#### **El problema es solo DNS si:**

- [ ] Tu sitio principal funciona normal
- [ ] Solo el subdomain `ftp.` está comprometido
- [ ] No hay archivos maliciosos en tu repo

## 🛡️ **RECOMENDACIONES ESPECÍFICAS PARA GITHUB PAGES:**

### **A. Seguridad del Repositorio:**

```yaml
# En _config.yml - Asegurar configuración:
safe: true
incremental: false
lsi: false
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap
```

### **B. Protección de Branches:**

1. Ve a Settings > Branches
2. Protege tu branch principal
3. Requiere reviews para pull requests

### **C. Secrets y Tokens:**

- Usa GitHub Secrets para datos sensibles
- Revoca tokens antiguos
- Activa 2FA en tu cuenta GitHub

### **D. Monitoreo:**

```bash
# Script para monitorear cambios:
#!/bin/bash
git fetch origin
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    echo "¡Hay cambios nuevos en el repositorio!"
    git log HEAD..@{u} --oneline
fi
```

## 🔐 **CONFIGURACIÓN DNS SEGURA:**

### **Registros DNS Recomendados:**

```dns
# Solo estos registros (NO wildcards):
A     @                 185.199.108.153
A     @                 185.199.109.153
A     @                 185.199.110.153
A     @                 185.199.111.153
CNAME www               tuusuario.github.io
TXT   @                 "verificación de dominio"

# NO DEBE EXISTIR:
CNAME *                 (wildcard)
A     ftp               (subdomain no autorizado)
CNAME ftp               (subdomain no autorizado)
```

### **Eliminar Subdomain Malicioso:**

1. **Accede a tu proveedor DNS**
2. **Busca registro `ftp.tudominio.com`**
3. **ELIMINARLO completamente**
4. **Verificar que no hay wildcard `*`**

## 📋 **PLAN DE ACCIÓN GITHUB PAGES:**

### **Inmediato (Hacer Ahora):**

1. **🔍 Verificar repositorio GitHub:**

   - Revisar commits recientes
   - Verificar colaboradores
   - Buscar archivos sospechosos

2. **🔧 Limpiar DNS:**

   - Eliminar `ftp.tudominio.com`
   - Verificar configuración DNS
   - Deshabilitar wildcards

3. **🔒 Fortalecer cuenta GitHub:**
   - Cambiar contraseña GitHub
   - Activar 2FA
   - Revisar aplicaciones autorizadas

### **Seguimiento:**

- Monitorear commits diariamente
- Verificar que `ftp.tudominio.com` no funcione
- Configurar alertas de GitHub

## ✅ **CONCLUSIÓN:**

**GitHub Pages es MUCHO más seguro** que hosting tradicional:

- Tu código está protegido en Git
- No hay servidor que comprometer
- El problema es probablemente solo DNS

**Acción principal:** Limpiar configuración DNS, no tanto el código.

---

**🔒 GitHub Pages + DNS limpio = Sitio muy seguro**
