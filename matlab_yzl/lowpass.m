wn=20*2*pi;     %滤波器截止频率
n=5;              %滤波器阶数
fs=50;        %采样频率，你的数据自己设定
[z, p, k]=buttap(n);   
[b, a]=zp2tf(z, p, k);
[bt, at]=lp2lp(b, a, wn);
[bz, az]= impinvar(bt, at, fs);  %滤波器系数
y=filter(bz,az,x);        %x为你的采样数据，y为滤波后的数据
Y=fft(y);        

plot(1:size(x,1),x);
plot(1:size(y,1),y);