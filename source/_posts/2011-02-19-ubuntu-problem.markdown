---
layout: post
title: "Ubuntu problem"
date: 2011-02-19 00:00:07 +0800
comments: true
categories: [Ubuntu]
description: "Ubuntu problem" 
keywords: Ubuntu 
---

问题：

![](http://unkeltao.qiniudn.com/IMG_002.jpg)
![](http://unkeltao.qiniudn.com/IMG_003.jpg)

解决代码：
法1：

```sh 
sudo apt-get install dkms build-essential linux-headers-$(uname -r) 
sudo /etc/init.d/vboxdrv setup
```

法2：
```sh     
sudo apt-get install module-assistant
sudo modprobe vboxnetflt
sudo modprobe vboxdrv
```