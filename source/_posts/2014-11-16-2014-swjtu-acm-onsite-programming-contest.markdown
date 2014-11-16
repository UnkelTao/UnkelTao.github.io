---
layout: post
title: "2014年西南交通大学 新秀杯 ACM程序设计大赛 决赛解题报告"
date: 2014-11-16 10:41:05 +0000
comments: true
categories: [ACM,Cpp]
description: "2014年西南交通大学 新秀杯 ACM程序设计大赛 决赛解题报告" 
keywords: ACM,C++
---


**比赛链接：**  [新秀杯 ACM程序设计大赛决赛](http://acm.swjtu.edu.cn/JudgeOnline/showcontest?contest_id=1135)  

比赛还算成功，算上友情参赛，总共有7个题目有人通过，第一名最后成绩为5题，虽然离我想的差一点。不过还是不错~~  

<!--more-->


##A [从头再来](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2173)

只需要简单的统计单词A中每个字母出现的次数，与B中每个字母出现的次数做比较即可。

```
#include <cstdio>
#include <cmath>
#include <algorithm>
#include <iostream>
#define SQR(x) ((x)*(x))
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define MaxN  10010
#define ll long long
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
char a[MaxN],b[MaxN];
int s1[27],s2[27];
int gao(){
    memset(s1,0,sizeof(s1));
    memset(s2,0,sizeof(s2));
    int l1=strlen(a),l2=strlen(b);
    rep(i,l1) s1[a[i]-'a']++;
    rep(i,l2) s2[b[i]-'a']++;
    rep(i,26)if(s1[i]<s2[i]) return 0;
    return 1;   
}
int main(){
   //data();
   while(cin>>a>>b){
      printf("%s\n",gao()?"Yes":"No");
   }
   return 0;
}
```

##B [挖掘机技术哪家强](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2175)

![](http://unkeltao.qiniudn.com/wailian/10_onsite_B.jpg)   

~~连接DF，那么ADF的面积为正方形的一半，也是矩形的一半，正方形的面积就等于矩形的面积。
<code>AE=a*a/b; DE=sqrt(a*a-AE*AE)</code>

```
int main(){
   //  data();
   int a,b;
   while(~scanf("%d%d",&a,&b)){
       double res=sqrt(a*a-(a*a*1.0/b)*(a*a*1.0/b))*(a*a*1.0/b)/2.0;
       printf("%.2lf\n",res);             
   }
   return 0;
}
```

##C [YogyKwan的iPhone也弯了](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2175)

假设半径为<code>r,t</code>为输入的数据那么可以写出如下等式：
<code>r*sin(pi-15/r/2)=t/2</code>
我们可以知道，当<code>r</code>越大时候，<code>t</code>就会越小，于是我们可以二分判定。


```
#include<cstdio>
#include<cmath>
const double PI=acos(-1);
const double eps=1e-10;
int main(){
    //freopen("data.in","r",stdin);freopen("data2.out","w",stdout);
    double l,w,r,a,sj,xj,m,t;
    while(scanf("%lf",&w)!=EOF){
        l=15;
        sj=l/PI,xj=0.5*l/PI;
        w*=0.5,l*=0.5;
        while(sj-xj>eps){
            m=(sj+xj)*0.5;
            t=m*sin(l/m);
            if(t>w) sj=m;
            else xj=m;
        }
        r=m;
        a=l/r*2;
        printf("%f %f\n",r,a);
    }
    return 0;
}
```


##D [强迫症改变世界](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2776) 

不妨用 <code>f(k)</code> 来表示摆放<code>k</code>个座位的方案数。我们可以把这些方案分成两类：最后一个座位是坐女生，或者最后一个座位是坐男生。如果是前一种情形，则我们只需要看前<code>k–1</code>座位有多少摆法就可以了；如果是后一种情形，那么倒数第二个座位必须是女生，因而这种情形下的方案数就取决于前 <code>k–2</code>个座位的安排方案数。因此我们得到， <code>f(k) = f(k – 1) + f(k – 2)</code> 其中<code>f[1]=2,f[2]=3;</code>


``` 
#define SQR(x) ((x)*(x))
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
int f[1002];
void gao(){
     f[0]=1;
     f[1]=2;
     repf(i,2,1001) f[i]=(f[i-1]+f[i-2])%mod;           
}
int main(){
    //data();
    int n;
    gao();
    while(~scanf("%d",&n)){
        printf("%ld\n",f[n]);
    }
    return 0;
}
```

##E [强迫症改变世界2](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2177)  

此题需要先会容斥定理， <code>n</code>以内<code>a,b</code>的倍数的个数有， <code>sum=n/a+n/b+n/lcm(a,b)</code>;
然后我们枚举出所有的只含有<code>4</code>或者<code>7</code>的数字（大概<code>1000</code>个），然后去掉是前面出现过得数的倍数的数（如<code>44</code>是<code>4</code>的倍数） 大概还剩下不到<code>600</code>个，看起来很大，因为容斥定理的复杂度是<code>2^n</code>次方，但是，此题<code>r</code>的范围不是小，我们在做<code>lcm</code>的时候，很快就会超过范围，就不需要继续向下了，然后我们从大往小做，大概只需要递归<code>10</code>万次左右。

剩下的可以参考代码。

```
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <climits>
#include <cctype>
#include <ctime>
#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>
#include <set>
#include <map>
#include <stack>
#define SQR(x) ((x)*(x))
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  1000000000
#define mod 1000000007
#define md(x) (((x)%mod+mod)%mod)
#define ll long long
using namespace std;
void data(){
   freopen("sample.in","r",stdin);
   freopen("sample.out","w",stdout);
}
ll gcd(ll a,ll b){return b?gcd(b,a%b):a;}
int t,n,m;
ll l,r,ans,a[3000],b[3000];
bool vis[3000];
void pre(int x,ll y)
{
  if(y>MaxN)return;
  if(x>0)a[++m]=y;
  pre(x+1,y*10+4);
  pre(x+1,y*10+7);
}
void gao(){
  sort(a+1,a+m+1);
  repd(i,m)
     if(!vis[i])
     {
         b[++n]=a[i];
         for(int j=i+1;j<=m;j++)
             if(!(a[j]%a[i]))
                 vis[j]=1;
     }
  repd(i,n) a[n-i+1]=b[i];
}
void dfs(int x,int y,ll z)
{
  if(x>n)
  {
    if(y&1)ans+=r/z-(l-1)/z;
    else if(y)ans-=r/z-(l-1)/z;
    return;
  }
  dfs(x+1,y,z);
  ll tmp=z/gcd(a[x],z);
  if((a[x]*tmp)<=r) dfs(x+1,y+1,a[x]*tmp);
}
int main()
{
    //data();
    pre(0,0);
    gao();
    while(~scanf("%lld%lld",&l,&r)){
      ans=0;
      dfs(1,0,1);
      printf("%lld\n",ans);
    }
    return 0;
}
```


##F [不幸的程序员II](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2178)
矩阵快速幂，如果你还不会这个，那么该先去学习矩阵快速幂。

简单公式推导如下:
![](http://unkeltao.qiniudn.com/wailian/10_F_1.png)
![](http://unkeltao.qiniudn.com/wailian/10_F_2.png)


```
#include <cstdio>
#include<iostream>
#include<cstdlib>
#include<stdio.h>
#include<math.h>
using namespace std;
const int MAX = 3;
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define mod 1000000007
#define ll long long
typedef struct
{
   ll m[MAX][MAX];
} Matrix;
Matrix P;
Matrix I ={1,0,0,0,1,0,0,0,1};
Matrix matrixmul(Matrix a,Matrix b) 
{
   int i,j,k;
   Matrix c;
   rep(i,MAX)
   rep(j,MAX)
   {
     c.m[i][j] = 0;
     rep(k,MAX) c.m[i][j] += (a.m[i][k] * b.m[k][j])%(mod);
     c.m[i][j] %= (mod);
   }
   return c;
}
Matrix quickpow(ll n, Matrix P)
{
    Matrix m = P, b = I;
    while (n >= 1)
    {
        if (n & 1)
        b = matrixmul(b,m);
        n = n >> 1;
        m = matrixmul(m,m);
    }
    return b;
}
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
int main()
{
    ll a,b,n,m;
    //data();
    while(~scanf("%lld%lld%lld%lld",&n,&m,&a,&b))
    {   
        Matrix T1,T2,T;
        Matrix P1 = {2,1,3,1,0,0,0,0,1};
        Matrix P2 = {5*8,4*8+7,6*8+9,5,4,6,0,0,1};
        T1=quickpow((m-2),P1);
        T2=quickpow(1LL*n-1,matrixmul(T1,P2));
        T=matrixmul(T2,T1);
        Matrix tmp={b%mod,0,0,a%mod,0,0,1,0,0};
        T=matrixmul(T,tmp);
        printf("%lld\n",T.m[0][0]%mod); 
    }
    return 0; 
}
```


##G [你是一个好人](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2179)  

概率DP，我们假设<code>dp[i][j]</code>表示前i次表白收集了j张不同卡的概率，那么很明显:
<code>i==1,j==1</code>时 <code>dp[1][1] = 1</code>;  
<code>i&lt;j </code>,  <code>dp[i][j] = 0;</code>(一共都不到j张，怎么收集)   
那么<code>dp[i+1][j] = dp[i][j]*(j/n)+dp[i][j-1]*(n-(j-1))/n</code>;
第一个表示第<code>i+1</code>收集的与之前的<code>j</code>张是一样的，第二个表示第<code>i+1</code>次收集的与前<code>j-1</code>个不同，那么就就多收集了一个，变成<code>j</code>个。

```
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <climits>
#include <cctype>
#include <ctime>
#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>
#include <set>
#include <map>
#include <stack>
#define SQR(x) ((x)*(x))
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  1000000
#define mod 1000000007
#define ll long long
#define typed int
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
//fast read
void RD(int &a) {
    int value = 0, s = 1;
    char c;
    while ((c = getchar()) == ' ' || c == '\n');
    if (c == '-') s = -s; else value = c-48;
    while ((c = getchar()) >= '0' && c <= '9')
        value = value * 10 + c - 48;
    a = s * value;
}
void RD(int &a,int &b){
    RD(a),RD(b);
}
void RD(int &a,int &b,int &c){
    RD(a),RD(b),RD(c);
}
double dp[101][2002];
double gao(int n,int m){
     memset(dp,0,sizeof(0));
     dp[0][0]=1.0;
     repd(i,n)repf(j,i,m) dp[i][j]=dp[i-1][j-1]*(n-i+1)/n+dp[i][j-1]*i/n; 
     return dp[n][m];
}
int main(){
   //data();
   int t,n,m;
   RD(t);
   rep(i,t){
      RD(n,m);
      if(m<n)printf("%.6lf\n",0);
      else printf("%.6lf\n",gao(n,m));
   }
   return 0;
}
```





##H [最萌身高差](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2180)  

此题为树状数组的 YY 题。。。  
首先我们考虑若 <code>&beta;</code> 固定的情况，那么根据同模的性质。。如果 <code>a%p == b%p</code> 那么 <code>|a-b| = k * p</code>  
这样预处理一下，只要找到模相同的个数，就能知道有多少组了。。此题 <code>&beta;</code>很小，那么我们维护各个余数的前缀和就可以求个分别余数的区间和了。。。，因为此题要求支持修改，那么我们就使
用树状数组（如果你还不会，那么赶紧学起吧）就可以满足要求了。。、、   
关键是怎么去修改更新；修改了一个数，我们需要一增一减，余数为 <code>a% &beta;</code> 的减一， <code>(a + p)% &beta;</code> 的加 1.. 这样就可以很好的查找和维护了。。 

<code>&beta;</code>不一样？ 但是<code>&beta;</code>很小啊，我们再增加一维？这么做会MLE，那么我们离线处理每个<code>&beta;</code>跑一次就好了。


```
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <climits>
#include <cctype>
#include <ctime>
#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>
#include <set>
#include <map>
#include <stack>
#define SQR(x) ((x)*(x))
#define rep(i, n) for (int i=0; i<(n); ++i)
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  200000
#define mod 13041290
#define mod2 1000000009
#define mod3 1000007
#define md(x) (((x)%mod+mod)%mod)
#define inf 2147483647
#define inf2 0x7fffffffffffffff
#define ll long long
#define typed int
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data2.out","w",stdout);
}
int C[10][MaxN]={0};
int n,m;
int read(int k,int i){
  int sum=0;
  for(;k;k-=(k&-k)) sum += C[i][k];
  return sum;
}
void update(int k,int p,int i){
    for(;k<=n;k+=(k&-k)) C[i][k] += p;
}
//fast read
void RD(int &a) { 
    int value = 0, s = 1; 
    char c;
    while ((c = getchar()) == ' ' || c == '\n');
    if (c == '-') s = -s; else value = c-48;
    while ((c = getchar()) >= '0' && c <= '9')
        value = value * 10 + c - 48;
    a = s * value;
}
int B[MaxN],A[MaxN];
int l[MaxN],r[MaxN],beta[MaxN];
int q[MaxN];
ll ans[MaxN];
int used[11];
int Q,a,p,m,l1,r1,beta1;
void gao(){
  memset(used,0,sizeof(used));
  rep(i,n) RD(A[i]);
  int len=0,t=0;
  rep(i,m){
      RD(Q);
    if(Q==1)RD(a),RD(p),l[len]=a,r[len]=p,q[len++]=-1;
    else{
         RD(l1),RD(r1),RD(beta1);
         l[len]=l1,r[len]=r1,beta[len]=beta1;
         used[beta1]=1,q[len++]=t++;
       if(beta1==1){ 
        ll ttt=r1-l1+1; 
        ans[q[len-1]]=ttt*(ttt-1)/2%mod;
       }
     }
  }
}
int main(){
  //data();
  while(~scanf("%d%d",&n,&m)){  
     gao();
     repf(k,2,10){
        if(!used[k])continue;
        memset(C,0,sizeof(C));
        rep(i,n) B[i]=A[i],update(i+1,1,A[i]%k);
        rep(i,m){
           if(q[i]==-1){
              update(l[i],-1,B[l[i]-1]%k);
              update(l[i],1,(B[l[i]-1]+r[i])%k);
              B[l[i]-1]+=r[i];
              continue;
           }
           if(beta[i]!=k)continue;
           ll sum=0;
           rep(j,beta[i]){
               ll tp = read(r[i],j) - read(l[i]-1,j);
               sum += tp*(tp-1)/2;
               sum %=mod;
           }
           ans[q[i]]=sum%mod;
        } 
     }
     rep(i,t) printf("%lld\n",ans[i]%mod);
  }
  return 0;
}

```

##I [Missing教大家画矩形](http://acm.swjtu.edu.cn/JudgeOnline/showproblem?problem_id=2181)  

模拟题目，确定一个矩形只需要对角线确定，
所以找出最小，最大的x值和y值就行了
题目虽然简单，但是如果写法不好，也会被坑~
(此题来自于Missing)

```
//Draw A Rectangle
//Author: _missing
// 模拟题，确定一个矩形只需要对角线确定，
// 所以找出最小，最大的x值和y值就行了
// 题目虽然简单，但是如果写法不好，也会被坑~
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;
void draw(int x1, int y1, int x2, int y2) {
    for (int i = 0; i < x1; ++i) puts("");
    for (int i = x1; i <= x2; ++i) {
        for (int j = 0; j < y1; ++j) putchar(' ');
        for (int j = y1; j <= y2; ++j)
            if (i == x1 || i == x2) putchar('*');
            else if (j == y1 || j == y2) putchar('*');
            else putchar(' ');
        putchar('\n');
    }
}
int main() {
    //freopen("data2.in", "r", stdin);
    //freopen("data2.out", "w", stdout);
    int T, ncase = 0, N;
    while (~scanf("%d", &T)) {
        while (T--) {
            int x[4], y[4], minx = 100, maxx = -1, miny = 100, maxy = -1;
            int ok = 1;

            scanf("%d", &N);
            for (int i = 0; i < N; ++i) scanf("%d %d", x+i, y+i);
            for (int i = 0; i < N; ++i) {
                minx = min(minx, x[i]);
                maxx = max(maxx, x[i]);
                miny = min(miny, y[i]);
                maxy = max(maxy, y[i]);
            }
            if (minx == maxx || miny == maxy) ok = 0;
            for (int i = 0; ok && i < N; ++i) {
                if ((x[i] == minx || x[i] == maxx) &&
                    (y[i] == miny || y[i] == maxy)) continue;
                ok = 0;
            }

            printf("Case #%d:\n", ++ncase);
            if (!ok) { puts("None"); continue; }
            draw(minx, miny, maxx, maxy);
        }
    }
    return 0;
}
```


以上题目均为过测试数据的程序，不保证程序完全正确无误.
Thanks for reading...  
