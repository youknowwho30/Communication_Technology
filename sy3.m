clear all;
clc;
fs=32;
dt=1/fs;
M=16;
Am=1;
t=0:dt:1;
x=Am*sin(2*pi*t);
t1=0:dt:1;
x1=Am*sin(2*pi*t1);
x=x/max(x);
A=87.6;
for i=1:length(x)
   if(abs(x(i))>=0&abs(x(i))<=1/A)
       if(x(i)>0)
       y(i)=A*x(i)/(1+log(A));
      else y(i)=-A*x(i)/(1+log(A));
       end
   else
       if(x(i)>0)
         y(i)=(1+log(A*x(i)))/(1+log(A));
      else y(i)=-(1+log(A*x(i)))/(1+log(A));
       end
   end
end
subplot(2,2,1);
plot(t,x);grid on;
xlabel('图1 原信号')
subplot(2,2,2);
stem(t1,x1,'.');
grid on; 
hold on;
legend('抽样值');
xlabel('图2 抽样信号')
%subplot(3,2,3);
%plot(t,y)
%egend('A律压缩后的信号');
%xlabel('图3 抽样信号A律压缩')
v=2/M;
m(1)=-1;
for i=1:M
    m(i+1)=m(i)+v;
    q(i)=(m(i)+m(i+1))/2;
end
   for j=1:length(y)
       for i=1:M-1
           if(y(j)>=m(i)&y(j)<m(i+1))
            lh(j)=q(i); 
         end
        if(y(j)>=m(M))
            lh(j)=q(M);
         end
       end
    e(j)=y(j)-lh(j);
   end
%figure(2)
subplot(2,2,3);
stem(t,y,'filled');
grid on; 
hold on
%stem(t,lh,'r','filled');
legend('A压缩后信号抽样值');
xlabel('图3 A律压缩后的抽样值')
%figure(3)
%subplot(3,2,5);
%stem(t,e);
%xlabel('图五 A律压缩量化的量化误差图')







v=(max(x)-min(x))/M;
m(1)=min(x);
for i=1:M
    m(i+1)=m(i)+v;
    q(i)=(m(i)+m(i+1))/2;
end
   for j=1:length(x)
       for i=1:M-1
           if(x(j)>=m(i)&x(j)<m(i+1))
            lh(j)=q(i); 
         end
        if(x(j)>=m(M))
            lh(j)=q(M);
         end
       end
   end
subplot(2,2,4);
stem(t,lh);
legend('量化值');
xlabel('图4 均匀量化');
