function hd = ideal_low(wc,N);

[song,fs] = audioread('noisy.wav');
sound(song,fs);
% ideal lowpass filter = sinc ( wc*n)/(pi *n)
%
% 
% [hd] = ideal_lp(wc,M)
%
% INPUT:
%             N:  order of the filter
%            wc: cutoff frequency in radians
%
% OUTPUT:
%             hd: ideal impulse response sampled at n = 0.. N
%

alpha = N/2;

n = [0:1:N];

m = n - alpha;

hd = zeros (1,N);

notz     = find (m ~=0);
m_notz = m(notz);
m0       = find (m ==0);

%
% sinc function

hd(notz) = sin(wc*m_notz) ./ (pi*m_notz);

%
%  fix the value at 0

hd (m0) = wc/pi;



