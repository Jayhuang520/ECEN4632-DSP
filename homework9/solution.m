%
% filter specifications
As = 60; 

% cutoff frequencices

wc1 = pi/3; 
wc2 = 2*pi/3;

% transition bandwidth

dw = pi/6;

% Kaiser parameter

beta = 0.1102*(As-8.7);
N = ceil((As - 8)/(2.285*dw));
N

%____________________________________________
%
%  Design using a Kaiser window
%
%____________________________________________

w_kai = (kaiser(N+1,beta))';

% band pass = subtraction of low pass

hd = ideal_low(wc1,N) + ideal_low(pi,N) - ideal_low(wc2,N);

% filter design = windowing

h = hd .* w_kai;

% evaluate the filter performance

[db,mag,pha,grd,w] = myfreqz (h,[1]);

%____________________________________________
%
%   draw some pretty plots
%
%____________________________________________

% time

n=[0:1:N];

figure;

subplot(1,1,1);

subplot(2,1,2);
plot(w/pi,db);

title('Magnitude Response in dB');grid;
xlabel('frequency in pi units'); ylabel('Decibels')

subplot(2,2,1); 
stem(n,hd); title('Ideal Impulse Response')
axis([-1 N -0.2 0.8]); xlabel('n'); ylabel('hd(n)')

subplot(2,2,2); 
stem(n,w_kai);title('Kaiser Window')
axis([-1 N 0 1.1]); xlabel('n'); ylabel('w(n)')

subplot(2,2,3); 
stem(n,h);title('Actual Impulse Response')
axis([-1 N -0.2 0.8]); xlabel('n'); ylabel('h(n)')

subplot(2,2,4);
plot(w/pi,db);
title('Magnitude Response in dB');grid;
xlabel('frequency in pi units'); ylabel('Decibels')


%____________________________________________
% 
%   equiripple design
%
%____________________________________________

f = [0 0.30 0.67 1];
a = [1   0   1];
d = [1e-3  1e-3 1e-3];

[N,f0,a0,w] = firpmord(f,a,d);
N
be = firpm (N,f0,a0,w);
[db,mag,pha,grd,w] = myfreqz (be,[1]);

%____________________________________________
%
%   draw some pretty plots
%
%____________________________________________

% time

n=[0:1:N];

figure;
subplot(2,1,1);

subplot(2,1,1); 
stem(n,be);title('Actual Impulse Response')
axis([-1 N -0.2 0.8]); xlabel('n'); ylabel('h(n)')

subplot(2,1,2);
plot(w/pi,db);
title('Magnitude Response in dB');grid;
xlabel('frequency in pi units'); ylabel('Decibels')
