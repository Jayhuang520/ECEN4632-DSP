clear all;close all;clc;
%%%%%%%%%%%%%Final project part I From the wav file to the psychoacoustic
%%%%%%%%%%%%%features
%%--------------use dir **/*.wav to list all the wav file in the directory
%tic
filename = {'track201-classical.wav','track204-classical.wav',...
    'track370-electronic.wav','track396-electronic.wav',...
    'track437-jazz.wav','track439-jazz.wav',...
    'track463-metal.wav','track492-metal.wav',...
    'track547-rock.wav','track550-rock.wav',...
    'track707-world.wav','track729-world.wav'};
% filename = {'piano-chrom.wav'};    
  for fileIndex = 1:12
     [song,fs] = audioread(char(filename(fileIndex)));
%     [song,fs] = audioread(char(filename));
    %%%% audio files are sampled at fs = 11025 Hz
    %sound(song,fs)

    %%%%%%--------------initialization----------------------
     SongLength = length(song);
     Mid = floor(SongLength/2);
    %%%%-----------------------Part 1-------------------------------
    %% Extract 24 seconds of music from a given track.
%      xn = song(Mid:Mid+12*fs-1);
    w = hann(2048);
    fftsize = 2048; %%%%Size of fft
    nf = floor(12*11025/fftsize/2);
    index = 1;
  %%%%%% nbank = 40
%     output = zeros(40,nf);
%----------Part I of the project-------------------
%     for n = 1:256:(nf-1)*256
%         output(:,index) = mfcc(xn(n:n+fftsize-1),fs,fftsize,w);
%         index = index + 1;
%     end
%----------end of part I of the project-------------
output = zeros(12,nf);
    for n = 1:fftsize/2:floor(length(song)-2048)
        output(:,index) = NPCP(song(n:n+fftsize-1),fs,fftsize,w);
        index = index + 1;
    end

    %%%%%%%Take 20log10 of your output,
    %use flipud 

    %output = flipud(output);
    output = 20*log10(output/max(max(song)));

    figure
    imagesc(output);
    title(filename(fileIndex));
    set(gca,'YDir','normal');
    set(gca,'YTick',[1:12]);
    set(gca,'YTickLabel',({'A';'A#';'B';'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#'}))
    xlabel('Frames');
    ylabel('Filter Bank');
    colormap jet
    colorbar
  end
%toc