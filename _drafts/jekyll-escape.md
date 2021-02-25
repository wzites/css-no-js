---
layout: post
title: Jekyll's escape
---

It is very simple to escape Jekyll templating : 
use {%raw%}{%raw%}{%endraw%} and {{"{"}}%endraw{{"%"}}}

example: {% raw %}{%raw%}{{ assign string = "Jekyll's escape" }}{%endraw%{% endraw %}}

see the source code for this page @ <{{site.data.git-info.git_url}}/blob/master/{{page.path}}>
