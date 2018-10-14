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
% for i = 1:blockNum
% end
i = 1;
j = 1;
xq = ones(1,N);
while i < (xLength + 1) %go through x
    while j < (M+1) % got though codebook rows
        blockX = x(i:(i+N));
        rowCodebook = codebook(j,:);
        MSE = immse(blockX,rowCodebook);
        if j = 1
            xq(i) = MSE; % not right?
        elseif MSE < xq(i-1)
            xq(i-1) = MSE;
        end
        j = j + 1;
    end
    i = i + N;
end

distor = immse(x,xq);

clear xLength;
clear x;
clear blockNum;
        
    