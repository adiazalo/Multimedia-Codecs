I = imread('lena512.bmp');

ssimValues = zeros(1,6);
qualityFactor = 30:10:80;
for i = 1:6

    imwrite(I,'lena512_compressed.bmp','jpg','quality',qualityFactor(i));
    
    ssimValues(i) = ssim(imread('lena512_compressed.bmp'),I);
end

plot(qualityFactor,ssimValues,'b-o');

xlabel('Compression Quality Factor');
ylabel('SSIM Value');