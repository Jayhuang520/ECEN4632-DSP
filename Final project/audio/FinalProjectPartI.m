%%%%%%%%%%%%%Final project part I From the wav file to the psychoacoustic
%%%%%%%%%%%%%features

[song,fs] = audioread('track463-metal.wav');

%%%% audio files are sampled at fs = 11025 Hz
%fs = 11025; %Or 22050 Hz
%%%%%%%%%%%since the sampling rate is 11025, the FFT size is twice the
%%%%%%%%%%%sampling rate, which its 2 * fs

%%%%%%--------------initialization----------------------
SongLength = length(song);
Mid = floor(SongLength/2);
%%%%Convert it to time
xn = song(Mid:Mid+24*fs-1);
w = hann(512);
fftsize = 512; %%%%Size of fft
nf = floor(24*11025/256);
index = 1;
%%%%%% nbank = 40
output = zeros(40,nf);
for n = 1:256:(nf-1)*256
    output(:,index) = mfcc(xn(n:n+fftsize-1),fs,fftsize,w);
    index = index + 1;
end
    
%%%%%%%Take 20log10 of your output,
%use flipud 

output = flipud(output);
output = 20*log10(output);

figure
imagesc(output);
xlabel('Frequency');
ylabel('Decibel intensity');
colorbar

