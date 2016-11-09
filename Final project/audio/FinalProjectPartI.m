%%%%%%%%%%%%%Final project part I From the wav file to the psychoacoustic
%%%%%%%%%%%%%features
track201 = audioread('track201-classical.wav');
%sound(track201);
%%%% audio files are sampled at fs = 11025 Hz
fs = 11025; %Or 22050 Hz
%%%%%%%%%%%since the sampling rate is 11025, the FFT size is twice the
%%%%%%%%%%%sampling rate, which its 2 * fs
fftsize = fs*2;
w = 512;%is a window of size N, N = 512 samples.
mfcc = mfcc(track201,fs,fftsize,w);
imagesc(mfcc);