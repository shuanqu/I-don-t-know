clc,clear;
a=0.99999; t0=100; t_end=0.0001; n=100000;%迭代次数为100000
A=[1	 565.0	 575.0;	2	  25.0	 185.0;	3	 345.0	 750.0;	
4	 945.0	 685.0;	5	 845.0	 655.0;	6	 880.0	 660.0;	
7	  25.0	 230.0;	8	 525.0	1000.0;	9	 580.0	1175.0;	
10	 650.0	1130.0;	11	1605.0	 620.0;	12	1220.0	 580.0;	
13	1465.0	 200.0;	14	1530.0	   5.0;	15	 845.0	 680.0;	
16	 725.0	 370.0;	17	 145.0	 665.0;	18	 415.0	 635.0;	
19	 510.0	 875.0;	20	 560.0	 365.0;	21	 300.0	 465.0;	
22	 520.0	 585.0;	23	 480.0	 415.0;	24	 835.0	 625.0;	
25	 975.0	 580.0;	26	1215.0	 245.0;	27	1320.0	 315.0;	
28	1250.0	 400.0;	29	 660.0	 180.0;	30	 410.0	 250.0;	
31	 420.0	 555.0;	32	 575.0	 665.0;	33	1150.0	1160.0;	
34	 700.0	 580.0;	35	 685.0	 595.0;	36	 685.0	 610.0;	
37	 770.0	 610.0;	38	 795.0	 645.0;	39	 720.0	 635.0;	
40	 760.0	 650.0;	41	 475.0	 960.0;	42	  95.0	 260.0;	
43	 875.0	 920.0;	44	 700.0	 500.0;	45	 555.0	 815.0;	
46	 830.0	 485.0;	47	1170.0	  65.0;	48	 830.0	 610.0;	
49	 605.0	 625.0;	50	 595.0	 360.0;	51	1340.0	 725.0;	
52	1740.0	 245.0;	];
k=size(A,1);%k为数目,也是行数
X=A(:,2)*ones(1,k);
XX=X';
Y=A(:,3)*ones(1,k);
YY=Y';
D=sqrt((X-XX).^2+(Y-YY).^2);
path=randperm(k);
for e=1:100
    pathc=randperm(k);
    if dd(pathc,D)<dd(path,D)
        path=pathc;
    end
end
pathb=path;
while t0>t_end
    for m=1:n
        p=rand;
        if p<0.4
           q1=ceil(rand.*k);
           q2=ceil(rand.*k);
           while q1==q2
               q2=ceil(rand.*k);
           end
           patha=path;
           patha(q1)=path(q2);
           patha(q2)=path(q1);
           if dd(patha,D)<=dd(path,D)
              path=patha;   
              if dd(patha,D)<=dd(pathb,D)
                  pathb=patha;
              end
           else
              pp=rand;
              if pp<=exp((dd(path,D)-dd(patha,D))./t0)
                  path=patha;
              end
           end
        elseif p<0.7
           q1=ceil(rand.*k);
           q2=ceil(rand.*k);
           q3=ceil(rand.*k);
           while q1==q2||q1==q3||q2==q3
                 q1=ceil(rand.*k);
                 q2=ceil(rand.*k);
                 q3=ceil(rand.*k);
           end
           U=[q1,q2,q3];
           XU=sort(U);
           q1=XU(1);
           q2=XU(2);
           q3=XU(3);
           patha=path;
           patha(q1:q3-q2+q1-1)=path(q2+1:q3);
           patha(q3-q2+q1:q3)=path(q1:q2);
           if dd(patha,D)<=dd(path,D)
              path=patha;    
              if dd(patha,D)<=dd(pathb,D)
                  pathb=patha;
              end
           else
              pp=rand;
              if pp<=exp((dd(path,D)-dd(patha,D))./t0)
                  path=patha;
              end
           end
        else
           q1=ceil(rand.*k);
           q2=ceil(rand.*k);
           while q1==q2
               q2=ceil(rand.*k);
           end
           UU=[q1,q2];
           XUU=sort(UU);
           q1=XUU(1);
           q2=XUU(2);
           patha=path;
           ppp=fliplr(path(q1:q2));
           patha(q1:q2)=ppp;
           if dd(patha,D)<=dd(path,D)
              path=patha;    
              if dd(patha,D)<=dd(pathb,D)
                  pathb=patha;
              end
           else
              pp=rand;
              if pp<=exp((dd(path,D)-dd(patha,D))./t0)
                  path=patha;
              end
           end
        end 
        t0=a*t0;
    end    
end
disp(pathb);
disp(dd(pathb,D));
xxx=[A(pathb,2);A(pathb(1),2)];
yyy=[A(pathb,3);A(pathb(1),3)];
plot(xxx,yyy)
function suan=dd(path,D)
    o=length(path);
    suan=0;
    for i=1:o-1
        suan=D(path(i),path(i+1))+suan;
    end
    suan=D(path(1),path(o))+suan;
end