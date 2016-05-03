function [features]=getfeature(segment)
% tic;

%%
acc_mag=[];
for i=1:1:size(segment,1)
    acc_mag=[acc_mag;sqrt(segment(i,1)^2+segment(i,2)^2+segment(i,3)^2)];
end    
features.acc_mag_max=max(acc_mag);
features.acc_mag_min=min(acc_mag);
features.acc_mag_range=max(acc_mag)-min(acc_mag);
features.acc_mag_mean=mean(acc_mag);

geo_mag=[];
for i=1:1:size(segment,1)
    geo_mag=[geo_mag;sqrt(segment(i,4)^2+segment(i,5)^2+segment(i,6)^2)];
end
features.geo_mag_max=max(geo_mag);
features.geo_mag_min=min(geo_mag);
features.geo_mag_range=max(geo_mag)-min(geo_mag);
features.geo_mag_mean=mean(geo_mag);

%%
acc_mag_fft=fft(acc_mag);
acc_mag_fft_amp=abs(acc_mag_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
acc_mag_fft_fs=round(n/l);
acc_mag_fft_n=(0:1:size(segment,1)-1)';
acc_mag_fft_freq=acc_mag_fft_n*acc_mag_fft_fs/size(segment,1);

features.acc_mag_dccomponent=acc_mag_fft_amp(1);
[acc_maxall,acc_indexall]=max(acc_mag_fft_amp(2:end));     
features.acc_mag_peakamp=acc_maxall;
features.acc_mag_peakfreq=acc_mag_fft_freq(acc_indexall+1);

geo_mag_fft=fft(geo_mag);
geo_mag_fft_amp=abs(geo_mag_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
geo_mag_fft_fs=round(n/l);
geo_mag_fft_n=(0:1:size(segment,1)-1)';
geo_mag_fft_freq=geo_mag_fft_n*geo_mag_fft_fs/size(segment,1);

features.geo_mag_dccomponent=geo_mag_fft_amp(1);
[geo_maxall,geo_indexall]=max(geo_mag_fft_amp(2:end));     
features.geo_mag_peakamp=geo_maxall;
features.geo_mag_peakfreq=geo_mag_fft_freq(geo_indexall+1);

% halfPeakAmp_FreqBandWidth
% start_freq=65536;
% start_index=0;
% end_freq=0;
% end_index=0;
% for ii=2:1:round(size(mag_fft_amp,1)/2)
%     if mag_fft_amp(ii,1)>=features.g_mag_peakamp/2
%         if mag_fft_freq(ii,1)<start_freq
%             start_freq=mag_fft_freq(ii,1);
%             start_index=ii;
%         end
%         if mag_fft_freq(ii,1)>end_freq
%             end_freq=mag_fft_freq(ii,1);
%             end_index=ii;
%         end
%     end
% end
% features.g_mag_halfpeakampfreqbandwidth=end_freq-start_freq;

%%
acc_magx_abs=[];
acc_magy_abs=[];
acc_magz_abs=[];
acc_magx=[];
acc_magy=[];
acc_magz=[];
% acc_magx_notabs=[];
% acc_magy_notabs=[];
% acc_magz_notabs=[];
for i=1:1:size(segment,1) % 返回行数
	acc_magx_abs=[acc_magx_abs;abs(segment(i,1))];
    acc_magy_abs=[acc_magy_abs;abs(segment(i,2))];
    acc_magz_abs=[acc_magz_abs;abs(segment(i,3))];
	acc_magx=[acc_magx;segment(i,1)];
	acc_magy=[acc_magy;segment(i,2)];
	acc_magz=[acc_magz;segment(i,3)];
% 	acc_magx_notabs=[acc_magx_notabs;segment(i,1)];
% 	acc_magy_notabs=[acc_magy_notabs;segment(i,2)];
% 	acc_magz_notabs=[acc_magz_notabs;segment(i,3)];
end

features.acc_magx_abs_max=max(acc_magx_abs);
features.acc_magx_abs_min=min(acc_magx_abs);
features.acc_magx_abs_mean=mean(acc_magx_abs);

features.acc_magy_abs_max=max(acc_magy_abs);
features.acc_magy_abs_min=min(acc_magy_abs);
features.acc_magy_abs_mean=mean(acc_magy_abs);

features.acc_magz_abs_max=max(acc_magz_abs);
features.acc_magz_abs_min=min(acc_magz_abs);
features.acc_magz_abs_mean=mean(acc_magz_abs);


features.acc_magx_max=max(acc_magx);
features.acc_magx_min=min(acc_magx);
features.acc_magx_range=max(acc_magx)-min(acc_magx);
features.acc_magx_mean=mean(acc_magx);

features.acc_magy_max=max(acc_magy);
features.acc_magy_min=min(acc_magy);
features.acc_magy_range=max(acc_magy)-min(acc_magy);
features.acc_magy_mean=mean(acc_magy);

features.acc_magz_max=max(acc_magz);
features.acc_magz_min=min(acc_magz);
features.acc_magz_range=max(acc_magz)-min(acc_magz);
features.acc_magz_mean=mean(acc_magz);



geo_magx_abs=[];
geo_magy_abs=[];
geo_magz_abs=[];
geo_magx=[];
geo_magy=[];
geo_magz=[];
% geo_magx_notabs=[];
% geo_magy_notabs=[];
% geo_magz_notabs=[];
for i=1:1:size(segment,1) % 返回行数
    geo_magx_abs=[geo_magx_abs;abs(segment(i,4))];
    geo_magy_abs=[geo_magy_abs;abs(segment(i,5))];
    geo_magz_abs=[geo_magz_abs;abs(segment(i,6))];
	geo_magx=[geo_magx;segment(i,4)];
	geo_magy=[geo_magy;segment(i,5)];
	geo_magz=[geo_magz;segment(i,6)];
end

features.geo_magx_abs_max=max(geo_magx_abs);
features.geo_magx_abs_min=min(geo_magx_abs);
features.geo_magx_abs_mean=mean(geo_magx_abs);

features.geo_magy_abs_max=max(geo_magy_abs);
features.geo_magy_abs_min=min(geo_magy_abs);
features.geo_magy_abs_mean=mean(geo_magy_abs);

features.geo_magz_abs_max=max(geo_magz_abs);
features.geo_magz_abs_min=min(geo_magz_abs);
features.geo_magz_abs_mean=mean(geo_magz_abs);


features.geo_magx_max=max(geo_magx);
features.geo_magx_min=min(geo_magx);
features.geo_magx_range=max(geo_magx)-min(geo_magx);
features.geo_magx_mean=mean(geo_magx);

features.geo_magy_max=max(geo_magy);
features.geo_magy_min=min(geo_magy);
features.geo_magy_range=max(geo_magy)-min(geo_magy);
features.geo_magy_mean=mean(geo_magy);

features.geo_magz_max=max(geo_magz);
features.geo_magz_min=min(geo_magz);
features.geo_magz_range=max(geo_magz)-min(geo_magz);
features.geo_magz_mean=mean(geo_magz);

%%
% Spectral Kurtosis
features.acc_magx_kurtosis=kurtosis(acc_magx);
features.acc_magy_kurtosis=kurtosis(acc_magy);
features.acc_magz_kurtosis=kurtosis(acc_magz);
features.geo_magx_kurtosis=kurtosis(geo_magx);
features.geo_magy_kurtosis=kurtosis(geo_magy);
features.geo_magz_kurtosis=kurtosis(geo_magz);

% Lempel-Ziv Complexity on Z-axis 
% magz_median=median(magz);
% magz_binary=[];
% for i=1:1:size(magz,1)
%     if magz(i,1)<magz_median
%         magz_binary=[magz_binary;0];
%     else
%         magz_binary=[magz_binary;1];
%     end
% end
% [c,h,gs]=calc_lz_complexity(magz_binary,'exhaustive',true);
% features.g_magz_lzc=c;

% Sample Entropy
% features.g_x_sampen=SampEn(2,0.2*std(segment(:,1)),segment(:,1));
% features.g_y_sampen=SampEn(2,0.2*std(segment(:,2)),segment(:,2));
% features.g_z_sampen=SampEn(2,0.2*std(segment(:,3)),segment(:,3));
% features.g_mag_sampen=min([features.g_x_sampen,features.g_y_sampen,features.g_z_sampen]);

%%
acc_magz_fft=fft(acc_magz);
acc_magz_fft_amp=abs(acc_magz_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
acc_magz_fft_fs=round(n/l);
acc_magz_fft_n=(0:1:size(segment,1)-1)';
acc_magz_fft_freq=acc_magz_fft_n*acc_magz_fft_fs/size(segment,1);

acc_z_s1=sum(acc_magz_fft_amp);
acc_z_s2=size(acc_magz_fft_amp,1)*sum(acc_magz_fft_amp.*acc_magz_fft_freq)-sum(acc_magz_fft_amp)*sum(acc_magz_fft_freq);
acc_z_s3=size(acc_magz_fft_amp,1)*sum(acc_magz_fft_freq.^2)-(sum(acc_magz_fft_freq))^2;
features.acc_magz_spectralslope=acc_z_s2/(acc_z_s3);

features.acc_magz_dccomponent=acc_magz_fft_amp(1);
% Exclude DC Component
[acc_maxz,acc_indexz]=max(acc_magz_fft_amp(2:end));
features.acc_magz_peakamp=acc_maxz;
features.acc_magz_peakfreq=acc_magz_fft_freq(acc_indexz+1);

%%
geo_magz_fft=fft(geo_magz);
geo_magz_fft_amp=abs(geo_magz_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
geo_magz_fft_fs=round(n/l);
geo_magz_fft_n=(0:1:size(segment,1)-1)';
geo_magz_fft_freq=geo_magz_fft_n*geo_magz_fft_fs/size(segment,1);

geo_z_s1=sum(geo_magz_fft_amp);
geo_z_s2=size(geo_magz_fft_amp,1)*sum(geo_magz_fft_amp.*geo_magz_fft_freq)-sum(geo_magz_fft_amp)*sum(geo_magz_fft_freq);
geo_z_s3=size(geo_magz_fft_amp,1)*sum(geo_magz_fft_freq.^2)-(sum(geo_magz_fft_freq))^2;
features.geo_magz_spectralslope=geo_z_s2/(geo_z_s3);

features.geo_magz_dccomponent=geo_magz_fft_amp(1);
% Exclude DC Component
[geo_maxz,geo_indexz]=max(geo_magz_fft_amp(2:end));
features.geo_magz_peakamp=geo_maxz;
features.geo_magz_peakfreq=geo_magz_fft_freq(geo_indexz+1);

%%
acc_magx_fft=fft(acc_magx);
acc_magx_fft_amp=abs(acc_magx_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
acc_magx_fft_fs=round(n/l);
acc_magx_fft_n=(0:1:size(segment,1)-1)';
acc_magx_fft_freq=acc_magx_fft_n*acc_magx_fft_fs/size(segment,1);

acc_x_s1=sum(acc_magx_fft_amp);
acc_x_s2=size(acc_magx_fft_amp,1)*sum(acc_magx_fft_amp.*acc_magx_fft_freq)-sum(acc_magx_fft_amp)*sum(acc_magx_fft_freq);
acc_x_s3=size(acc_magx_fft_amp,1)*sum(acc_magx_fft_freq.^2)-(sum(acc_magx_fft_freq))^2;
features.acc_magx_spectralslope=acc_x_s2/(acc_x_s3);

features.acc_magx_dccomponent=acc_magx_fft_amp(1);
% Exclude DC Component
[acc_maxx,acc_indexx]=max(acc_magx_fft_amp(2:end));
features.acc_magx_peakamp=acc_maxx;
features.acc_magx_peakfreq=acc_magx_fft_freq(acc_indexx+1);

%%
geo_magx_fft=fft(geo_magx);
geo_magx_fft_amp=abs(geo_magx_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
geo_magx_fft_fs=round(n/l);
geo_magx_fft_n=(0:1:size(segment,1)-1)';
geo_magx_fft_freq=geo_magx_fft_n*geo_magx_fft_fs/size(segment,1);

geo_x_s1=sum(geo_magx_fft_amp);
geo_x_s2=size(geo_magx_fft_amp,1)*sum(geo_magx_fft_amp.*geo_magx_fft_freq)-sum(geo_magx_fft_amp)*sum(geo_magx_fft_freq);
geo_x_s3=size(geo_magx_fft_amp,1)*sum(geo_magx_fft_freq.^2)-(sum(geo_magx_fft_freq))^2;
features.geo_magx_spectralslope=geo_x_s2/(geo_x_s3);

features.geo_magx_dccomponent=geo_magx_fft_amp(1);
% Exclude DC Component
[geo_maxx,geo_indexx]=max(geo_magx_fft_amp(2:end));
features.geo_magx_peakamp=geo_maxx;
features.geo_magx_peakfreq=geo_magx_fft_freq(geo_indexx+1);

%%
acc_magy_fft=fft(acc_magy);
acc_magy_fft_amp=abs(acc_magy_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
acc_magy_fft_fs=round(n/l);
acc_magy_fft_n=(0:1:size(segment,1)-1)';
acc_magy_fft_freq=acc_magy_fft_n*acc_magy_fft_fs/size(segment,1);

acc_y_s1=sum(acc_magy_fft_amp);
acc_y_s2=size(acc_magy_fft_amp,1)*sum(acc_magy_fft_amp.*acc_magy_fft_freq)-sum(acc_magy_fft_amp)*sum(acc_magy_fft_freq);
acc_y_s3=size(acc_magy_fft_amp,1)*sum(acc_magy_fft_freq.^2)-(sum(acc_magy_fft_freq))^2;
features.acc_magy_spectralslope=acc_y_s2/(acc_y_s3);

features.acc_magy_dccomponent=acc_magy_fft_amp(1);
% Exclude DC Component
[acc_maxy,acc_indexy]=max(acc_magy_fft_amp(2:end));
features.acc_magy_peakamp=acc_maxy;
features.acc_magy_peakfreq=acc_magy_fft_freq(acc_indexy+1);

%%
geo_magy_fft=fft(geo_magy);
geo_magy_fft_amp=abs(geo_magy_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
geo_magy_fft_fs=round(n/l);
geo_magy_fft_n=(0:1:size(segment,1)-1)';
geo_magy_fft_freq=geo_magy_fft_n*geo_magy_fft_fs/size(segment,1);

geo_y_s1=sum(geo_magy_fft_amp);
geo_y_s2=size(geo_magy_fft_amp,1)*sum(geo_magy_fft_amp.*geo_magy_fft_freq)-sum(geo_magy_fft_amp)*sum(geo_magy_fft_freq);
geo_y_s3=size(geo_magy_fft_amp,1)*sum(geo_magy_fft_freq.^2)-(sum(geo_magy_fft_freq))^2;
features.geo_magy_spectralslope=geo_y_s2/(geo_y_s3);

features.geo_magy_dccomponent=geo_magy_fft_amp(1);
% Exclude DC Component
[geo_maxy,geo_indexy]=max(geo_magy_fft_amp(2:end));
features.geo_magy_peakamp=geo_maxy;
features.geo_magy_peakfreq=geo_magy_fft_freq(geo_indexy+1);

%%
% 计算频谱
fs=floor(1000*size(segment,1)/(segment(end,14)-segment(1,14)));

acc_magx_freqSet=extractFreqSpecFeaturesPMC(acc_magx, fs);
features.acc_magx_ASC=acc_magx_freqSet.ASC;
features.acc_magx_ASS=acc_magx_freqSet.ASS;
features.acc_magx_Kurtosis2=acc_magx_freqSet.Kurtosis;
features.acc_magx_DCAmplitude=acc_magx_freqSet.DCAmplitude;
features.acc_magx_peakFreq=acc_magx_freqSet.peakFreq;
features.acc_magx_specFlux=acc_magx_freqSet.specFlux;
features.acc_magx_specDecrease=acc_magx_freqSet.specDecrease;
features.acc_magx_specRollOff=acc_magx_freqSet.specRollOff;

acc_magy_freqSet=extractFreqSpecFeaturesPMC(acc_magy, fs);
features.acc_magy_ASC=acc_magy_freqSet.ASC;
features.acc_magy_ASS=acc_magy_freqSet.ASS;
features.acc_magy_Kurtosis2=acc_magy_freqSet.Kurtosis;
features.acc_magy_DCAmplitude=acc_magy_freqSet.DCAmplitude;
features.acc_magy_peakFreq=acc_magy_freqSet.peakFreq;
features.acc_magy_specFlux=acc_magy_freqSet.specFlux;
features.acc_magy_specDecrease=acc_magy_freqSet.specDecrease;
features.acc_magy_specRollOff=acc_magy_freqSet.specRollOff;

acc_magz_freqSet=extractFreqSpecFeaturesPMC(acc_magz, fs);
features.acc_magz_ASC=acc_magz_freqSet.ASC;
features.acc_magz_ASS=acc_magz_freqSet.ASS;
features.acc_magz_Kurtosis2=acc_magz_freqSet.Kurtosis;
features.acc_magz_DCAmplitude=acc_magz_freqSet.DCAmplitude;
features.acc_magz_peakFreq=acc_magz_freqSet.peakFreq;
features.acc_magz_specFlux=acc_magz_freqSet.specFlux;
features.acc_magz_specDecrease=acc_magz_freqSet.specDecrease;
features.acc_magz_specRollOff=acc_magz_freqSet.specRollOff;



geo_magx_freqSet=extractFreqSpecFeaturesPMC(geo_magx, fs);
features.geo_magx_ASC=geo_magx_freqSet.ASC;
features.geo_magx_ASS=geo_magx_freqSet.ASS;
features.geo_magx_Kurtosis2=geo_magx_freqSet.Kurtosis;
features.geo_magx_DCAmplitude=geo_magx_freqSet.DCAmplitude;
features.geo_magx_peakFreq=geo_magx_freqSet.peakFreq;
features.geo_magx_specFlux=geo_magx_freqSet.specFlux;
features.geo_magx_specDecrease=geo_magx_freqSet.specDecrease;
features.geo_magx_specRollOff=geo_magx_freqSet.specRollOff;

geo_magy_freqSet=extractFreqSpecFeaturesPMC(geo_magy, fs);
features.geo_magy_ASC=geo_magy_freqSet.ASC;
features.geo_magy_ASS=geo_magy_freqSet.ASS;
features.geo_magy_Kurtosis2=geo_magy_freqSet.Kurtosis;
features.geo_magy_DCAmplitude=geo_magy_freqSet.DCAmplitude;
features.geo_magy_peakFreq=geo_magy_freqSet.peakFreq;
features.geo_magy_specFlux=geo_magy_freqSet.specFlux;
features.geo_magy_specDecrease=geo_magy_freqSet.specDecrease;
features.geo_magy_specRollOff=geo_magy_freqSet.specRollOff;

geo_magz_freqSet=extractFreqSpecFeaturesPMC(geo_magz, fs);
features.geo_magz_ASC=geo_magz_freqSet.ASC;
features.geo_magz_ASS=geo_magz_freqSet.ASS;
features.geo_magz_Kurtosis2=geo_magz_freqSet.Kurtosis;
features.geo_magz_DCAmplitude=geo_magz_freqSet.DCAmplitude;
features.geo_magz_peakFreq=geo_magz_freqSet.peakFreq;
features.geo_magz_specFlux=geo_magz_freqSet.specFlux;
features.geo_magz_specDecrease=geo_magz_freqSet.specDecrease;
features.geo_magz_specRollOff=geo_magz_freqSet.specRollOff;

% magx_fft=fft(magx);
% magx_fft_amp=abs(magx_fft);
% n=size(segment,1);
% l=(segment(n,14)-segment(1,14))/1000;
% magx_fft_fs=round(n/l);
% magx_fft_n=(0:1:size(segment,1)-1)';
% magx_fft_freq=magx_fft_n*magx_fft_fs/size(segment,1);

% [maxx,indexx]=max(magx_fft_amp(2:end));
% features.g_magx_peakfreq=magx_fft_freq(indexx+1);

% 2015.01.09修改
% features.g_magz_mostfreq=indexz;

% Half Peak Amp BandWidth
% start_freq=65536;
% start_index=0;
% end_freq=0;
% end_index=0;
% for ii=2:1:round(size(magz_fft_amp,1)/2)
%     if magz_fft_amp(ii,1)>=features.g_magz_peakamp/2
%         if magz_fft_freq(ii,1)<start_freq
%             start_freq=magz_fft_freq(ii,1);
%             start_index=ii;
%         end
%         if magz_fft_freq(ii,1)>end_freq
%             end_freq=magz_fft_freq(ii,1);
%             end_index=ii;
%         end
%     end
% end
% features.g_magz_halfpeakampfreqbandwidth=end_freq-start_freq;

% Quarter Peak Amp Bandwidth
% start_freq=65536;
% start_index=0;
% end_freq=0;
% end_index=0;
% for ii=2:1:round(size(magz_fft_amp,1)/2)
%     if magz_fft_amp(ii,1)>=features.g_magz_peakamp/4
%         if magz_fft_freq(ii,1)<start_freq
%             start_freq=magz_fft_freq(ii,1);
%             start_index=ii;
%         end
%         if magz_fft_freq(ii,1)>end_freq
%             end_freq=magz_fft_freq(ii,1);
%             end_index=ii;
%         end
%     end
% end
% features.g_magz_quarterpeakampfreqbandwidth=end_freq-start_freq;

% features.g_magz_spectralcentroid=sum(magz_fft_amp.*(magz_fft_freq)./sum(magz_fft_amp));
% g_magz_spectral_u=features.g_magz_spectralcentroid;

% g_magz_spectralspread=sum(magz_fft_amp.*((magz_fft_freq-g_magz_spectral_u).^2))./sum(magz_fft_amp);
% g_magz_spectral_o2=g_magz_spectralspread;
% g_magz_spectral_o4=g_magz_spectral_o2^2;
% g_magz_spectral_m4=sum(magz_fft_amp.*((magz_fft_freq-g_magz_spectral_u).^4))./sum(magz_fft_amp);
% features.g_magz_spectralkurtosis=g_magz_spectral_m4/g_magz_spectral_o4;

% toc;
% tt=toc*1000;
% features.time=tt;
end