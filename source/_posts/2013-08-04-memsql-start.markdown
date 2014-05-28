---
layout: post
title: "MemSQL start"
date: 2013-08-04 20:13:34 +0800
comments: true
categories: [ACM,CF,Cpp]
description: "MemSQL start" 
keywords: ACM,CF,C++
---

【测试代码】


昨晚的CF略晚~~而且提示说div2的少年们，你们很可能会爆0~~~

于是赤裸裸的去了，然后悲催的爆0了

只看了A、B两题~~A题觉得挺简单的，敲了个2分交上去过了Pass，想了想B觉得没有想法就睡觉了。。。
<!--more-->
早上一起洗个澡吃完早餐一看~~WA了~~然后看了下代码，我去，尼玛有一行特判输出没改，直接注释掉没用的特判就过了

说说A题吧，题意大概是一串字符串，求一个长度为k的子串，是的用最少的该子串来构成源串，你可以使用子串的其中任意个字符按照你想要的方式排序拼接,输出需要的最少个数和该k子串。

解法：数据那么弱，统计下源串每个字母的个数，直接暴力匹配从1个到(n+k-1)/k个能否拼成源串就好,写的2分,也过了.

```c++ 
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
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  1000000
#define mod 10e+7
#define ll long long
#define typed int
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
char s[1100];
int su[27];
int k;
int jd(int n){
   int cnt=0;
   rep(i,26){
       cnt+=(su[i]+n-1)/n;
   } 
   if(cnt<=k) return 1;
   else return 0;
}
void pt(int n){
 //  cout<<"pt"<<endl;   
   cout<<n<<endl;    
   string ss="";
   int cnt=0;
   rep(i,26){
      rep(j,(su[i]+n-1)/n){ ss+=(i+'a');cnt++;}
   }
   cout<<ss;
   rep(i,k-cnt)cout<<'a';
   cout<<endl;
}
void bit(int l,int r){
     while(l<r){
     int mid=(l+r)/2;
     int kk=jd(mid);
       if(kk>0) r=mid;
       else l=mid+1;    
     }
     pt(l);
}
 
int main(){
   while(cin>>s>>k){
     rep(i,26) su[i]=0;
     rep(i,strlen(s))su[s[i]-'a']++;
     int ma=0,cnt=0;
     rep(i,26)if(su[i]){cnt++;ma=max(ma,su[i]);}
     if(k<cnt)cout<<-1<<endl;
     else{
       
         
        //bit((strlen(s)+k-1)/k,ma+1); //2分 
        repd(i,strlen(s)){   //暴力 
           if(jd(i)){pt(i);break;}
        }
     } 
   }        
   return 0;
}
```

B题一看最长回文子序列，能想到的方法就是2维DP出LCS~~可是源串长度为50000，2维DP肯定挂~~早上起来，顺带看了一眼，发现一个条件，回文最长为100（大于100输出100的就行）,这个想了下，就好搞了.一共26字母，说明在2600个字母序列里面肯定会产生回文长度至少是100的。。

这样超过长度2600的就可以直接DP前2600个字母就行了~~~然后就是模板题了~~~真是弱爆了~~

```c++ 
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
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  50000
#define mod 10e+7
#define ll long long
#define typed int
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
int dp[2620][2620];
char c[MaxN+100],a[2620],b[2620];
int k[2620][2620];
int cnt[27];
void LCS(int len){
     int i, j;
      rep(i,len+1){ dp[i][0]=dp[0][i]=0;}
      repd(i,len)
        repd(j,len)
        {
            if(a[i]==b[j]){
                k[i][j]=0;
                dp[i][j]=1+dp[i-1][j-1];  
            }
            else if(dp[i-1][j]>=dp[i][j-1]){
                k[i][j]=1;
                dp[i][j]=dp[i-1][j]; 
            }
            else{
                 k[i][j]=-1;
                 dp[i][j]=dp[i][j-1];
            }         
        } 
}
char st[2610];
int num;
void pt(int m,int n){
   if(n==0||m==0) return ;
   if(k[m][n]==0){
     pt(m-1,n-1);
     st[num++]=a[m];
   }
   else if(k[m][n]>0) pt(m-1,n);
   else pt(m,n-1);  
}
int main(){
    //data();
    while(~scanf("%s",c+1)){                            
     int len=strlen(c+1);
     num=0;
     bool fg=1;
     repd(i,len){
         cnt1-'a']++;
         if(cnt1-'a']>=100){
           rep(j,100)cout<<c[i];
           cout<<endl;fg=0;break;
         }
     }
     if(!fg)continue;
     if(len>2602) len=2602;
     repd(i,len){a[i]=c[i];b[len+1-i]=c[i];}
     LCS(len);
     pt(len,len);
     if(num<=100)printf("%s\n",st);
     else{
       rep(i,50)cout<<st[i];reps(i,49,0)cout<<st[i]; cout<<endl;  
     }
     
    }           
   return 0;
}
```

（效果似乎一般）

