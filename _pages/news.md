---
author: "Michel C."
layout: page
order: "04"
base: "../"
featured: health
---
{% assign baseurl = site.baseurl | default: '/' | replace_first: '/', page.base %}

# News and Updates

<!--
post: {{site.posts | jsonify | truncate: 78,'...' }}
-->

We are launching [Dr. I·T][1] for making all your [repairs]({{baseurl}}{% post_url 2021-02-25-7Rs %}).


[1]: http://duckduckgo.com/?q=%22Dr+I%C2%B7T%22+!g




{% for post in site.posts %}{% assign len = post.url|size %}
{%- unless page.draft -%}
{%- assign name = post.author.name | default: 'anonymous' -%}
{% assign default_author_url = 'https://google.com/search?q=' | append: name | append: ',+' | append: post.slug | replace: ' ','+' %}
- #### [{{post.title}}]({{post.url | relative_url | replace_first: '/',baseurl}}) ~ {{post.date | limit: 2}} by [{{post.author.name | default: 'anonymoous'}}]({{post.author.url | default: default_author_url}})
   {{ post.content | strip_newlines | strip_html | truncatewords: 120 }}
   <br>{{modified_time}}
{%- endunless -%}
{% endfor %}
<hr>

<pre>{{page | strip_html | normalize_whitespaces |strip_newlines | truncate: 78,'...' }} %}</pre>
