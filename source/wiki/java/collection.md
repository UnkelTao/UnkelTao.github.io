---
layout: wiki
title: "集合"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

<div class="toc" markdown="1">

*   [集合](#toc1)
    *   [1. Set 与 List](#toc_1.1)
    *	[2. 常用的List？](#toc_1.2)
    *	[3. ArrayList与Vector](#toc_1.3)
    *	[4. HashMap 与 HashTable](#TOC_1.4)

</div><div class="neirong" markdown="1">



<h2 id="toc_1.1">1. Set 与 List 的区别?</h2>

*	都是Collection接口的子接口。
*	Set是不重复的集合类，Set中的元素都是唯一的。但是Set中的元素是无序的，不能通过下标访问。
*	List中的元素是可以重复的，同时也是有序的。


<h2 id="toc_1.2">2. 常用的List?</h2>

*	ArrayList，LinkedList，Vector，Stack
*	ArrayList底层是数组实现的，是一个动态数组，随机访问快。
*	LinkedList底层是链表，插入删除较快。

<h2 id="toc_1.3">3. ArrayList与Vector区别?</h2>


*	基本相同，都是List的实现类。底层都是动态数组。
*	其中Vector是线程同步的，ArrayList默认不是线程同步的。
*	让Array线程同步。
*	List list = Collection.synchronizedList(new ArrayList(...));  //线程同步，也就是一个时刻只有一个线程去访问。

<h2 id="toc_1.1">4.HashMap 与 HashTable的区别?</h2>

*	都是Map接口的实现类
*	HashTable线程同步，HashMap不是线程同步。
	*	让HashMap线程同步方法：

```
Map m = Collection.synchronizedMap(new HashMap(...));
```

*	HashTable 的key和value都不允许为空。


