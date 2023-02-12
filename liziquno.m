%如果用于计算某一情况下的取值。比如求X+lnX-Y-Y^2+Z+SinZ在（1，10）的最小值
clear
close all
N=50;%先来50个粒子
W=3;%含有三个变量
A=1+9*rand(50,3);%随机解
J=inf+ones(N,1);%个人最优解的值
WA=ones(1,3);%个人最优位置
ZA=ones(1,3);%全局最优位置
WJ=inf;%全局最优解的值
V=10*rand(N,3)-5;%随机初速度
t=100;t0=1;a=0.99;%一丢丢的退火算法
w=0.5;c1=0.5;c2=0.5;%其他参数
while t>t0%进行迭代
       for i=1:50%每一个都看一下
           JJ=wosuan(A(i,:));%计算ing
           if JJ<J(i)
               J(i)=JJ;
               WA=A(i,:);
           end
           if JJ<WJ
               WJ=JJ;
               ZA=A(i,:);
           end
           V(i,:)=w*V(i,:)+c1*(rand-0.5)*(WA-A(i,:))+c2*(rand-0.5)*(ZA-A(i,:));%算速度
           A(i,:)=A(i,:)+V(i);%新位置
           if A(i,1)<1%限制条件
               A(i,1)=1;
           end
           if A(i,2)<1
               A(i,2)=1;
           end
           if A(i,3)<1
               A(i,3)=1;
           end
           if A(i,1)>10
               A(i,1)=10;
           end
           if A(i,2)>10
               A(i,2)=10;
           end
           if A(i,3)>10
               A(i,3)=10;
           end
           p=rand;%跳出局部最优，模拟退火
           if p<exp((WJ-J(i))./t)
               A(i,:)=1+9*rand(1,3);
           end    
       end
       t=a*t;
end
disp(WJ);
disp(ZA);
function SUAN=wosuan(X)
    SUAN=X(1)*log(X(1))-X(2)-X(2)^2+X(3)+sin(X(3));
end