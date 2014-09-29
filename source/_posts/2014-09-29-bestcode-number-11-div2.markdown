---
layout: post
title: "bestcode #11 div2"
date: 2014-09-29 04:54:35 +0100
comments: true
categories: [ACM,Cpp]
keywords: bestcode,hdu,div2,ACM,C++ 
description: "bestcode #11 div2 杭电,bestcode,hdu,div2,ACM,C++,11" 
---

博客还是要不定期更新下才行，表示存活。  
~~昨天晚上做了杭电的best coder,div2果然还是比较适合我这种弱渣的，都可以做。最后1004出题人实在太恶意了，故意卡内存，MLE到死，1002坑死了一堆人，最后hack了6个（悲催的是自己想到数据了写错了一个字母，自己最后也挂掉了）。  
**题解间下面:**  
<!-- more -->  

###[1001](http://acm.hdu.edu.cn/showproblem.php?pid=5054)
签到题，没什么可说的，判断<code>2*x==n&&2*y==m</code>就行了  

```
int main(){
   //data();
         
   int m,n,x,y;
   
   while(~scanf("%d%d%d%d",&n,&m,&x,&y)){
      if(x*2==n&&y*2==m) cout<<"YES"<<endl;
      else cout<<"NO"<<endl;
   }
   return 0;
}
```  

###[1002](http://acm.hdu.edu.cn/showproblem.php?pid=5055)    
  
**题意:** 给你一堆0~9的数字，让你把他们组合成一个满足条件的最大的数:  

*	木有前导0  
*	最后一个必须是奇数  

如果没有满足条件的，输出-1。
**解法:  ** 贪心，选一个最小的奇数放最后，然后从大到小输出剩余的数就行了，注意判断无解的情况。  
一些特殊数据  

> 5  
> 1 0 0 0 0  
> out:-1  
> 1  
> 1  
> out:1  
> 1  
> 0  
> out:0  


```
#define rep(i, n) for (int i=0; i<(n); ++i)
void RD(int &a) { 
    int value = 0, s = 1; 
    char c;
    while ((c = getchar()) == ' ' || c == '\n');
    if (c == '-') s = -s; else value = c-48;
    while ((c = getchar()) >= '0' && c <= '9')
        value = value * 10 + c - 48;
    a = s * value;
}
int res[10];
int main(){
   //data();
         
   int n,a;
   while(~scanf("%d",&n)){
      int fg=0,fg2=0,mi=11;
      memset(res,0,sizeof(res));
      rep(i,n){ 
         RD(a);
         if(a&1){ fg++;if(mi>a)mi=a;} 
         res[a]++; 
      }  
      if(fg==0||(n>1&&res[0]==n-1)){printf("-1\n");}
      else{
             
         
         for(int i=9;i>=0;i--){
            if(i==mi) rep(j,res[i]-1)printf("%d",i);
            else rep(j,res[i]) printf("%d",i);
            
         }
         printf("%d\n",mi);
      }
   }
   
   return 0;
}
```  


###[1003](http://acm.hdu.edu.cn/showproblem.php?pid=5056)  

**题意： ** 给你一个只包含小写字母的字符串，问你相同字母不超过k个的子串有多少种。  
**解法:  ** 简单的dp吧对于某个i位置，找到该字母的第前k个相同字母的位置(不足k,就在起始位置)，同时维护前i-1的位置最远可以向前的位置。  

```
void RD(int &a) { 
    int value = 0, s = 1; 
    char c;
    while ((c = getchar()) == ' ' || c == '\n');
    if (c == '-') s = -s; else value = c-48;
    while ((c = getchar()) >= '0' && c <= '9')
        value = value * 10 + c - 48;
    a = s * value;
}

int cnt[27];
vector<int> mark[26];
char str[100100];
int main(){
   //data();
          
   int T,n,a,k;
   RD(T);
   
   while(T--){
        for(int i=0;i<26;i++){ mark[i].clear();cnt[i]=0;}          
     scanf("%s",str);
     RD(k);
     int len=strlen(str);
     ll res=1LL;
     mark[str[0]-'a'].push_back(0);
     cnt[str[0]-'a']++;
     int cur=-1;
     for(int i=1;i<len;i++)
     {   int tp=str[i]-'a';
         
         if(cnt[tp]<k) res+=(i-cur);
         else{cur=max(cur,mark[tp][cnt[tp]-k]); res +=(i-cur);}
         //cout<<tp<<"  "<<cnt[tp]<<"  "<<k<<"   "<<res<<endl;
         cnt[tp]++;
         mark[tp].push_back(i);
     }
     cout<<res<<endl;
   }
   
   return 0;
}
```

###[1004](http://acm.hdu.edu.cn/showproblem.php?pid=5057)  

**题意:** 给你一串数字，两种操作  

*	S x y: 将第x个数变为y  
*	Q l r d p: 查询[l,r]区间内，第d位数字为p的数有多少个。  

**解法: **一开始利用树状数组开了一个C[d][p][MaxN]的数组来维护第d位为p的一个区间和，结果出题人恶意的卡内存，不断的MLE，姿势不够，怎么优化内存都不行，有人说用无符号short型，但是n最大10^6，会溢出。最后改成离线算法，只开C[p][MaxN]的数组来维护某一位为p的区间和，然后预存所有操作，跑10遍，每一遍对应一位。这样内存就很随意了。   
![](http://unkeltao.qiniudn.com/wailian%2Fhdudiv211.png)  
都是泪~

```
#define MaxN 110000
int  C[11][MaxN]={0};
int n,n2,m;
int read(int k,int i){
    int sum=0;
    if(k<=0) return 0;
    for(;k;k-=(k&-k)) sum += C[i][k];
    return sum;
}

void update(int k,int p,int i){
    for(;k<=n;k+=(k&-k)) C[i][k] += p;
}
void RD(int &a) { 
    int value = 0, s = 1; 
    char c;
    while ((c = getchar()) == ' ' || c == '\n');
    if (c == '-') s = -s; else value = c-48;
    while ((c = getchar()) >= '0' && c <= '9')
        value = value * 10 + c - 48;
    a = s * value;
}
int CC[MaxN],A[MaxN];
int p[11];
int T,i,j,a[MaxN],b[MaxN],l[MaxN],r[MaxN],cnt[MaxN],tp1,tp2;
int ans[MaxN];
int mx[11];
char Q[3];
int main(){
   // data();

    RD(T);
    p[1]=1;
    for(i=2;i<=10;i++) p[i]=p[i-1]*10;
    while(T--){
       RD(n);
       RD(m);        

       for(i=0;i<n;i++){ 
            RD(A[i]);
            //cout<<A[i]<<endl;
       }
       for(int i=0;i<11;i++)mx[i]=n;
       for(i=0;i<m;i++){
          scanf("%s",Q);
             if(Q[0]=='S'){
             cnt[i]=0;
               RD(a[i]);RD(b[i]);
          }else{
               RD(l[i]);RD(r[i]);RD(a[i]);RD(b[i]);cnt[i]=1;
               mx[a[i]]=i;
          }
          
       }
       
       for(int i=1;i<=10;i++)
       {
             memset(C,0,sizeof(C));
             for(j=0;j<n;j++){
                n2 = (A[j]/p[i])%10;
                update(j+1,1,n2);
                CC[j]=A[j];
             }   
            for(int j=0;j<m;j++){
               // if(j>mx[i]) break;
                if(!cnt[j]) {
                    tp1=(CC[a[j]-1]/p[i])%10;
                    tp2=(b[j]/p[i])%10;
                    if(tp1==tp2) continue;
                   {update(a[j],-1,tp1); update(a[j],1,tp2);}
                   CC[a[j]-1]=b[j];
                }else if(a[j]==i){
                    ans[j] = read(r[j],b[j])-read(l[j]-1,b[j]);
                }
            }
       }
       
       for(i=0;i<m;i++){
          if(cnt[i])  printf("%d\n",ans[i]);
       }                            
    }
}
```