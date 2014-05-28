---
layout: post
title: "Linux 下安装 Tmux"
date: 2014-04-29 23:29:54 +0800
comments: true
categories: [tmux]
description: "RedHat 安装Tmux软件" 
keywords: linux,ubuntu,archlinux,redhat,tmux
---

Tmux(terminal multiplexer), 远程必备的终端复用软件。  

##安装  

###ubuntu
用了很长一段时间的Ubuntu,绝大部分原因是其强大的软件源。  

> 安装命令  
> sudo apt-get install tmux  
> d  

###Archlinux
前一段时间切换到了archlinux下面。 arch里面也有类似于apt-get的。它就是pacman,所以安装仍然很简单。  

> \#安装命令    
> pacman -S tmux  

###RedHat
实验室服务器使用的是Redhat,最近需要在服务器做实验，而服务器上是没有图形界面的，为了保护我的终端现场，这就更得使用Tmux了。 服务器没有外网(似乎有(O.O))。所以采用源码安装的形式。  
<!-- more -->

*	首先从**[官网](http://tmux.sourceforge.net/)**上下载tmux和libevent(因为tmux源码安装依赖于libevent,不安装make会报错)  
*	安装libevent.    

```
tar zxvf libevent-2.0.21-stable.tar.gz  #解压  
cd libevent-2.0.21-stable  
./configure --prefix=你的安装目录  #如 /etc/pro/libevent2  
make  
make install
```

*	安装tmux.   

```
tar zxvf tmux-1.9a.tar.gz
cd tmux-1.9a.tar.gz
CFLAGS="-I libevent安装目录/include" LDFLAGS="-L/usr/local/libevent安装目录/lib" ./configure --prefix=tmux安装目录
#eg:  CFLAGS="-I/usr/pro/libevent2/include" LDFLAGS="-L/usr/pro/libevent2/lib" ./configure --prefix=/usr/pro/tmux
make
make install
```

*	链接.so  

```
#32位
sudo cp /usr/pro/libevent2/lib/libevent-2.0.so.5 /usr/lib
#64位
sudo cp /usr/pro/libevent2/lib/libevent-2.0.so.5 /usr/lib64
```

*	将tmux安装目录加入到环境变量PATH中  

```
vim /etc/profile
```

> export TMUX_HOME=/usr/pro/tmux  
> export PATH=$TMUX_HOME/bin:$PATH  


```
source /etc/profile
```

这样便可以使用了。

##简单配置
配置文件在 ~/.tmux.conf 下，没有可以新建一个。  
因为tmux的prefix键默认为"Ctrl+b",但是他们隔得有点远，所以修改为"Ctrl+a"。  

> \# remap prefix to Control + a   
> set -g prefix C-a  
> unbind C-b  
> bind C-a send-prefix  


##使用
[使用tmux——freebsdchina](https://wiki.freebsdchina.org/software/t/tmux)  







