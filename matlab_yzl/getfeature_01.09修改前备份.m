% 2014.12.30
% By Hansong
function [features]=getfeature(segment)



% Min & Max & Mean Abs xyz Magnitude
magx=[];
magy=[];
magz=[];
magx_notabs=[];
magy_notabs=[];
magz_notabs=[];
for i=1:1:size(segment,1) % ·µ»ØÐÐÊý
	magx=[magx;abs(segment(i,1))];
	magy=[magy;abs(segment(i,2))];
	magz=[magz;abs(segment(i,3))];
	magx_notabs=[magx_notabs;segment(i,1)];
	magy_notabs=[magy_notabs;segment(i,2)];
	magz_notabs=[magz_notabs;segment(i,3)];
end
features.g_magx_min=min(magx_notabs);
features.g_magx_max=max(magx_notabs);
features.g_magx_mean=mean(magx_notabs);
features.g_magy_min=min(magy_notabs);
features.g_magy_max=max(magy_notabs);
features.g_magy_mean=mean(magy_notabs);
features.g_magz_min=min(magz_notabs);
features.g_magz_max=max(magz_notabs);
features.g_magz_mean=mean(magz_notabs);



% Spectral Kurtosis
features.g_magx_kurtosis=kurtosis(magx);
features.g_magy_kurtosis=kurtosis(magy);
features.g_magz_kurtosis=kurtosis(magz);



% Lempel-Ziv Complexity on Z-axis 
magz_median=median(magz);
magz_binary=[];
for i=1:1:size(magz,1)
    if magz(i,1)<magz_median
        magz_binary=[magz_binary;0];
    else
        magz_binary=[magz_binary;1];
    end
end
[c,h,gs]=calc_lz_complexity(magz_binary,'exhaustive',true);
features.g_magz_lzc=c;



% Sample Entropy
% features.g_x_sampen=SampEn(2,0.2*std(segment(:,1)),segment(:,1));
% features.g_y_sampen=SampEn(2,0.2*std(segment(:,2)),segment(:,2));
features.g_z_sampen=SampEn(2,0.2*std(segment(:,3)),segment(:,3));



magz_fft=fft(magz);
magz_fft_amp=abs(magz_fft);
n=size(segment,1);
l=(segment(n,14)-segment(1,14))/1000;
magz_fft_fs=round(n/l);
magz_fft_n=(0:1:size(segment,1)-1)';
magz_fft_freq=magz_fft_n*magz_fft_fs/size(segment,1);



features.g_magz_dccomponent=magz_fft_amp(1);
% Exclude DC Component
[maxz,indexz]=max(magz_fft_amp(2:end));
features.g_magz_peakamp=maxz;
features.g_magz_peakfreq=magz_fft_freq(indexz+1);



% Half Peak Amp BandWidth
start_freq=65536;
start_index=0;
end_freq=0;
end_index=0;
for ii=2:1:round(size(magz_fft_amp,1)/2)
    if magz_fft_amp(ii,1)>=features.g_magz_peakamp/2
        if magz_fft_freq(ii,1)<start_freq
            start_freq=magz_fft_freq(ii,1);
            start_index=ii;
        end
        if magz_fft_freq(ii,1)>end_freq
            end_freq=magz_fft_freq(ii,1);
            end_index=ii;
        end
    end
end
features.g_magz_halfpeakampfreqbandwidth=end_freq-start_freq;



% Quarter Peak Amp Bandwidth
start_freq=65536;
start_index=0;
end_freq=0;
end_index=0;
for ii=2:1:round(size(magz_fft_amp,1)/2)
    if magz_fft_amp(ii,1)>=features.g_magz_peakamp/4
        if magz_fft_freq(ii,1)<start_freq
            start_freq=magz_fft_freq(ii,1);
            start_index=ii;
        end
        if magz_fft_freq(ii,1)>end_freq
            end_freq=magz_fft_freq(ii,1);
            end_index=ii;
        end
    end
end
features.g_magz_quarterpeakampfreqbandwidth=end_freq-start_freq;



features.g_magz_spectralcentroid=sum(magz_fft_amp.*(magz_fft_freq)./sum(magz_fft_amp));
g_magz_spectral_u=features.g_magz_spectralcentroid;



g_magz_spectralspread=sum(magz_fft_amp.*((magz_fft_freq-g_magz_spectral_u).^2))./sum(magz_fft_amp);
g_magz_spectral_o2=g_magz_spectralspread;
g_magz_spectral_o4=g_magz_spectral_o2^2;
g_magz_spectral_m4=sum(magz_fft_amp.*((magz_fft_freq-g_magz_spectral_u).^4))./sum(magz_fft_amp);
features.g_magz_spectralkurtosis=g_magz_spectral_m4/g_magz_spectral_o4;



s1=sum(magz_fft_amp);
s2=size(magz_fft_amp,1)*sum(magz_fft_amp.*magz_fft_freq)-sum(magz_fft_amp)*sum(magz_fft_freq);
s3=size(magz_fft_amp,1)*sum(magz_fft_freq.^2)-(sum(magz_fft_freq))^2;
features.g_magz_spectralslope=s2/(s3);



% Magnitude
mag=[];
for i=1:1:size(segment,1)
    mag=[mag;sqrt(segment(i,1)^2+segment(i,2)^2+segment(i,3)^2)];
end    
features.g_mag_range=max(mag)-min(mag);
features.g_mag_mean=mean(mag);


end