data=wall;
XX=data(:,3);
% T=data(:,13);
% 
% TT=0:0.02:T(end);
% XX=spline(T,X,TT);
% plot(TT,XX,'-');

wn=20;% 滤波器截止频率
n=8;% 滤波器阶数
fs=50;% 采样频率，你的数据自己设定
[z, p, k]=buttap(n);   
[b, a]=zp2tf(z, p, k);
[bt, at]=lp2lp(b, a, wn);
[bz, az]= impinvar(bt, at, fs);% 滤波器系数
XX_after=filter(bz,az,XX);% x为你的采样数据，y为滤波后的数据
 
subplot(2,2,1)
plot(1:length(XX),XX);

subplot(2,2,2)
plot(1:length(XX_after),XX_after);

subplot(2,2,3)
plot(1:length(fft(XX)),fft(XX));

subplot(2,2,4)
plot(1:length(fft(XX_after)),fft(XX_after));