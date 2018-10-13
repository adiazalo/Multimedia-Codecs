function [index, xq, distor] = vq(x, codebook)
[M,N] = size(codebook);
xNumRows = size(x,1);
if xNumRows > 1
    x = x';
end

xLength = length(x);

%adding zeros until xLength is multiple of N
while mod(xLength,N) ~= 0
    x = [x, zeros(1,1)];
    xLength = length(x);
end

index = zeros(1,length(x)/N); %quantization bin indices
blockNum = length(index);

%quantize input signal x
for i = 1:blockNum
end

distor = immse(x,xq);

clear xLength;
clear x;
clear blockNum;
        
    