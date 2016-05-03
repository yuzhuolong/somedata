function [ features ] = getfeature( segment )
%getfeature 计算片段的特征值，返回结构体，包含以下feature
%=========================================================================
%% G_Sensor features_timedomain
%   features.g_mag_mean
%   features.g_mag_max
%   features.g_mag_min
%   features.g_mag_std
%   features.g_mag_range
%   features.g_mag_zcr_mean
%   features.g_mag_kurtosis
%   features.g_mag_mdan
%magnitude
mag=[];
for i=1:1:size(segment,1)
    mag= [mag;sqrt(segment(i,1)^2+segment(i,2)^2+segment(i,3)^2)];
end
%plot(1:1:size(mag,1),mag(:));               %幅拼
features.g_mag_mean=mean(mag);
features.g_mag_max=max(mag);
features.g_mag_min=min(mag);
%features.g_mag_std=std(mag);
features.g_mag_range=max(mag)-min(mag);
zc_counter=0;
for i=1:1:size(mag,1)-1
    if (mag(i,1)-features.g_mag_mean)*(mag(i+1,1)-features.g_mag_mean)<0
        zc_counter=zc_counter+1;
    end
end
features.g_mag_zcr_mean=zc_counter/size(mag,1);
features.g_mag_kurtosis=kurtosis(mag);

sumdif=0;
difcounter=0;
for i=1:1:size(mag,1)-1
    sumdif=sumdif+abs(mag(i,1)-mag(i+1,1));
    difcounter=difcounter+1;
end
features.g_mag_mdan=sumdif/difcounter;

sumdifsqrt=0;
for i=1:1:size(mag,1)-1
    sumdifsqrt=sumdifsqrt+(mag(i,1)-mag(i+1,1))^2;
end
features.g_mag_myenergy=sumdifsqrt/size(mag,1);
%% G_Sensor features_information_theory
%   features.g_mag_lzc
%   features.g_mag_sampen

%convert to binary vector
mag_median=median(mag);
mag_binary=[];
for i=1:1:size(mag,1)
    if mag(i,1)<mag_median
        mag_binary=[mag_binary;0];
    else
        mag_binary=[mag_binary;1];
    end
end
[c,h,gs]=calc_lz_complexity(mag_binary,'exhaustive',true);
features.g_mag_lzc=c;
features.g_x_sampen=SampEn(2,0.2*std(segment(:,1)),segment(:,1));
features.g_y_sampen=SampEn(2,0.2*std(segment(:,2)),segment(:,2));
features.g_z_sampen=SampEn(2,0.2*std(segment(:,3)),segment(:,3));
features.g_mag_sampen=min([features.g_x_sampen,features.g_y_sampen,features.g_z_sampen]);
%features.g_mag_sampen=SampEn(2,0.2*std(mag),mag);

%% G_Sensor features_frequencydomain
%   features.g_mag_dccomponent
%   features.g_mag_peakamp
%   features.
%   features.g_mag_peakfreq
%   features.g_mag_spectralcentroid
%   features.g_mag_spectralspread
%   features.g_mag_spectralkurtosis
%   features.g_mag_spectralslope
%   features.g_mag_spectraldecrease
%   features.g_mag_spectralrolloff

%hamming window
% h=hamming(size(mag,1));
% mag_hamming=h.*mag;
% mag_fft=fft(mag_hamming);
mag_fft=fft(mag);
mag_fft_amp=abs(mag_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
mag_fft_fs=round(n/l);
mag_fft_n=(0:1:size(segment,1)-1)';
mag_fft_freq=mag_fft_n*mag_fft_fs/size(segment,1);


%% 计算振幅的局部极值，并进行二次拟合
% localpeak=[];
% for ii=2:1:round(size(mag_fft_amp,1)/2)      %从2开始为了去除DC Component
%     if ii-1<2 || ii+1>size(mag_fft_amp,1)
%         continue
%     end
%     max_backfoward=max(mag_fft_amp(ii+1:round(size(mag_fft_amp,1)/2),1));
%     if mag_fft_amp(ii,1)>max([mag_fft_amp(ii-1,1),mag_fft_amp(ii+1,1),max_backfoward])
%         localpeak=[localpeak;mag_fft_freq(ii,1),mag_fft_amp(ii,1)];
%     end
% end

% log_localpeakamp=log(localpeak(:,2));
% P=polyfit(localpeak(:,1),log_localpeakamp,1);
% logy1=P(1)*(0:0.1:mag_fft_freq(end,1)/2)+P(2);
% y1=exp(logy1);
% [fit_p,fit_s,fit_mu]=polyfit(localpeak(:,1),localpeak(:,2),3);
% [fit_y,fit_delta]=polyval(fit_p,0:0.1:mag_fft_freq(end,1)/2,fit_s,fit_mu);
%plot(mag_fft_freq(2:end,:),20*log(mag_fft_amp(2:end,:)));      %分贝
plot(mag_fft_freq(2:end,:),mag_fft_amp(2:end,:));               %幅拼
% hold on;
% scatter(localpeak(:,1),localpeak(:,2),'s');
% plot(0:0.1:mag_fft_freq(end,1)/2,fit_y);
%%
features.g_mag_dccomponent=mag_fft_amp(1);
[maxx,indexx]=max(mag_fft_amp(2:end));      %Except DC Component
features.g_mag_peakamp=maxx;
features.g_mag_peakfreq=mag_fft_freq(indexx+1);

%% halfPeakAmp_FreqBandWidth
start_freq=65536;
start_index=0;
end_freq=0;
end_index=0;
for ii=2:1:round(size(mag_fft_amp,1)/2)
    if mag_fft_amp(ii,1)>=features.g_mag_peakamp/2
        if mag_fft_freq(ii,1)<start_freq
            start_freq=mag_fft_freq(ii,1);
            start_index=ii;
        end
        if mag_fft_freq(ii,1)>end_freq
            end_freq=mag_fft_freq(ii,1);
            end_index=ii;
        end
    end
end
features.g_mag_halfpeakampfreqbandwidth=end_freq-start_freq;
% hold on;
% plot(mag_fft_freq(2:end,:),features.g_mag_peakamp/2*ones(size(mag_fft_freq,1)-1),'--');
% h=area(mag_fft_freq(start_index:end_index,:),mag_fft_amp(start_index:end_index,:));
% child=get(h,'Children');
% set(child,'FaceAlpha',0.3);
%% quarterPeakAmp_FreqBandWidth
start_freq=65536;
start_index=0;
end_freq=0;
end_index=0;
for ii=2:1:round(size(mag_fft_amp,1)/2)
    if mag_fft_amp(ii,1)>=features.g_mag_peakamp/4
        if mag_fft_freq(ii,1)<start_freq
            start_freq=mag_fft_freq(ii,1);
            start_index=ii;
        end
        if mag_fft_freq(ii,1)>end_freq
            end_freq=mag_fft_freq(ii,1);
            end_index=ii;
        end
    end
end
features.g_mag_quarterpeakampfreqbandwidth=end_freq-start_freq;
% hold on;
% plot(mag_fft_freq(2:end,:),features.g_mag_peakamp/4*ones(size(mag_fft_freq,1)-1),'--');
% h=area(mag_fft_freq(start_index:end_index,:),mag_fft_amp(start_index:end_index,:));
% child=get(h,'Children');
% set(child,'FaceAlpha',0.3);
%%
features.g_mag_spectralcentroid=sum(mag_fft_amp.*(mag_fft_freq)./sum(mag_fft_amp));
g_mag_spectral_u=features.g_mag_spectralcentroid;
g_mag_spectralspread=sum(mag_fft_amp.*((mag_fft_freq-g_mag_spectral_u).^2))./sum(mag_fft_amp);
g_mag_spectral_o2=g_mag_spectralspread;
g_mag_spectral_o4=g_mag_spectral_o2^2;
g_mag_spectral_m4=sum(mag_fft_amp.*((mag_fft_freq-g_mag_spectral_u).^4))./sum(mag_fft_amp);
features.g_mag_spectralkurtosis=g_mag_spectral_m4/g_mag_spectral_o4;

s1=sum(mag_fft_amp);
s2=size(mag_fft_amp,1)*sum(mag_fft_amp.*mag_fft_freq)-sum(mag_fft_amp)*sum(mag_fft_freq);
s3=size(mag_fft_amp,1)*sum(mag_fft_freq.^2)-(sum(mag_fft_freq))^2;
features.g_mag_spectralslope=s2/(s3);
end

