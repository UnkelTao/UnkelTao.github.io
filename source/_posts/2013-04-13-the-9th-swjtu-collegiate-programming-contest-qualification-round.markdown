---
layout: post
title: "The 9th SWJTU Collegiate Programming Contest Qualification Round"
date: 2013-04-13 22:16:28| +0800
comments: true
categories: [ACM,Cpp]
description: "The 9th SWJTU Collegiate Programming Contest Qualification Round" 
keywords: ACM,C++
---

**比赛链接：**  [第九届ACM校赛资格赛](http://acm.swjtu.edu.cn/JudgeOnline/showcontest?contest_id=1135 "第九届ACM校赛资格赛")  

资格赛嘛，本着大家熟悉环境增强自信心的原则~10道题没有太难的题目~适合新手练习.本次比赛D、E、F是我出的，本着简单的想法却没想到坑了一部分人，其中E题的数据再随机的时候超出了题目描述的范围造成一些人AC的程序WA了，在此表示抱歉,致以诚挚的歉意。下面给出我对着10道题的解法，可能我的解法并不是完全正确恰好过了数据而已，欢迎大家指正。

<!--more-->
##A [A+B](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1982)
完全熟悉OJ环境的题目,上面都有标程,第一次接触ACM的需要知道怎么多组输入.

```c++ 
int a, b; 
while(scanf("%d %d", &a, &b)==2){
    printf("%d\n", a + b);
}
```

##B [猴子爬楼梯1](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1986)
因为数据不大，可以有3中解法:  

*	原理：看 n能被被整除<code>GCD(a,b)</code>整除，推论过程略,详见大牛([大牛题解](http://blog.csdn.net/openspirit/article/details/8797246))。	

* 	模拟法：我们可以确定只要大于 <code>a+b-1</code>的数 我们都可以通过加上a来得到,在+a ,-b的过程中，通过模拟产生出<code>(1，a+b-1)</code>所有的可能,把n对a取模既可以。	

*	搜索或者暴力,记忆化搜索，也就1000个点而已,代码未写,参见C题。	

```c++ 
//模拟法
int s[10000];
int cnt(int a,int b)
{
    int tmp=a,cur=0;
    memset(s,0,sizeof(s));
    while(tmp!=0)
    {
        s[cur++]=tmp;         
        if(tmp>=b)tmp-=b;
        else tmp+=a;           
    } 
    return cur;
}
```

##C [猴子爬楼梯2](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1990)

**本题将我深深的伤害了**  

*	模拟法:看着数据不大，于是暴力模拟,无限WA,基本思路同B题二解法，只是模拟过程中出现大于top就停止,至今未AC，未发现错误数据，回头对拍,有待考证。(**忘记加特判了<code>a=0,b=0</code>时候挂掉了, 加上AC**)	

*	记忆化搜索	

```c++ 
//模拟法
#include<cstdio>
#define rep(i,a,n) for (int i=(a); i<(n); ++i)
int gcd(int a,int b){return b?gcd(b,a%b):a;}
int s[1000];
int cnt(int a,int b)
{
    int tmp=a,cur=0;
    if(b==0){s[0]=a; return 1;}
    while(tmp!=0){s[cur++]=tmp;if(tmp>=b)tmp-=b;else tmp+=a;} 
    return cur;
}
int main()
{
    //freopen("data.in","r",stdin);
    //freopen("data2.out","w",stdout);
    int T,a,b,n,m;
    scanf("%d",&T);
    while(T--){
       scanf("%d%d%d%d",&a,&b,&n,&m);
       if(n>m||a==0) printf("NO\n");
       else {
          if(n%a==0) printf("YES\n");
          else {  
               int len=cnt(a,b);
               n=n%a; 
               bool fg=0;
               rep(i,0,len){
                  if(s[i]==n) {fg=1;break;}
                  if(s[i]>m){fg=0;break;}
               }
               if(fg)printf("YES\n");else printf("NO\n");  
          
          }
       }
    }
    return 0;
}
```

```c++
//记忆化搜索
bool used[1100];
bool bfs(int a,int b,int n,int m)
{
    queue<int> q;
    memset(used,0,sizeof(used));
    if(a>m) return 0;
    q.push(a);
    used[a]=1;
    int t;
    while(!q.empty())
    {
       int tmp=q.front(); q.pop();
       used[tmp]=1;
       if(tmp==n) return 1;
       if(tmp+a<=m&&!used[tmp+a]){used[tmp+a]=1; q.push(tmp+a);}
       if(tmp-b>=0&&!used[tmp-b]){used[tmp-b]=1; q.push(tmp-b);}           
    }
    return 0;
}
```

##D [统计学号](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1991) 

排序下，扫描一遍即可，秒杀级水题一枚。不会快排的可冒泡。

```c++ 
#include<cstdio>
#include<cstring>
#include<iostream>
#include<algorithm>
using namespace std;
#define rep(i,a,n) for (int i=(a); i<(n); ++i)
int a[110];
int main()
{
 //   freopen("data.in","r",stdin);
 //   freopen("data.out","w",stdout);
    int T,n;
    scanf("%d",&T);
    while(T--){
       scanf("%d",&n);
       rep(i,0,n)scanf("%d",&a[i]);
       sort(a,a+n);
       int cnt=1;
       rep(i,1,n) {if(a[i]!=a[i-1])cnt++;}
       printf("%d\n",cnt);        
    }
    return 0;
}
```

##E [德德的嗜好2.0](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1992)  

此题也是一个排序题，当然如果直接<code>strcmp</code>是不行的，考虑90 9这组数据，结果很明显应该是990而不是909。  
因为我们在排序的时候只要保证<code>(a+b)>(b+a)</code>即可。  
**再次表示对数据中出现了大于1000的数表示抱歉**

```c++ 
#include<cstdio>
#include<cstring>
#include<iostream>
#include<algorithm>
using namespace std;
#define rep(i, n) for (int i=0; i<(n); ++i)
string s[81];
bool cmp(string a,string b)
{
     return (a+b)>(b+a);
}
int main()
{
    //freopen("data.in","r",stdin);
    //freopen("data.out","w",stdout);
    int T,n;
    cin>>T;
    while(T--)
    {
      cin>>n;
      rep(i,n)cin>>s[i];
      sort(s,s+n,cmp);   
      rep(i,n)cout<<s[i];
      cout<<endl;    
    }
    return 0;
}
```

##F [德德的嗜好3.0](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1993)
公式题或者找规律  <code>b(8k+m)=b(m)+60k;  (k=n/8;m=n%8)</code> 打表出前8项就够了;其中<code>b(0)=-1;</code> 可以m等于1到8~这样就用不到b(0)但是计算k,m就多了几行代码。  
下面是推论：  

*	由于<code>a(n+15)-a(n)=60</code>,故若<code>a(n)</code>是3或5的倍数,当且仅当<code>a(n+15)</code>是3或5的倍数. 	

*	于是每15个数是一个周期，前15个3-59~所以划分区间。	

*	现将数轴正向分成一系列长为60的区间段: <code>(0,+?)＝(0,60]∪(60,120]∪(120,180]∪…,</code>注意第一个区间段中含有{a(n)}的项15个,即<code>3,7,11,15,19,23,27,31,35,39,43,47,51,55,59</code>其中属于{ }的项8个,为:<code>b(1)=7, b(2)=11, b(3)=19, b(4)=23,   b(5)=31, b(6)=43, b(7)=47, b(8)=59</code>	

*	于是每个区间段中恰有15个{ }的项,8个{ }的项,且有<code>b(8k+m)-b(m)=60k;</code>	 

*	EG：由于<code>2006＝8×250+6</code>,而<code>b(6)=43</code>,所以<code>b(2006)=60*250+b(6)=15043</code>。	

```c++ 
#include<cstdio>
#include<cstring>
#include<iostream>
#include<algorithm>
using namespace std;
#define ll long long
#define rep(i, n) for (int i=0; i<(n); ++i)
int b[8]={-1,7,11,19,23,31,43,47};

int main()
{
    //freopen("data.in","r",stdin);
    //freopen("data.out","w",stdout);
    int T,n;
    scanf("%d",&T);
    while(T--)
    {
        scanf("%d",&n);  
        ll ans=60LL*(n/8)+b[n%8];
        printf("%lld\n",ans);    
    }
    return 0;
}
```

##G [不知道自己不知道](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1994)  

没什么好说的

```c
while(~scanf("%d",&n)) printf("%d\n",2013-n);
```

##H [知道自己不知道](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1995)  

数组求和除以M向上取整.  

```
rep(i,0,n)  scanf("%d",&a);
sum+=a;     
printf("%d\n",(sum+m-1)/m); //加上m-1为向上取整
```

##I [不知道自己知道](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1996)  

暴力比较即可

```c++ 
#define rep(i,a,n) for (int i=(a); i<(n); ++i)
string s[110];
int main()
{
 
    int t=0,T,m,n;
    cin>>T;
    string qurry;
    while(t++<T)
    {
        cin>>m;
        rep(i,0,m){cin>>s[i];}
        cin>>n;
        cout<<"Case #"<<t<<":"<<endl;
        rep(i,0,n){
          cin>>qurry;
          bool fg=0;
          rep(j,0,m){if(qurry==s[j]){fg=1;break;}}
          if(fg)cout<<"Yes"<<endl;
          else cout<<"No"<<endl;
        }        
    }
    return 0;
}
```

#J [知道自己知道](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=1997)  

做一下结构体，保存i和和i出现的次数，有负数，i集体加上100，然后恢复即可。

```c++ 
#define rep(i,a,n) for (int i=(a); i<(n); ++i)
struct pt{     
	int cnt;
    int i;  
};
pt s[550];
bool cmp(pt a,pt b){
     if(a.cnt==b.cnt) return a.i<b.i;     
     return a.cnt>b.cnt;
}
int main(){
    int t,n,a;
    scanf("%d",&t);
    while(t--){
        rep(i,0,500){s[i].i=i-100;s[i].cnt=0;}
        scanf("%d",&n);
        rep(i,0,n)  {  scanf("%d",&a);      s[a+100].cnt++; }
        sort(s,s+500,cmp);
        int cnt=0;
        rep(i,0,500){if(s[i].cnt!=0)cnt++;else break;}
        printf("%d",cnt);
        rep(i,0,500){  if(!s[i].cnt)break;  printf(" %d",s[i].i);   }
        printf("\n");
    }
    return 0;
}
```

以上题目均为过测试数据的程序，不保证程序完全正确无误，欢迎指正,预赛题目难度很明显会增大很多，大家加油。 3Q

