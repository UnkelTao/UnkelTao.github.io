---
layout: wiki
title: "Ruby"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

<div class="toc" markdown="1">

*   [Ruby](#toc1)
    *   [1. 问题杂记](#toc_1.1)
        *   [1.1. Windows编码问题](#toc_1.1.1)
        *   [1.2. Ruby 创建文件](#toc_1.1.2)


</div><div class="neirong" markdown="1">


<h2 id="toc1.1">1. 问题杂记</h2>
<h3 id="toc1.1.1">1.1. Windows编码问题</h3>

*   在linux上面写好的代码可能在windows上面却发挥产生奇怪的错误，尤其是编码错误。当使用cmd的时候为了防止出现:

```
Exception: invalid byte sequence in GB2312 in page
```

除了代码中设置好<code>utf-8</code>编码还应该在环境变量中设置下面两个参数：

```
#临时方法，在CMD中敲
set  LC_ALL=zh_CN.UTF-8 
set  LANG=zh_CN.UTF-8

#或者，在环境变量中添加这两个变量

LC_ALL=zh_CN.UTF-8 
LANG=zh_CN.UTF-8
```

<h3 id="toc1.1.2">1.2.  Ruby 创建文件</h3>

*   windows文件名中不允许有":","<",">"等字符，在特殊化命名，尤其是以时间命名的时候注意修改，而linux下则没有该问题，所以注意跨平台代码。