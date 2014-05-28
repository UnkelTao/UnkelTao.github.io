---
layout: wiki
title: "问题解决方案"
date: 2014-02-24 19:16:26 +0800
keywords: wiki,markown

---

<div class="toc" markdown="1">

*   [问题解决方案](#toc1)
    *   [1. windows](#toc_1.1)
    	*	[1.1. 无法访问自定义操作的vbscript运行时间](#toc_1.1.1)
    	*	[1.2. 递归删除目录下的exe](#toc_1.1.2)
	*	[2. cygwin](#toc_1.2)
		*	[2.1. rake等命令无法执行](#toc_1.2.1)

</div><div class="neirong" markdown="1">


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

<h2 id="toc_1.2">2. cygwin</h2>
<h3 id="toc_1.2.1">2.1. rake等命令无法执行</h3>

*	问题描述   

> rake generate  
> C:\Myprogram\huanjing\ruby\Ruby200-x64\bin\ruby.exe: No such file or directory -- /cygdrive/c/Myprogram/huanjing/ruby/Ruby200-x64/bin/rake (LoadError)    

*	原因  

> 环境变量下面含有Linux下的程序，Cygwin优先执行该程序，所以没法运行。  

*	解决方案  

> 配置环境变量，将相关的命令别名成.bat  
> alias gem='gem.bat'  
> alias rake='rake.bat'  
> alias erb='erb.bat'  
> alias irb='irb.bat'  
> alias rdoc='rdoc.bat'  
> alias ri='ri.bat'  
> alias rspec='rspec.bat'  
> alias cucumber='cucumber.bat'  
> alias bundle='bundle.bat'   

<h3 id="toc_1.2.1">2.2. clear请屏问题</h3>

*	解决方案   

> 1) ctrl + l  
> 2) 如上面方法，修改.bashrc 添加 alias cls='echo -e "\E[2J"'    
> 3) 在cygwind中install ncurses (in Utils) (PS: 未测试,Ctrl+L比较好使)  
