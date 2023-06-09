Ts=1e-3;      % 采样间隔0.001
t=0:Ts:20*Ts; % 仿真时间序列 t = 0.02
x=sin(2*pi*50*t)%+0.5*sin(2*pi*150*t);% 原始信号
delta=0.4;    % 量化阶距
D(1+length(t))=0;                % 预测器初始状态 此时length(t) = 21,则D(22)被赋值 0，即 D(22)=0。
for k=1:length(t)
    e(k)=x(k)-D(k);              % 误差信号
    e_q(k)=delta*(2*(e(k)>=0)-1);% 量化器输出
    D(k+1)=e_q(k)+D(k);          % 延迟器状态更新
    codeout(k)=(e_q(k)>0);       % 编码输出
end
subplot(3,1,1);plot(t,x,'-o');axis([0 20*Ts,-2 2]); hold on;
subplot(3,1,2);stairs(t,codeout);axis([0 20*Ts,-2 2]);
                                 % 解码端
Dr(1+length(t))=0;               % 解码端预测器初始状态
for k=1:length(t)
    eq(k)=delta*(2*codeout(k)-1);% 解码
    xr(k)=eq(k)+Dr(k);
    Dr(k+1)=xr(k);               % 延迟器状态更新
end
subplot(3,1,3);stairs(t,xr);hold on;% 解码输出
subplot(3,1,3);plot(t,x);           % 原信号