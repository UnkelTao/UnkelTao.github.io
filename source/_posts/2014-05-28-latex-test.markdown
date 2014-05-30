---
layout: post
title: "octopress 支持Latex"
date: 2014-05-28 09:39:57 +0100
comments: true
latex: true
categories: 
---


将MarkDown解析器切换成kramdown后加上简单的配置。   
[octopress添加LaTeX公式支持参考](http://blog.csdn.net/hankai1024/article/details/18048999)

这样便可以使用$\Latex$公式了。  
下面便是用Latex书写的公式

<!-- more -->

$$
\left\{
	\begin{array}{l@{}r}
	F[1][1] = a & \\
	F[1][2] = b & \\
	F[i][j] = 1 * F[i][j-2] + 2 * F[i][j-1] + 3 & 2 < j \leq m \\
	F[i][1] = 4 * F[i-1][m-1] + 5 * F[i-1][m] + 6 &  i \neq 1 \\
	F[i][2] = 7 * F[i-1][m-1] + 8 * F[i][1] + 9 & i \neq 1
	\end{array}
	\right.
$$


公式代码:

```
$$
\left\{
	\begin{array}{l@{}r}
	F[1][1] = a & \\
	F[1][2] = b & \\
	F[i][j] = 1 * F[i][j-2] + 2 * F[i][j-1] + 3 & 2 < j \leq m \\
	F[i][1] = 4 * F[i-1][m-1] + 5 * F[i-1][m] + 6 &  i \neq 1 \\
	F[i][2] = 7 * F[i-1][m-1] + 8 * F[i][1] + 9 & i \neq 1
	\end{array}
	\right.
$$
```

**kramdown不仅能够支持Latex公式，而且可以画表格**

| First cell|Second cell|Third cell
| First | Second | Third |
| First | Second | Fourth |

表格代码:

```
| First cell|Second cell|Third cell
| First | Second | Third |
| First | Second | Fourth |
```

##kramdown的拓展功能还有许多
[拓展阅读](http://kramdown.gettalong.org/syntax.html)

需要注意的是kramdown解析方式跟原来的rdiscount相比更为严格，比如代码段前必须一个空行，所以需要检查之前的Markdown

