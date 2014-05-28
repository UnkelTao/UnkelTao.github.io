---
layout: post
title: "Latex 绘制跨页表格"
date: 2014-02-24 19:16:26 +0800
comments: true
categories: [latex]
description: "Latex 绘制跨页表格" 
keywords: Latex 
---

使用latex绘制表格或多或少都会遇到这样的问题，一个表格过长超过一页应该如何处理，latex提供了一些宏包，如longtable和supertabular;这里介绍如何用supertabular绘制跨页表格。
<!--more-->
##标题命令

``` latex 宏包相关命令
\bottomcaption[目录标题]{表格标题}  
	 底部标题命令，指定在表格的下方生成表格标题。	
\tablecaption[目录标题]{表格标题}  
	 表格标题命令，生成在上方，作用于\caption类似	
\tablefirsthead{首页列标题}  
	 用于设置第一页表格的各列标题 	
\tablehead{续页列标题}  
	 用于设置续页列标题，可以含有多个表格行 	
\tablelasttail{结束表示}  
	 用于表格结束时候显示的标示。 	
\tabletail{分页标识}  
	 用于设置分页前，所显示的分页标识，如"接下页"。	
\topcaption[目录标题]{表格标题}  
	 顶部标题设置，指定表格上方生成表格标题。 	
```


再和其他一些宏包使用，便可以轻松的画出表格了。  

##参考样例

```latex 宏包
%涉及宏包
\usepackage{supertabular} %supertabular表格宏包
\usepackage{colortbl} %彩色表格宏包
\usepackage{booktabs} %表格线宏包
```

###参考代码

```latex
%跨页表格
\begin{center} \tablecaption{Linux 系统中的目录 \label{tab:super}}
\tablefirsthead{
\rowcolor[gray]{0.8}
\multicolumn{1}{l}{\textbf{目录}} & 
\multicolumn{1}{c}{\textbf{注解}} \\ }
\tablehead{\multicolumn{2}{c}{
\small 表 \ref{tab:super} (续) } \\
\rowcolor[gray]{0.8}
\multicolumn{1}{l}{\textbf{目录}} & 
\multicolumn{1}{c}{\textbf{注解}} \\}
\tabletail{\bottomrule
\multicolumn{2}{c}{\small 接下页} \\}
\tablelasttail{\bottomrule}

\begin{supertabular}{p{2.cm}p{13cm}}

/	& 根目录，万物起源。\\
\midrule
/bin & 包含系统启动和运行所必须的二进制程序。\\
% 以下都是类似行数据，故省略

\end{supertabular}
\end{center}
```

###效果图

(太长，缩小看整体效果)  

![](http://unkeltao.qiniudn.com/img/001.png) 

(标题)  

![](http://unkeltao.qiniudn.com/img/002.png) 

(跨页表示)  

![](http://unkeltao.qiniudn.com/img/003.png) 

(续页标题)  

![](http://unkeltao.qiniudn.com/img/004.png)



