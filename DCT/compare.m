% I = imread('lena512.bmp');
% imwrite(I,'lena512_compressed.jpg','jpg','quality',90);
% D = imread('lena512_compressed.jpg');
% err = immse( I , D )

xDec = [25.3092 35.056 41.635 46.496 51.011 55.719 62.607 73.478 96.508];
yDec = [23.210 26.878 29.759 31.407 32.594 33.728 35.219 37.114 40.210];
xJ = [7.82 11.6 14.8 17.6 20.4 23.5 28.6 37.0 57.9];
yJ = [30.401 32.949 34.262 35.108 35.785 36.434 37.301 38.507 40.784];
plot(xDec,yDec,'r-o',xJ, yJ,'b-o')
xlabel('Total number of bytes (KB)');
ylabel('PSNR (dB)');
title('Operational rate-distortion curves');
legend({'Developed Codec','JPEG Codec'},'Location','southeast')
