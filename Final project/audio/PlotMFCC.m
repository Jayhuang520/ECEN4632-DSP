function [ output ] = PlotMFCC(mfcc)
    nf = floor(24*11025/256);
    output = zeros(40,517);
    for n = 1:256:nf*256
        output(n,:) = mfcc()
    end

end

