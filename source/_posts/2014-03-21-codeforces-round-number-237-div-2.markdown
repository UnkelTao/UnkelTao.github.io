---
layout: post
title: "Codeforces Round #237 (Div. 2) "
date: 2014-03-21 11:03:13 +0800
comments: true
categories: [CF,Ruby,ACM,C++]
keywords: CF,Ruby,ACM,C++,237 
description: "Codeforces Round #237 (Div. 2)" 
---

##Codeforces Round #237 (Div. 2)

群中看到学第们发的比赛链接，于是又做了一场，结果悲惨。再也不在windows下做比赛了，电脑现在不知道出了啥问题，每次00：16都要自动关机。结果敲完的题没保存，又得重新敲一遍。  

###[A - Valera and X](http://codeforces.com/contest/404/problem/A)
**题意**： 给你一个矩阵，问你是不是恰好有2种字母，对角线字母一样，非对角线字母一样。  
**key**:   模拟  

<!--more-->

```ruby

n = gets.chomp!.to_i
a = Array.new(n) 

n.times{|i|
    a[i] = gets.chomp!
}

if n==1
    puts "YES"
    exit
end

x = a[0][0]
b = a[0][1]

if x == b
    puts "NO"
    exit
end  
n.times { |i|  
    n.times { |j|  
        if i==j || (i+j==n-1)
            if a[i][j] != x
                puts "NO"
                exit
            end
        else
             if a[i][j] != b
                puts "NO"
                exit
            end
        end
    }
}

puts "YES"

```

##[B - Marathon](http://codeforces.com/contest/404/problem/B)
**题意**:  给你一个a*a的正方形，从(0,0)出发，沿边线逆时针行走，走n次，每次走d的距离，输出每次行走后的坐标。

**key**:   模拟题，注意精度就好。

```ruby  
eps = 1e-5
a,d = gets.chomp!.split.map { |e|  e.to_f}
n =gets.chomp!.to_i
cur_x=0.00
cur_y=0.00
pp=0.00

n.times {
	if cur_y <= eps
		pp = cur_x	
	elsif a-cur_x <= eps
		pp = a + cur_y
	elsif a-cur_y <= eps
		pp = a*3 -cur_x	
	else
		pp = a*4 -cur_y
	end	
	pp +=d;
	t= (pp/a).floor
	pp -= 1.0*t*a;
	case t%4
	when 0
		cur_x=pp
		cur_y=0
	when 1
		cur_x=a
		cur_y=pp
	when 2
		cur_x=a-pp
		cur_y=a
	when 3
		cur_x=0
		cur_y=a-pp
	end
	printf("%.8f %.8f\n",cur_x,cur_y)
}
```  

##[C - Restore Graph](http://codeforces.com/contest/404/problem/C)
**题意**:  给你一个无向无子环的图，告诉你所有点到某一个选取的点的距离的矩阵d,问你能不能修复出满足条件的原图，其中一个点最多能够连接k条边。

**key**:  首先d中肯定只有一个0，并且该点就是选取的点。否则肯定不存在。 对d进行排序，一条边一条边的修复模拟即可，注意满足每个点连接的边不能超过k个。 

```ruby

n,k = gets.chomp!.split.map {|e| e.to_i}

D = gets.chomp!.split.map {|e| [e.to_i,0]}
flag = 0
n.times { |i| 
    D[i][1]=i+1
    if D[i][0] == 0
        flag += 1
    end
}
if flag != 1
    p -1
    exit
end

D.sort!
b = Array.new(2*n)
e = Array.new(2*n)
l=0
f=0
t=1
while t<n 
    if f==1 
        k -= 1 
    end
    if D[t].first!= (D[f].first+1) 
        puts "-1" 
        exit 
    end
    p=k
    i = t
    while i<n
        break if D[i].first!=D[t].first
        if(p==0) 
            f +=1
            p=k 
        end
        if(p==0)  
            puts("-1") 
            exit 
        end
        p -= 1
        if(f==t)  
            puts("-1") 
            exit 
        end
        b[l]=D[f][1];
        e[l]=D[i][1];
        l+=1;i+=1;
    end
    f=t;
    t=i;
end


p l
l.times { |i|  
    puts "#{b[i]} #{e[i]}"
}
```  

##[D - Minesweeper 1D](http://codeforces.com/contest/404/problem/D)
**题意**: 给你一个1*n的地雷图，0表示左右都没有地雷，1表示左右共有1个雷，2表示左右都是雷，*表示该点是雷，？表示该点未知，求有多少种合法的方案。  

**key**: DP,<code>dp[i][0]表示i点是0的方案数，dp[i][1]表示i点是1的方案数，dp[i][2]表示该点是雷的方案数</code>，其中1可以转化为0，2可以转化为1。 因为“*1”的话后面肯定不会是雷，那么变成0的方案数，如果是"01"或“11”的话，后面肯定是雷，保持1不动，"*2"的话后面肯定是雷。  
**转移方程见代码**  

```ruby 
s = gets.chomp!
mods = 1000000007
dp = [[0,0,0],[0,0,0]]

len =s.size
cur =0;nxt=1;

dp[cur][0]=dp[cur][1]=1

for i in 0...len
	case s[i]
	when '0'
		dp[nxt][0]=dp[cur][0]
	when '1'
		dp[nxt][1]= dp[cur][0]
		dp[nxt][0]= dp[cur][2]
	when '2'
		dp[nxt][1]=dp[cur][2]
	when '*'
		dp[nxt][2]= (dp[cur][1]+dp[cur][2])%mods
	when '?'
		dp[nxt][1]= (dp[cur][2]+dp[cur][0])%mods
		dp[nxt][0]= (dp[cur][0]+dp[cur][2])%mods
		dp[nxt][2]= (dp[cur][1]+dp[cur][2])%mods
	end
	cur = nxt
	nxt = cur==0?1:0
	dp[nxt] = [0,0,0]
end

puts "#{(dp[cur][0]+dp[cur][2])%mods}" 
```  

##[E - Maze 1D](http://codeforces.com/contest/404/problem/E)
**题意**: 题意真是难读,大概就是机器人会左右移动，但是如果前面的点是障碍点的话他就不会向前进忽略这次移动，问在设置最少障碍点的情况下能够使得机器人最后停下的位置是以前没有走过的。 问这样的设置方案数有多少个（在障碍点最少的情况下）。

**key**: 二分+枚举。   

*	首先我们可以确定，如果不加障碍点他最后停留的位置只走过一次的话，那么方案数肯定是1。   
*	最多设置一个障碍点，如果一个障碍点不能满足情况，再多的障碍点也没用。  
*	如果i点可以是障碍点，那么<code>(0,i]</code>的点都可以是障碍点，同理-i是障碍点，<code>[-1,0)</code>都可以是障碍点。  

有了这样的理解，那么遍可以2分来判断最大的i点是不是可以为障碍点了，判断方法模拟就可以了。  
**(ruby跑的太慢，TLE了，囧RZ，C++可以AC)**  

**ruby代码**
```ruby
#TLE 代码
$s = gets.chomp!
$fg = 2
$len = $s.size
$mods = $len+7
$vis = Array.new((5*$mods))
def Judge(k)
	
	$fg += 1
	pos = $mods + 100
	k += pos
	$vis[pos] = $fg
	$len.times { |i|  
		if $s[i].chr=='R' and pos+1 !=k
			pos += 1
			# p 111111111111
		elsif $s[i].chr=='L' and pos-1 != k
			pos -= 1
			# p 222222222222
		end
		if i==$len-1
			# puts "b:"
			# p $vis[pos]
			# p pos 
			# p $fg
			return $vis[pos] != $fg
		end
		$vis[pos] = $fg
	}
end

if Judge($mods+300)
	p 1
	exit
end

res = 0
l = 1
r=$len

if Judge(1)
	while l<r
		mid = ((l+r+1)/2).floor
		if Judge(mid)
			l = mid
		else
			r =mid -1
		end
	end
	res += l
end

l = 1
r=$len

if Judge(-1)
	while l<r
		mid = (l+r+1)/2
		if Judge(-1*mid)
			l = mid
		else
			r =mid -1
		end
	end
	res += l
end

p res
```

**c++代码**  
```c++
char str[MaxN];
int fg=2,len;
int vis[5*MaxN];

bool Judge(int k){
   fg++;
   int pos=1e6+10;
   k+=pos;
   vis[pos] = fg;
   // printf("%d %d %d\n", fg,pos,k);
   rep(i,len){
   	  if(str[i]=='R'&&pos+1!=k) pos++;
   	  if(str[i]=='L'&&pos-1!=k) pos--;
   	  if(i==len-1){
   	  	// printf("ans %d  %d %d\n", vis[pos],fg,pos);
   	  	return vis[pos] != fg;
   	  }
   	  vis[pos] = fg;
   }	
}

int main()
{
	while(~scanf("%s",str)){
		len = strlen(str);
		memset(vis,0,sizeof(vis));

		if(Judge(1e6+200)){
			printf("1\n");
			return 0;
		}

		ll res = 0;
		int l=1,r=len,mid;
		if (Judge(1))
		{
			while(l<r){
				mid = (l+r+1)/2;
				if(Judge(mid)) l=mid;
				else r=mid-1;
			}
			res += l;
		}

		if (Judge(-1))
		{
			l=1,r=len,mid;
			while(l<r){
				mid = (l+r+1)/2;
				if(Judge(-mid)) l=mid;
				else r=mid-1;
			}
			res += l;			
		}
		cout<<res<<endl;
	}	
	return 0;
}

```









