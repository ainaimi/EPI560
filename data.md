---
layout: page
title: Data
permalink: /data/
---

Clicking the title of the data link will open a placeholder pdf.

<i class="fab fa-github"></i> = Github directory for dataset;

{% assign num = site.url | size | minus: 1 %}

<ul id="archive">
{% for data in site.data.data %}
      <li class="archiveposturl">
        <span><a href="{{ site.url | slice: 0, num}}{{ site.baseurl }}/data/{{ data.dirname }}/{{ data.filename }}.pdf" target="_blank">{{ data.title }}</a></span><br>
<span class = "postlower">
<strong>due date:</strong> {{ data.due }}</span>
<strong style="font-size:100%; font-family: 'DM Sans', sans-serif; float:right; padding-right: .5em">
	<a href="https://github.com/{{ site.githubdir}}/tree/master/data/{{ data.dirname }}"><i class="fab fa-github"></i></a>&nbsp;&nbsp;
	<a href="https://github.com/{{ site.githubdir}}/tree/master/data/{{ data.dirname }}/{{ data.filename}}.Rmd"><i class="fab fa-r-project"></i></a>&nbsp;&nbsp;
	<a href="{{ data.submit }}"><i class="fas fa-share-square"></i></a>
</strong>
      </li>
{% endfor %}
</ul>
