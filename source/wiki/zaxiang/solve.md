---
layout: wiki
title: "问题解决方案"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

*   [问题解决方案](#toc1)
    *   [1. windows](#toc_1.1)
    	*	[1.1. 无法访问自定义操作的vbscript运行时间](#toc_1.1.1)
    	*	[1.2. 递归删除目录下的exe](#toc_1.1.2)
* * *

</div>
<div class="neirong">

<h2 id="toc_1.1">1. windows</h2>
<h3 id="toc_1.1.1">1.1. 无法访问自定义操作的vbscript运行时间</h3>

*	问题描述：
```
无法访问自定义操作的vbscript运行时间
Could not access VBScript run time for custom action.
```

*	解决方案:
	*	64-bit
```
reg delete "HKCU\SOFTWARE\Classes\Wow6432Node\CLSID\\{B54F3741-5B07-11CF-A4B0-00AA004A55E8}" /f
c:\windows\syswow64\regsvr32 vbscript.dll
```
	*	32-bit
```
reg delete "HKCU\SOFTWARE\Classes\CLSID\\{B54F3741-5B07-11CF-A4B0-00AA004A55E8}" /f
c:\windows\system32\regsvr32 vbscript.dll	
```

<h3 id="toc_1.1.2">1.2. 递归删除目录下的exe文件</h3>

*	sh
```
ls | xargs -i% find %  -name '*.exe' -type f -print0 | xargs -0 rm -rf
```
