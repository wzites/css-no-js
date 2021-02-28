---
layout: page
base: '../'
---
# site map

## CARDs
{% for card in site.cards %}
### {{card.slug | replace: '-',' ' | capitalize}}
- title: {{ card.title }}
- url: [{{ card.url }}]({{card.url | replace_first: '/', page.base}})
- slug: {{card.slug}}
- date: {{card.date}}
- excerpt: <i>{{ card.excerpt | strip_html | strip_newlines }}</i>

{% endfor %}

## GIT
{% for git in site.data.git-events %}{% if git.actor.login == 'Reuf12' %}{% continue %}{% endif %}
{{forloop.index}}. {{git.type| capitalize }}: [{{git.repo.name}}]({{git.repo.url}})
  {% if git.payload.commits[-1].message %}{{git.payload.commits[-1].message | truncate: 64 }}{% endif %} [@{{git.actor.display_login}}]({{git.actor.url | replace: 'api.','' | replace: '/users',''}}) ({{git.payload.head | truncate: 8 | default: git.id }}) &ndash; {{git.created_at| date_to_rfc822}}{% endfor %}

<!-- {{site.data.git-events | jsonify}} -->

## POSTs
{% for post in site.posts %}
### {{post.slug | replace: '-',' ' | capitalize}}
- title: {{ post.title }}
- url: [{{ post.url }}]({{post.url | replace_first: '/', page.base}})
- slug: {{post.slug}}
- date: {{post.date}}
- excerpt: <i>{{ post.excerpt | strip_html | strip_newlines }}</i>

{% endfor %}

## ADs
{% for post in site.ads %}
### {{post.slug | replace: '-',' ' | capitalize}}
- title: {{ post.title }}
- url: [{{ post.url }}]({{post.url | replace_first: '/', page.base}})
- slug: {{post.slug}}
- date: {{post.date}}
- excerpt: _{{ post.excerpt | strip_html }}_

{% endfor %}
