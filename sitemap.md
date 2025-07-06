---
layout: default
title: "Mapa del sitio"
permalink: /sitemap/
---

# 🗺️ Mapa del sitio

<ul>
  <li><a href="/">Inicio</a></li>
  <li><a href="/sitemap/">Mapa del sitio</a></li>
  {% for page in site.pages %}
    {% if page.title and page.url != "/sitemap/" and page.url != "/404.html" and page.sitemap != false %}
      <li><span style="color:#888;font-size:0.97em;">[Página]</span> <a href="{{ page.url }}">{{ page.title }}</a></li>
    {% endif %}
  {% endfor %}
  {% for post in site.posts %}
    {% if post.sitemap != false %}
      <li><span style="color:#2b5876;font-size:0.97em;">[Post]</span> <a href="{{ post.url }}">{{ post.card_title | default: post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

<p style="margin-top:2em;color:#888;font-size:0.98em;">¿No encuentras lo que buscas? Usa el buscador o revisa las categorías principales.</p>
