function [Nbits, MSE] = image_vq(infile, bitfile, outfile, M, N1, N2)
[img,map] = imread(infile);
double img;
N = N1*N2;

ImgVector = im2col(img,[N1 N2],'distinct');
[r,c] = size(ImgVector);

temp_ir = randi([1 c],1,M);
ir = ceil(temp_ir);

j = 1;
codebook = ones(M,r);
while j < (M+1)
    k = ir(j);
    codebook(j,:) = ImgVector(:,k)';
    j = j + 1;
end

      
x = ones(1,c*r);
%temp_x = ones(1,r);
i = 1;
lowBound = 1;
highBound = r;
while i < (c+1)
    temp_x = ImgVector(:,i);
    x(lowBound:highBound) = temp_x';
    i = i + 1;
    lowBound = lowBound + r;
    highBound = highBound + r;
end

codebook = design_vq(x, codebook, 10^(-7), 1);
save('vq_codebook','codebook');
[index,xq,MSE] = vq(x,codebook);
counts = ones(1,length(index));

while i<(length(index) + 1)
    counts(i) = length(find(index == i));
    if counts(i) == 0
        counts(i) = 1;
    end
    i = i + 1;
end

save('vq_hist','counts');

Nbits = encArith(index,'vq_hist',bitfile);

clear index;
clear codebook;

index_dec = decArith('vq_hist',bitfile);
load('vq_codebook','codebook');

% De-quantizing signal
xdq = codebook(index_dec);
%disp(max(xq-xdq));
C = ceil(length(xdq)/N);
ImgVectordq = ones(N,C);

%filling ImgVectordq with xdq elements
xdqLowerBound = 1;
xdqHigherBound = N;
for k = 1:C
    xdqColumn = xdq(xdqLowerBound:xdqHigherBound)';
    ImgVectordq(:,k) = xdqColumn;
    xdqLowerBound = xdqLowerBound + N;
    xdqHigherBound = xdqHigherBound + N;
end
imgdq = col2im(ImgVectordq,[N1,N2],[512,512],'distinct');
imwrite(uint8(imgdq),map,outfile,'BMP');

clear index_dec;
clear xdq;
clear ImgVector;
clear ImgVectordq;
clear j;
clear i;
clear k;
clear imgdq;
clear counts;
