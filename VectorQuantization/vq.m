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

index = zeros(1,xLength/N); %quantization bin indices

%quantize input signal x
xLowBound = 1;
xHighBound = N;
k = 1;

MSE_v = ones(1,M);
xq = ones(1,xLength);

while xHighBound < (xLength + 1) %go through x
    j = 1;
    while j < (M+1) % got though codebook rows
        xBlock = x(xLowBound:xHighBound);
        rowCodebook = codebook(j,:);
        
        MSE = (norm(xBlock(:)-rowCodebook(:),2).^2)/numel(xBlock);
        %MSE = immse(xBlock,rowCodebook);
        
        MSE_v(j) = MSE;
        j = j + 1; %go to next row
    end
    [minValue,minIndex] = min(MSE_v);
    xq(xLowBound:xHighBound) = codebook(minIndex,:);
    index(k) = minIndex;
    
    k = k + 1; %go to next index box
    xLowBound = xLowBound + N; %update x window
    xHighBound = xHighBound + N;
end

distor = (norm(x(:)-xq(:),2).^2)/numel(x);
%distor = immse(x,xq);


clear xLength;
clear x;
clear blockNum;
        
    