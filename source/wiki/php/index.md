---
layout: wiki
title: "PHP"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

<div class="toc" markdown="1">

*   [PHP](#toc1)
    *   [1. 语法](#toc_1.1)
    	*	[   include 与 require](#toc_1.1.1)
    *	[2. 错误](#toc_1.2)
    	*	[   undefined function imagecreate](#toc_1.2.1)
    *	[3. 框架](#toc_1.3)
    	*	[Think PHP](#toc_1.3.1)

</div><div class="neirong" markdown="1">


<h2 id="toc_1.1">1. 语法</h2>
<h3 id="toc_1.1.1"> include 与 require</h3>

*	require更加严谨，一旦出错不再往下执行


<h2 id="toc_1.2">2. 错误</h2>
<h3 id="toc_1.2.1">  undefined function imagecreate</h3>

*	错误：<code>Call to undefined function imagecreate() </code>   
	原因：未开启或者未安装GD库~   
    解决方法:  php5可以直接开启gd库，到php.in中开启。  

<h2 id="toc_1.3">3. 框架</h2>
<h3 id="toc_1.3.1">3.1 Think PHP</h3>

*	[Think PHP](./thinkphp.html)

