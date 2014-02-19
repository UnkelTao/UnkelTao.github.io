---
layout: post
title: "回文判断 Hash+线段树"
date: 2012-12-18 17:14:12 +0800
comments: true
categories: [ACM]
---

比赛的一道题,一直没时间写.最近空了，继续写写水题。

题目描述：
<!--more-->

##Description  

Now we have a long long string, and we will have two kinds of operation on it.  
C i y: change the ith letter to y;  
Q i j: check whether the substring from ith letter to jth letter is a palindrome.  

##Input  

There are multiple test cases.  
The first line contains a string whose length is not large than 1,000,000.  
The next line contains a integer N indicating the number of operations.  
The next N lines each lines contains a operation.  
All letters in the input are lower-case.  

##Output  

For each query operation, output "yes" if the corresponding substring is a palindrome, otherwise output "no".

##Sample Input

aaaaa   
4  
Q 1 5   
C 2 b   
Q 1 5   
Q 1 3   

##Sample Output

yes   
no   
yes  

**题意：**给你一串字符串~然后有两种操作：Q a b 询问a到b之间的子串是否是回文 ；C i y 将第i个字母变成y

水题，比赛的时候没有写完, 
在学妹的提示下，知道了判断回文可以用hash，正反hash相等的子串就是回文;于是再套上线段树来维护区间的hash值.

```c++ 
#include<iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include<algorithm>
#include<cmath>
#define N 1100010
#define mod 1000000007
#define ll long long
using namespace std;

struct Tree
{
   int l;
   int r;
   ll left;
   ll right;    
};

Tree T[N*2];
char str[N];
int kk[N];

void hashinit(){kk[0]=1; for(int i=1;i<N;i++) kk[i]=kk[i-1]*2%mod;}
Tree cnt(Tree tmp1,Tree tmp2)
{   Tree ans;
     ans.l=tmp1.l;
     ans.r=tmp2.r;    
     ans.left=(kk[tmp2.r-tmp2.l+1]*tmp1.left+tmp2.left)%mod;
     ans.right=(kk[tmp1.r-tmp1.l+1]*tmp2.right+tmp1.right)%mod;  
     return ans; 
}
void init(int i,int l,int r)
{   
     T[i].l=l;
     T[i].r=r; 
     if(l==r){
        T[i].right=T[i].left=str[l-1]-'a';
        return ;
     }
     init(i<<1,l,(l+r)>>1);
     init(i<<1|1,((l+r)>>1)+1,r);  
     T[i]=cnt(T[i<<1],T[i<<1|1]);
  
}
void update(int i,int k,int w)
{    
     int ans;
     if(T[i].l==T[i].r){                                      
       if(T[i].l==k)T[i].left=T[i].right=w;          
       return ;                                     
     }

     if(T[i<<1].l<=k&&T[i<<1].r>=k) update(i<<1,k,w);                                 
     if(T[i<<1|1].l<=k&&T[i<<1|1].r>=k)update(i<<1|1,k,w);    
     T[i]=cnt(T[i<<1],T[i<<1|1]);
}
Tree querry(int i,int l,int r)
{         
     Tree ans;
     if(T[i].l>=l&&T[i].r<=r)return T[i];                                     
     if(T[i<<1].r>=r)return querry(i<<1,l,r);                                 
     if(T[i<<1|1].l<=l)return querry(i<<1|1,l,r);                                               
     return cnt(querry(i<<1,l,T[i<<1].r),querry(i<<1|1,T[i<<1|1].l,r));

}
int main()
{
    int q,k,a,b;
    char qt[2],ch[2];
    Tree ans; 
    hashinit();
    while(~scanf("%s",str)){   
        init(1,1,strlen(str));       
        scanf("%d",&q);
       while(q--){ 
           scanf("%s",&qt);
           if(qt[0]=='C'){
            scanf("%d%s",&k,&ch);
            update(1,k,ch[0]);
           }else{
            scanf("%d%d",&a,&b);
            ans=querry(1,a,b);
            printf("%s\n",ans.right==ans.left?"yes":"no");
           }
       }
    }
    return 0;
}
```


