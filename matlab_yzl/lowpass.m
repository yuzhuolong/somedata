wn=20*2*pi;     %�˲�����ֹƵ��
n=5;              %�˲�������
fs=50;        %����Ƶ�ʣ���������Լ��趨
[z, p, k]=buttap(n);   
[b, a]=zp2tf(z, p, k);
[bt, at]=lp2lp(b, a, wn);
[bz, az]= impinvar(bt, at, fs);  %�˲���ϵ��
y=filter(bz,az,x);        %xΪ��Ĳ������ݣ�yΪ�˲��������
Y=fft(y);        

plot(1:size(x,1),x);
plot(1:size(y,1),y);