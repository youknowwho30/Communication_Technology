clear all;
clc;
fs=32;
dt=0.05;
M=16;
Am=1;
t=0:dt:4;
x=sin(2*pi*t)+sin(2*pi*5*t);
t1=0:0.05:4;
t2=0:0.1:4;
x1=sin(2*pi*t1)+sin(2*pi*5*t1);
x=x/max(x);
A=87.6;
mt=0:0.01:4;
mx=sin(2*pi*mt)+sin(2*pi*5*mt);

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
plot(mt,mx);grid on;
xlabel('原信号')
subplot(2,2,2);
stem(t1,x1,'.');
grid on; 
hold on;
legend('抽样值');
xlabel('抽样信号')
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

subplot(2,2,3);
stem(t,lh,'.');
legend('A压缩后信号抽样值');
xlabel('A律量化信号')
subplot(2,2,4);
stem(t,lh,'.');
legend('量化值');
xlabel('均匀量化');
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
