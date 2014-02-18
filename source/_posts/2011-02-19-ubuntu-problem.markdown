---
layout: post
title: "Ubuntu problem"
date: 2011-02-19 00:00:07 +0800
comments: true
categories: [Ubuntu]
---

问题：

![](http://d.pcs.baidu.com/thumbnail/7d035361bbf02d85d862a84985d594da?fid=101724653-250528-1662718638&time=1392729334&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-DtygEbw%2Bh4AN0AwdIGRv9Zydyqc%3D&expires=8h&prisign=RK9dhfZlTqV5TuwkO5ihMQzlM241kT2YfffnCZFTaEPwOxHv/XxtwRXLxDSXMBba1Ms9seOiqT9/QffwI8K2Baw0mmLABRQNl51b/oS8+InqoadADmwcyikKawH2SpzFmVrGREiaH1zZ09BZiFo3CF7dwGcK/xIzj9971pKao/QALkDxW+JJC9zJS3FHk0o7boWsiiwPAK5reKjnULC44sCCTNu35NkJ&r=276187455&size=c850_u580&quality=100)

![](http://d.pcs.baidu.com/thumbnail/8d0133f3f0ba1407dc893c36a21526bf?fid=101724653-250528-1716450544&time=1392729334&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-DIEnFY3z3zMHbQMpJSui0w7fCXM%3D&expires=8h&prisign=RK9dhfZlTqV5TuwkO5ihMQzlM241kT2YfffnCZFTaEPwOxHv/XxtwRXLxDSXMBba1Ms9seOiqT9/QffwI8K2Baw0mmLABRQNl51b/oS8+InqoadADmwcyikKawH2SpzFmVrGREiaH1zZ09BZiFo3CF7dwGcK/xIzj9971pKao/QALkDxW+JJC9zJS3FHk0o7boWsiiwPAK5reKjnULC44sCCTNu35NkJ&r=735911543&size=c850_u580&quality=100)

解决代码：

法1：
```
sudo apt-get install dkms build-essential linux-headers-$(uname -r) 
sudo /etc/init.d/vboxdrv setup
```

法2：
```
sudo apt-get install module-assistant
sudo modprobe vboxnetflt
sudo modprobe vboxdrv
```