data=wall;
XX=data(:,3);
% T=data(:,13);
% 
% TT=0:0.02:T(end);
% XX=spline(T,X,TT);
% plot(TT,XX,'-');

wn=20;% �˲�����ֹƵ��
n=8;% �˲�������
fs=50;% ����Ƶ�ʣ���������Լ��趨
[z, p, k]=buttap(n);   
[b, a]=zp2tf(z, p, k);
[bt, at]=lp2lp(b, a, wn);
[bz, az]= impinvar(bt, at, fs);% �˲���ϵ��
XX_after=filter(bz,az,XX);% xΪ��Ĳ������ݣ�yΪ�˲��������
 
subplot(2,2,1)
plot(1:length(XX),XX);

subplot(2,2,2)
plot(1:length(XX_after),XX_after);

subplot(2,2,3)
plot(1:length(fft(XX)),fft(XX));

subplot(2,2,4)
plot(1:length(fft(XX_after)),fft(XX_after));