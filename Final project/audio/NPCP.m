function [ output ] = NPCP( wav,fs,fftSize,window)
%
% PART 2 : processing of the audio vector In the Fourier domain.
%_________________________________________________________
%
   xn = wav(1:fftSize);
   Y = fft(xn.*window);
   K = fftSize/2+1;
   Xn = abs(Y(1:K));
%--------Step 1 pick out the peak frequencies-------
f0 = 27.5;
%------Goal of the threshold:Get rid of the small amplitude note----
[pkt,fk] = findpeaks(Xn,'Threshold',max(Xn)*1e-2);
 FK = round(fk*fs/fftSize);
%---------Step 2: Assignment of peak frequencies to 
%-----------------------------semitones-------------------------  
   sm = round(12*log2(FK/f0));
   c = mod(sm,12)+1;
   r = 12*log2(FK/f0);
   output = zeros(12,1);
   for j = 1:12
       var = ismember(c,j);
       w = (cos(pi/2*r)).^2;
       output(j,1) = sum(var.*(w.*pkt.^2));
   end
%        for c = 1:12
% %--------Bring everything into the first octa
%        r = 12*log2(fk/f0) - sm; 
% %----------------Step 3:the pitch class profile:a weighted
%        if abs(r) < 1 & c == rem(sm,12);
%             w = (cos(pi/2*(r))).^2;
%             output(i,c) = w.*(pkt.^2);
%        else
%            output(i,c) = 0;
%        end
%        end

end

