# 🔧 GUÍA ESPECÍFICA PARA NOMINALIA - Limpiar DNS Comprometido

## 🎯 **SITUACIÓN:**

- **Dominio:** guiasimo.com (gestionado en Nominalia)
- **Problema:** Subdomain `ftp.guiasimo.com` sirviendo contenido malicioso
- **Sitio principal:** GitHub Pages (seguro y limpio)
- **Acción requerida:** Limpiar configuración DNS en Nominalia

## 🚀 **PASOS ESPECÍFICOS PARA NOMINALIA**

### **PASO 1: Acceder al Panel de Nominalia**

1. **🔗 Ir a:** https://www.nominalia.com/
2. **🔑 Iniciar sesión** con tu cuenta
3. **📋 Ir a:** "Mis Dominios" o "Panel de Control"
4. **🎯 Seleccionar:** guiasimo.com

### **PASO 2: Acceder a Gestión DNS**

En el panel de tu dominio:

1. **Buscar:** "DNS" o "Gestión DNS" o "Configuración DNS"
2. **Hacer clic en:** "Editar DNS" o "Gestionar DNS"
3. **Ver:** Lista de registros DNS actuales

### **PASO 3: Identificar y Eliminar Registros Maliciosos**

**🔍 BUSCAR Y ELIMINAR estos registros:**

```dns
❌ ELIMINAR SI EXISTE:
A     ftp              [cualquier IP]
CNAME ftp              [cualquier destino]
A     *                [wildcard malicioso]
CNAME *                [wildcard malicioso]
```

**📋 Proceso en Nominalia:**

1. **Revisar cada línea** de la tabla DNS
2. **Si ves `ftp` en el campo "Nombre" o "Subdominio":** → **ELIMINAR**
3. **Si ves `*` en el campo "Nombre":** → **ELIMINAR** (wildcard peligroso)
4. **Si ves registros raros que no reconoces:** → **ANOTAR y considerar eliminar**

### **PASO 4: Configuración DNS Correcta para GitHub Pages**

**✅ DEBE QUEDAR ASÍ:**

```dns
# Registros correctos para GitHub Pages:
Tipo    Nombre    Destino/Valor           TTL
----    ------    -------------           ---
A       @         185.199.108.153         3600
A       @         185.199.109.153         3600
A       @         185.199.110.153         3600
A       @         185.199.111.153         3600
CNAME   www       tuusuario.github.io     3600

# Opcional - Si tienes email:
MX      @         mail.tudominio.com      10

# Opcional - Verificaciones:
TXT     @         "verificacion-dominio"  3600
```

**🔄 REEMPLAZAR:**

- `tuusuario.github.io` → **tu usuario real de GitHub**
- `tudominio.com` → **guiasimo.com**

### **PASO 5: Interface Específica de Nominalia**

**En Nominalia probablemente verás algo así:**

```
┌─────────────────────────────────────────┐
│ GESTIÓN DNS - guiasimo.com              │
├─────────────────────────────────────────┤
│ Tipo │ Nombre │ Destino        │ Acción │
├─────────────────────────────────────────┤
│ A    │ @      │ 185.199.108.153│ [Edit] │
│ A    │ @      │ 185.199.109.153│ [Edit] │
│ A    │ www    │ 185.199.110.153│ [Edit] │
│ A    │ ftp    │ XXX.XXX.XXX.XXX│ [DEL]  │← ELIMINAR ESTE
│ CNAME│ www    │ usuario.github.io│[Edit] │
└─────────────────────────────────────────┘
```

**🎯 ELIMINAR:** Cualquier línea que tenga `ftp` en "Nombre"

### **PASO 6: Guardar y Verificar Cambios**

1. **💾 Guardar cambios** en Nominalia
2. **⏰ Esperar 5-10 minutos** (propagación DNS)
3. **🔍 Verificar** que el subdomain malicioso ya no funcione

## 📱 **VERIFICACIÓN INMEDIATA**

### **Comandos para verificar limpieza:**

```bash
# 1. Verificar que ftp.guiasimo.com ya no resuelve:
nslookup ftp.guiasimo.com

# 2. Verificar que tu sitio principal sigue funcionando:
nslookup guiasimo.com

# 3. Verificar que el contenido malicioso ya no está disponible:
curl -s http://ftp.guiasimo.com
# Debería dar error 404 o no conectar
```

### **Resultado esperado después de limpieza:**

```bash
# ✅ BUENO - ftp.guiasimo.com no debe resolver:
$ nslookup ftp.guiasimo.com
** server can't find ftp.guiasimo.com: NXDOMAIN

# ✅ BUENO - guiasimo.com debe seguir funcionando:
$ nslookup guiasimo.com
Name:    guiasimo.com
Address: 185.199.108.153
```

## 🔒 **MEDIDAS DE SEGURIDAD ADICIONALES EN NOMINALIA**

### **A. Revisar Configuraciones de Seguridad:**

1. **🔑 Cambiar contraseña de Nominalia:**

   - Panel → Cuenta → Cambiar contraseña
   - Usar contraseña fuerte única

2. **🛡️ Activar autenticación 2FA (si disponible):**

   - Panel → Seguridad → Autenticación en 2 pasos

3. **📧 Verificar email de contacto:**
   - Asegurar que solo tú tienes acceso al email asociado

### **B. Bloquear Modificaciones No Autorizadas:**

1. **🔒 Activar "Domain Lock" (si disponible):**

   - Previene transferencias no autorizadas del dominio

2. **📝 Revisar historial de cambios:**
   - Ver si hay modificaciones recientes sospechosas

## 📞 **¿PROBLEMAS CON NOMINALIA?**

### **Si no encuentras la gestión DNS:**

- **Buscar:** "Gestión avanzada", "DNS avanzado", "Configuración técnica"
- **Contactar soporte:** Nominalia tiene chat en vivo y teléfono

### **Si no puedes eliminar registros:**

- **Verificar permisos:** Asegurar que eres el titular del dominio
- **Contactar soporte:** Pueden ayudarte a limpiar DNS remotamente

### **Datos de contacto Nominalia:**

- **Teléfono:** +34 902 900 577
- **Chat:** Disponible en su web
- **Email:** soporte@nominalia.com

## 📊 **CRONOGRAMA DE LIMPIEZA**

```bash
⏰ TIEMPO ESTIMADO TOTAL: 15-30 minutos

Minutos 0-5:    Acceder a Nominalia y localizar DNS
Minutos 5-10:   Eliminar registros maliciosos
Minutos 10-15:  Guardar cambios
Minutos 15-30:  Esperar propagación DNS y verificar
```

## ✅ **CHECKLIST DE LIMPIEZA NOMINALIA**

```bash
ANTES DE EMPEZAR:
[ ] Tengo acceso a mi cuenta Nominalia
[ ] Sé cuál es mi usuario de GitHub Pages
[ ] Tengo los comandos de verificación listos

DURANTE LA LIMPIEZA:
[ ] Accedí al panel DNS de guiasimo.com
[ ] Eliminé registro A o CNAME de "ftp"
[ ] Eliminé cualquier wildcard "*"
[ ] Verifiqué que los registros principales estén correctos
[ ] Guardé los cambios

DESPUÉS DE LA LIMPIEZA:
[ ] ftp.guiasimo.com ya no resuelve (comando nslookup)
[ ] guiasimo.com sigue funcionando normalmente
[ ] El contenido malicioso ya no es accesible
[ ] Cambié la contraseña de Nominalia
```

## 🎉 **RESULTADO ESPERADO**

**Después de completar estos pasos:**

- ✅ `ftp.guiasimo.com` dejará de existir
- ✅ El contenido malicioso será inaccesible
- ✅ Tu sitio principal seguirá funcionando perfectamente
- ✅ Tu dominio estará limpio y seguro

---

**🔧 ESPECÍFICO PARA NOMINALIA - PASOS EXACTOS**  
**⏰ TIEMPO: 15-30 minutos máximo**  
**🎯 RESULTADO: DNS limpio y seguro**
