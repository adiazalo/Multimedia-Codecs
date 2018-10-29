function img_dec = image_dct_dec(bitfile,outfile)

load('dct_hist','counts');
%load('img_header.hdr','quality');
%header_fid = fopen('img_header.hdr','r');
%imgR = fread(header_fid);
%load('img_header.hdr','imgR');
%load('img_header.hdr','imgC');

%hardcode values TEST
quality = 30;
min_index = -6.1994;

%load('img_header.hdr','min_index');
[qt, zag] = init_jpeg(quality);

for qIndex = 1:64
    qtZag = qt(find(zag==qIndex));
end

imgq_dec = decArith('dct_hist',bitfile);

%% inverse shifting

imgq = reshape(imgq_dec,[4096,64]);
imgq = imgq - round(abs(min_index));

%% inverse DICM
for rIndex = 2:64
    imgq(rIndex,1) = imgq(rIndex,1) + imgq(rIndex-1,1);
end

%% inverse DCT
tempBlock8x8 = ones(8);
inv_img = ones(512);
rIndex = 1;
cIndex = 1;
nextBlockNum = 1;
% for nextBlockNum = 1:64
%     vecq = imgq(nextBlockNum,:);
%     vec = vecq*qtZag;
%     
%     %inverse zig zag
%     for zIndex = 1:64
%         tempBlock8x8(find(zag==zIndex)) = vec(zIndex);
%     end
%     
%     %inverse DCT
%     for
%         inv_img(rIndex:rIndex+7,cIndex:cIndex+7) = tempBlock8x8;
%     end
%     rIndex = rIndex + 1;
%     cIndex = cIndex + 1;
% end
while rIndex<512
    while cIndex<512
        vecq = imgq(nextBlockNum,:);
        vec = vecq*qtZag;

        %inverse zig zag
        for zIndex = 1:64
            tempBlock8x8(find(zag==zIndex)) = vec(zIndex);
        end
        
        %inverse DCT
        inv_img(rIndex:rIndex+7,cIndex:cIndex+7) = tempBlock8x8;
        cIndex = cIndex + 8;
        
        nextBlockNum = nextBlockNum + 1;
    end
    cIndex = 1;
    rIndex = rIndex + 8;
end

x = linspace(0,1,256)';
map = [x x x];
img_dec = idct2(inv_img);
[r c] = size(img_dec)
%grayscaleImage = ind2rgb(img_dec, map);
imwrite(img_dec,map, outfile);


