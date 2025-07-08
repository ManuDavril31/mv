---
layout: default
---

<!-- Hero Section -->
<section class="hero-section">
  <div class="hero-content">
    <h2 class="hero-title">Encuentra Todo lo que Necesitas</h2>
    <p class="hero-subtitle">Productos y servicios de calidad en Montería. Compra y vende con confianza.</p>
    <div class="hero-buttons">
      <a href="#productos" class="btn-primary">Ver Productos</a>
      <a href="#contacto" class="btn-secondary">Contactar</a>
    </div>
  </div>
  <div class="hero-stats">
    <div class="stat-item">
      <span class="stat-number">{{ site.posts.size }}+</span>
      <span class="stat-label">Productos</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">100%</span>
      <span class="stat-label">Confiable</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">24/7</span>
      <span class="stat-label">Disponible</span>
    </div>
  </div>
</section>

<!-- Productos Destacados -->
<section id="productos" class="productos-section">
  <div class="section-header">
    <h2 class="section-title">PRODUCTOS DESTACADOS</h2>
    <p class="section-subtitle">Descubre nuestros productos más populares y servicios destacados</p>
  </div>
  
  <div class="productos-destacados">
    {% for post in site.posts limit: 6 %}
      <div class="producto-card">
        {% if post.descuento %}<span class="descuento">-{{ post.descuento }}%</span>{% endif %}
        {% if post.precio %}
          <span class="producto-precio-label">{{ post.precio | prepend: '$ ' | replace: '.00', '' }}</span>
        {% endif %}
        
        <div class="producto-image">
          {% if post.card_image %}
            <img src="{{ post.card_image }}" alt="{{ post.title }}" loading="lazy">
          {% elsif post.imagen %}
            <img src="{{ post.imagen }}" alt="{{ post.title }}" loading="lazy">
          {% else %}
            <img src="https://cdn-icons-png.flaticon.com/512/9402/9402212.png" alt="{{ post.title }}" loading="lazy">
          {% endif %}
        </div>
        
        <div class="producto-info">
          <div class="nombre">{{ post.card_title | default: post.title }}</div>
          <div class="descripcion">{{ post.card_description | default: post.excerpt | strip_html | truncate: 80 }}</div>
          
          {% if post.categories and post.categories.size > 0 %}
            <div class="producto-categoria">
              <span class="categoria-tag">{{ post.categories[0] | capitalize }}</span>
            </div>
          {% endif %}
          
          <a href="{{ post.url }}" class="btn-ver-mas">
            <span>Ver más</span>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M7 17l10-10M17 7H7v10"/>
            </svg>
          </a>
        </div>
      </div>
    {% endfor %}
  </div>
  
  {% if site.posts.size > 6 %}
    <div class="ver-todos-container">
      <a href="/todos-los-productos/" class="btn-ver-todos">Ver Todos los Productos</a>
    </div>
  {% endif %}
</section>

<!-- Sección de Servicios -->
<section class="servicios-section">
  <div class="section-header">
    <h2 class="section-title">¿Por Qué Elegirnos?</h2>
    <p class="section-subtitle">Ofrecemos la mejor experiencia de compra y venta en Montería</p>
  </div>
  
  <div class="servicios-grid">
    <div class="servicio-item">
      <div class="servicio-icon">🛡️</div>
      <h3>Confianza Total</h3>
      <p>Productos verificados y vendedores de confianza para tu tranquilidad</p>
    </div>
    
    <div class="servicio-item">
      <div class="servicio-icon">🚀</div>
      <h3>Entrega Rápida</h3>
      <p>Coordinamos entregas rápidas y seguras en toda la ciudad</p>
    </div>
    
    <div class="servicio-item">
      <div class="servicio-icon">💬</div>
      <h3>Soporte 24/7</h3>
      <p>Estamos aquí para ayudarte en cualquier momento que nos necesites</p>
    </div>
    
    <div class="servicio-item">
      <div class="servicio-icon">💰</div>
      <h3>Mejores Precios</h3>
      <p>Encuentra los precios más competitivos del mercado local</p>
    </div>
  </div>
</section>

<!-- Contacto -->
<section id="contacto" class="contacto-section">
  <div class="section-header">
    <h2 class="section-title">¿Tienes Algo que Vender?</h2>
    <p class="section-subtitle">Publica tus productos y llega a más clientes en Montería</p>
  </div>
  
  <div class="contacto-content">
    <div class="contacto-info">
      <h3>Contacta con Nosotros</h3>
      <div class="contacto-metodos">
        <div class="contacto-metodo">
          <span class="contacto-icon">📱</span>
          <div>
            <strong>WhatsApp</strong>
            <p>+57 300 123 4567</p>
          </div>
        </div>
        
        <div class="contacto-metodo">
          <span class="contacto-icon">📧</span>
          <div>
            <strong>Email</strong>
            <p>info@monteriavende.com</p>
          </div>
        </div>
        
        <div class="contacto-metodo">
          <span class="contacto-icon">📍</span>
          <div>
            <strong>Ubicación</strong>
            <p>Montería, Córdoba</p>
          </div>
        </div>
      </div>
    </div>
    
    <div class="cta-vender">
      <h3>¡Vende con Nosotros!</h3>
      <p>Únete a nuestra plataforma y comienza a vender tus productos hoy mismo</p>
      <a href="https://wa.me/573001234567?text=Hola,%20quiero%20vender%20mis%20productos%20en%20MonteriaVende" class="btn-whatsapp" target="_blank">
        <span>Vender en WhatsApp</span>
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.488"/>
        </svg>
      </a>
    </div>
  </div>
</section>
