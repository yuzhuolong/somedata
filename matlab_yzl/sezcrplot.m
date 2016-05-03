%===========================================
function out=sezcrplot(x)
%===========================================
%绘制原始数据的短时能量图和短时过零率图,x为输入原始数据矩阵N*13

x(end,:)=[];
x(end,:)=[];
x(end,:)=[];


time=x(:,13);
winlen=20;
smoothwinlen=5;

[se_x,zcr_x]=sezcr(x(:,1),winlen);
[se_y,zcr_y]=sezcr(x(:,2),winlen);
[se_z,zcr_z]=sezcr(x(:,3),winlen);
subplot(4,2,1)
plot(time,se_x,time,se_y,time,se_z,'LineWidth',2);
set(gca,'Position',[0.08 0.75 0.4 0.15]);
set(gca,'XTick',[]);
title('Short Energy of Acceleration Sensor Data');
subplot(4,2,2)
plot(time,smooth(zcr_x,5),time,smooth(zcr_y,5),time,smooth(zcr_z,5),'LineWidth',2);
set(gca,'Position',[0.52 0.75 0.4 0.15]);
set(gca,'XTick',[]);
title('Short ZCR of Acceleration Sensor Data');

[se_x,zcr_x]=sezcr(x(:,4),winlen);
[se_y,zcr_y]=sezcr(x(:,5),winlen);
[se_z,zcr_z]=sezcr(x(:,6),winlen);
subplot(4,2,3)
plot(time,se_x,time,se_y,time,se_z,'LineWidth',2);
set(gca,'Position',[0.08 0.55 0.4 0.15]);
set(gca,'XTick',[]);
title('Short Energy of Gyroscope Sensor Data');
subplot(4,2,4)
plot(time,smooth(zcr_x,5),time,smooth(zcr_y,5),time,smooth(zcr_z,5),'LineWidth',2);
set(gca,'Position',[0.52 0.55 0.4 0.15]);
set(gca,'XTick',[]);
title('Short ZCR of Gyroscope Sensor Data');

[se_x,zcr_x]=sezcr(x(:,7),winlen);
[se_y,zcr_y]=sezcr(x(:,8),winlen);
[se_z,zcr_z]=sezcr(x(:,9),winlen);
subplot(4,2,5)
plot(time,se_x,time,se_y,time,se_z,'LineWidth',2);
set(gca,'Position',[0.08 0.35 0.4 0.15]);
set(gca,'XTick',[]);
title('Short Energy of Geomagnetic Filed Sensor Data');
subplot(4,2,6)
plot(time,smooth(zcr_x,5),time,smooth(zcr_y,5),time,smooth(zcr_z,5),'LineWidth',2);
set(gca,'Position',[0.52 0.35 0.4 0.15]);
set(gca,'XTick',[]);
title('Short ZCR of Geomagnetic Filed Sensor Data');

[se_x,zcr_x]=sezcr(x(:,10),winlen);
[se_y,zcr_y]=sezcr(x(:,11),winlen);
[se_z,zcr_z]=sezcr(x(:,12),winlen);
subplot(4,2,7)
plot(time,se_x,time,se_y,time,se_z,'LineWidth',2);
set(gca,'Position',[0.08 0.15 0.4 0.15]);
title('Short Energy of Linear Acceleration Sensor Data');
xlabel('t(ms)');
subplot(4,2,8)
plot(time,smooth(zcr_x,5),time,smooth(zcr_y,5),time,smooth(zcr_z,5),'LineWidth',2);
set(gca,'Position',[0.52 0.15 0.4 0.15]);
title('Short ZCR of Linear Acceleration Sensor Data');
xlabel('t(ms)');
