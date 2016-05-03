%% Compute Frequency Spec..
%   freqData:
%       -amptitude Frequenct Spec Amplititude..
%       -freq (Hz)

function freqData = compFreqSpec(rawdata, fs)
    nfft = 2^nextpow2(numel(rawdata));
    freqDataAm = fft(rawdata, nfft);
    
    freqData.freq = linspace(0, fs, nfft/2+1);
    freqData.amptitude = abs(freqDataAm(1:nfft/2+1))';
%     freqData.amptitude = abs(freqDataAm(1:nfft/2+1));
end