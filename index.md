---
layout: default
---

<h2 style="text-align:center;letter-spacing:1px;margin-top:2rem;">PRODUCTOS DESTACADOS</h2>
<div class="productos-destacados">
  {% for post in site.posts %}
    <div class="producto-card">
      {% if post.descuento %}<span class="descuento">-{{ post.descuento }}%</span>{% endif %}
      {% if post.precio %}
        <span class="producto-precio-label">{{ post.precio | prepend: '$ ' | replace: '.00', '' }}</span>
      {% endif %}
      {% if post.card_image %}
        <img src="{{ post.card_image }}" alt="{{ post.title }}">
      {% elsif post.imagen %}
        <img src="{{ post.imagen }}" alt="{{ post.title }}">
      {% else %}
        <img src="https://cdn-icons-png.flaticon.com/512/9402/9402212.png" alt="{{ post.title }}">
      {% endif %}
      <div class="nombre">{{ post.card_title | default: post.title }}</div>
      <div class="descripcion">{{ post.card_description | default: post.excerpt | strip_html | truncate: 80 }}</div>
      <a href="{{ post.url }}" style="display:inline-block;margin-top:0.7em;padding:0.4em 1.2em;background:#2b5876;color:#fff;border-radius:6px;text-decoration:none;font-weight:500;transition:background 0.2s;">Ver más</a>
    </div>
  {% endfor %}
</div>
