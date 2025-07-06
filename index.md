---
layout: default
---

<h2 style="text-align:center;letter-spacing:1px;margin-top:2rem;">PRODUCTOS DESTACADOS</h2>
<div class="productos-destacados">
  {% for post in site.posts %}
    <div class="producto-card">
      {% if post.descuento %}<span class="descuento">-{{ post.descuento }}%</span>{% endif %}
      {% if post.imagen %}
        <img src="{{ post.imagen }}" alt="{{ post.title }}">
      {% else %}
        <img src="https://cdn-icons-png.flaticon.com/512/9402/9402212.png" alt="{{ post.title }}">
      {% endif %}
      <div class="nombre">{{ post.title }}</div>
      <div class="descripcion">{{ post.excerpt | strip_html | truncate: 80 }}</div>
      {% if post.precio %}
        <div class="precio">€ {{ post.precio }}</div>
      {% endif %}
      <a href="{{ post.url }}" style="display:inline-block;margin-top:0.7em;padding:0.4em 1.2em;background:#2b5876;color:#fff;border-radius:6px;text-decoration:none;font-weight:500;transition:background 0.2s;">Ver más</a>
    </div>
  {% endfor %}
</div>
