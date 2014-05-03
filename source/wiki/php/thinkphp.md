---
layout: wiki
title: "Think PHP"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

*   [Think PHP](#toc1)
    *   [1. 常量](#toc_1.1)
    *	[2. 字段隐藏，模型映射](#toc_1.2)


</div>
<div class="neirong">


<h2 id="toc_1.1">1. 常量</h2>

*	在config.php中 

```
‘URL_PATHINFO_DEPR’    //路由分隔符。默认为/
'TMPL_L_DELIM'                   //左定界符
'TMPL_R_DELIM'                 //右定界符
```

<h2 id="toc_1.1">2. 字段隐藏，模型映射</h2>

*	ThinkPHP的字段映射功能可以让你在表单中隐藏真正的数据表字段，而不用担心放弃自动创建表单对象的功能，假设我们的User表里面有username和email字段，我们需要映射成另外的字段，定义方式如下：  

```
Class UserModel extends Model{
    protected $_map = array(
        'name' =>'username', // 把表单中name映射到数据表的username字段
        'mail'  =>'email', // 把表单中的mail映射到数据表的email字段
    );
}
```

