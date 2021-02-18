---
title: imagine

layout: page
order: "01"
base: '../'
hero:
  content: |-
    Imagine technology that works,
    Imaging using it as easy as walking...
    
    Imagine a technology in harmony with you, nature and the planet.

preview-img: img/i-imagine.svg
teaser-img: img/i-imagine.svg
 
---
{% assign baseurl = site.baseurl | default: '/' | replace_first: '/', page.base %}
<!-- baseurl: {{baseurl}} -->
<img src="{{baseurl}}{{page.preview-img}}" alt={{page.slug}} style="max-width: 40%; float: right; padding: 0.8rem;">


### Imagine ...

Well reality is often different, unless
you have someone to maintain it and it run smooth,
That exactly the [services][1] Dr I&#183;T is offering.

We believe we don't have to burn fossil nor be wasteful or palluting
We will select the most eco-friendly technolgies known to date to run your business:

We choose [eco-organic technologies][2]

[1]: {{baseurl}}products/
[2]: {{baseurl}}cards/eco-organic-technologies/


<pre>{{page | strip_html | strip_newlines | jsonify | truncate: 78,'...' }}</pre>

