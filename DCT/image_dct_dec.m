function img_dec = image_dct_dec(bitfile,outfile)
load('vq_hist','counts');
load('img_header.hdr','imgR');
load('img_header.hdr','imgC');
load('img_header.hdr','quality');
load('img_header.hdr','min_index');
[qt, zag] = init_jpeg(quality);

for qIndex = 1:64
    qtZag = qt(find(Zag==qIndex)); %or 2 for loops
end

x = linspace(0,1,256)';
map = [x x x];

imgq_dec = decArith('dct_hist',bitfile);

%% inverse shifting
imgq = reshape(imgq_dec,[64,64]);
imgq = imgq - abs(min_index);

%% inverse DICM
for rIndex = 2:64
    imgq(rIndex,1) = imgq(rIndex,1) + imgq(rIndex-1,1);
end

%% inverse DCT
tempBlock8x8 = ones(8);
inv_img = ones(512);
rIndex = 1;
cIndex = 1;
for nextBlockNum = 1:64
    vecq = imgq(nextBlockNum,:);
    vec = vecq*qtZag;
    
    %inverse zig zag
    for zIndex = 1:64
        tempBlock8x8(find(Zag==zIndex)) = vec(zIndex);
    end
    
    %inverse DCT
    for
        inv_img(rIndex:rIndex+7,cIndex:cIndex+7) = tempBlock8x8;
    end
    rIndex = rIndex + 1;
    cIndex = cIndex + 1;
end

inv_img = idct2(inv_img);
