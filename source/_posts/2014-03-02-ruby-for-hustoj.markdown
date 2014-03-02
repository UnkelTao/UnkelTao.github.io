---
layout: post
title: "为Hustoj添加ruby支持"
date: 2014-03-02 22:33:16 +0800
comments: true
categories: [ACM,Ruby]
---


虽然已经不是再搞ACM了，但是算法偶尔还是要练习一下写代码，然后最近学习ruby中，打算用ruby来写写ACM题目也算熟悉ruby，免得不用就忘记了，记得Hustoj是可以支持Ruby的，于是就在我们学校的训练Oj上提交了A+B的Ruby代码：
```ruby
readlines.each{|line|
	p line.split.collect{|x| x.to_i}.inject{|y, x| y += x}
}
```
于是华丽的给了我一个WA~~~正在想怎么可能，想起来服务器上没有装ruby，于是远程到7509的服务器上再ssh到训练oj的服务器(只能内网访问，ping不到外网地址)，将ruby装上。

然后就开始了无止境的RE生涯，简直无情，各种call禁止：
<!--more-->
![](http://unkeltao.qiniudn.com/img/IMG_ruby_1.png)

在hustoj的wiki页面上，终于找到了参考的添加其他[语言支持的方法](http://code.google.com/p/hustoj/wiki/AddProgrammingLanguage)

其实主要的就是找到所有的call编号，放到数组里面去就行了，ruby对应了两个数组

```rb
#保存为Main.rb
readlines.each{|line|
	p line.split.collect{|x| x.to_i}.inject{|y, x| y += x}
```

terminal中运行如下命令。


```sh
strace -ff ruby Main.rb 2>&1|awk -F\( '{print $1}'|sort -u
```

然后会产生,以access开头，write结束（也有可能是其他）的一些列标志如下：

```
access
xxx
xxx
write
```

把这些标志放入如下过程，结尾是0，对应RC数组其他值为-1，结尾为0.
```c++
int LANG_RV[256]={SYS_access,SYS_write.....,0};
int LANG_RC[256]={-1,-1,......,0};
```

改好之后切换到对应目录下，重新make

```sh
cd ~/hustoj-read-only/core/
./make.sh
```

接下来就是体力活了，找到提交的runid，rejudge下，看看是不是AC了，可能还会接着RE，如果RE，就将新的callid(是一个数字)加入到数组中，也就是RV数组中，RC数组值为-1就行：

```sh
sudo judge_client 2028 0 /home/judge/ debug Y
```

直到返回值不是10，然后再去页面提交，这下应该就可以了~~~（当然我中间还做了一堆傻事，这儿就不提了）
偶尔可以在训练oj上做做练习了，免得以后笔试说不定都跪。

最终结果：
![](http://unkeltao.qiniudn.com/img/IMG_ruby_2.png)



