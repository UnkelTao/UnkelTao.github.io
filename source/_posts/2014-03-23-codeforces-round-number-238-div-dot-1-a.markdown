---
layout: post
title: "Codeforces #238 (Div.1 AB)"
date: 2014-03-23 19:51:37 +0800
comments: true
categories: [CF,Cpp]
keywords: CF,Ruby,ACM,C++,237 
description: "Codeforces Round #238 (Div. 1 A&B)" 
---

rating 居然涨了，简直不科学。   
[弱弱的求个关注:http://codeforces.com/profile/UnkelTao](http://codeforces.com/profile/UnkelTao)  

##[A. Unusual Product](http://codeforces.com/contest/406/problem/A)
**题意**: 给你一个矩阵，定义了unusual值，类似与矩阵乘法，但是做的与，对应所有Aij&Aji的值再异或，然后你可以对矩阵的一行或者一列进行反转（0变1，1变0）查询则输出Unusual值。  
**key**: 我们可以发现，Unusual值其实就是主对角线的值进行异或，跟周围的元素完全没有关系，因为： Aij&Aji,但是Aji又会与Aij，这样等于 <code>（Aij&Aji）^（Aji&Aij）=0 (i!=j)</code>,那么操作一次，结果便会由0变1或者由1变0，不管怎么操作。

<!--more-->


```c++
#include <cstdio>
#include <iostream>
#define rep(i, n) for (int i=0; i<(n); ++i)
using namespace std;
void data(){
   freopen("data.in","r",stdin);
   freopen("data.out","w",stdout);
}
int a[1002][1002],n;
int main(){
    //data();
   scanf("%d",&n);
   rep(i,n)rep(j,n) scanf("%d",&a[i][j]);
   int ans=0;
   for(int i=0;i<n;i++)
   for(int j=0;j<n;j++)
   ans+=a[i][j]*a[j][i];
   
   ans%=2;
   int m;
   scanf("%d",&m);
   rep(i,m){
      int a,b;
         scanf("%d",&a);
         if(a==3) printf("%d",ans);
         else {scanf("%d",&b); ans=1-ans;}      
   }
   printf("\n");
   
   return 0;
}
```

##[B. Toy Sum](http://codeforces.com/contest/406/problem/B)
**题意**: 给你1，2...10^6个数，从中已经选出了其中的n个作为X，让你再挑选出m个作为另外一组Y，要求满足题目给出的公式。  
**key**:  我们稍微观察一下公式就会发现，  <code>a- 1 == s-(s+1-a)</code> ; 这样，我们就可以贪心了，如果X中选了a,那么看(s+1-a)被选没，没北选，那么我们便把(s+1-a)选入Y，如果选了，那么我们相当于X得了个s,我们便寻找一组都没被选入X的b和（s+1-b）,肯定可以找到的，因为<code>n<=10^5<=s/2</code>; 这样便可以得出一个可行解。

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
   freopen("data.out","w",stdout);
}
int kk=1000001;
int a[1000002],n;
int t[1000002],t2[1000002];
int ans[1000002],m=0;
int main(){
   // data();
   memset(a,0,sizeof(a));
   memset(t2,0,sizeof(t2));
   scanf("%d",&n);
   
   rep(i,n){scanf("%d",&t[i]);a[t[i]]=1;}
   
   int tp=0;
   rep(i,n){
      if(a[kk-t[i]]) tp++;
      else{
          if(!t2[kk-t[i]]) ans[m++]=kk-t[i];
          t2[t[i]]=1;
          t2[kk-t[i]]=1;
      }  
   }
   tp/=2;
   for(int i=1;i<kk/2+1;i++){
      if(!tp)break;
      if(!a[i]&&!a[kk-i]){ans[m++]=i;ans[m++]=kk-i;tp--;}          
   }
   
   printf("%d\n",m);
   printf("%d",ans[0]);
   for(int i=1;i<m;i++)
      printf(" %d",ans[i]);
   printf("\n");   
   
   return 0;
}
```  

###C,D,E实在做不动了。

PS，顺带写下今天群内学第们训练的题，我是太闲了么。。。囧   

##[E Matrix](http://acm.hust.edu.cn/vjudge/contest/view.action?cid=42652#problem/E)
**题意**:  给你一个数字字符串，构造一个2维的矩阵，bij = si*sj; 给你一个范围x,y,z,t,让所有x=<i<=y, z=<j<=t 的bij的和等于a的这样的Group有多少个。   
**key**:  我们不难发现，其实所有区间的和其实可以转化为 <code>(Sx+S(x+1)...Sy)*(Xz+...+St)</code>（展开就能就是b了），那么相当于我们求的是连续的一段的和，和另外连续的一段的和的乘积等于a的个数，那么我们可以用O(n^2)的算法枚举出所有连续子段和,并记录没种可能的个数。    

*	a=0, 那么判断有多少个连续字段和等于0的，<code> res = cnt[0]\*cnt[0] + 2\*cnt[0]\*cnt[i]\(cnt[i] != 0\)</code>      
*	a!=0,那么我们就可以分解a为两个数的乘积， <code>res = cnt[c]\*cnt[d]\*2(c\*d==a) (若c==d不乘以2)</code>    

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
   freopen("data.out","w",stdout);
}
int cnt[MaxN];
int sum[MaxN],a;
char str[MaxN];
int main(){
    //data();
	while(~scanf("%d",&a)){
        scanf("%s",str);
		memset(cnt,0,sizeof(cnt));					
		int len = strlen(str);
		sum[0]=0;
		rep(i,len){sum[i+1]=sum[i]+str[i]-'0';}
		repf(i,1,len)repf(j,i,len)cnt[sum[j]-sum[i-1]]++;
        
        ll res=0;
        if(a==0)
		{
		 	res+=1LL*cnt[0]*cnt[0];
			repd(i,sum[len])if(cnt[i]) res+=1LL*cnt[0]*cnt[i]*2; 	
			cout<<res<<endl;
			continue;
		}					
		for(int i=1;i*i<=a;i++)
			if(a%i==0&&a/i<=sum[len]) 
				if(i*i==a) res += 1LL*cnt[i]*cnt[a/i];
				else res += 1LL*cnt[i]*cnt[a/i]*2;					  	
		cout<<res<<endl;	
	}
	
   return 0;
}

```

###[F - How far away ？](http://acm.hust.edu.cn/vjudge/contest/view.action?cid=42652#problem/F)
**题意**:  给你一颗树，查询两个之间的距离(有且只有一条)。     
**key**： 标准解放应该是LCA（最近公共祖先） ，由于查询数目极少，本题只有200，那么很明显赤裸裸的搜索也能过啊，不知道为啥木有学第写。 广搜深搜应该都可以，n比较大，需要cevtor或者邻接表存储。  

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
#define repd(i,n)  for(int i=1;i<=(n);++i)
#define repf(i, a, b) for (int i=(a); i<=(b); ++i)
#define reps(i, a, b) for (int i=(a); i>=(b); --i)
#define PB push_back
#define MP(A, B) make_pair(A, B)
#define pow2(n) (1<<(n))
#define pi acos(-1)
#define eps 0.00000001
#define lg(n) log10((n)*1.0)
#define MaxN  100000
#define mod 1000000007
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
   freopen("data.out","w",stdout);
}
int pnt[MaxN],nxt[MaxN],head[MaxN],len;
bool used[MaxN];
int w[MaxN];
int fg,ans,n,m;

int t,e;
void init(){
   len=0;
   memset(head,-1,sizeof(head));
   memset(used,0,sizeof(used));
}
void addeg(int u,int v,int k){
      pnt[len] = v;
      w[len]= k;
      nxt[len] = head[u]; 
      head[u] = len++;
}

void dfs(int u,int cur){
  int v;
  used[u]=1;
  if(fg)return;
  for(int i=head[u];i!=-1;i=nxt[i]){
      v=pnt[i];
      if(v==e){fg=1;ans=cur+w[i];return;}
	  if(fg) break;
      if(!used[v]){
         used[v]=1;          
         dfs(v,cur+w[i]);
      }
  }
 
}
//读入外挂 
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

int main(){
	int T,a,b,k;
	RD(T);
	while(T--){
	   init();		   
       RD(n,m);
	   rep(i,n-1){RD(a,b,k);addeg(a,b,k);addeg(b,a,k);}
	   rep(i,m){
	   	  RD(t,e);
	   	  fg=0;
	   	  memset(used,0,sizeof(used));
		  dfs(t,0);
		  printf("%d\n",ans);	 		
	   }
	}
	return 0;
}
```

#最后祝学第们加油。

