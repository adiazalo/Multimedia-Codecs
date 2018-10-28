function Nbits = image_dct_enc(infile,bitfile,quality)
[qt, zag] = init_jpeg(quality);
imgDouble = im2double(imread(infile));
imgDouble = imgDouble - 128;

D = dctmtx(8); %Calculate the discrete cosine transform matrix
dct = @(block_struct) D * block_struct.data * D';

%processes the image imgDouble by applying the function dct to each distinct block of size 8x8 and concatenating the results into the output matrix, B.
imgDTC = blockproc(imgDouble,[8,8],dct); 
imgq = ones(64);

cIndex = 1;
rIndex = 1;
vec = ones(1,64);

for qIndex = 1:64
    qtZag = qt(find(Zag==qIndex)); %or 2 for loops
end

%% loop through the image extracting non-overlapping 8x8 blocks
for nextblockNum = 1:64
    % transform the block using 8x8 DCT
    for k=1:8:64
        for 
        tempBlock8x8 =  imgDTC(rIndex:rIndex+7,cIndex:cIndex+7); 
    end
    %convert it to a vector of length 64 using zig zag scan
    for zIndex = 1:64
        vec(zIndex) = tempBlock8x8(find(Zag==zIndex));
    end
    
    %quantize it using JPEG-like quantizers
    vecq = vec/qtZag;

    %store it as a row in a matrix called imgq
    imgq(nextblockNum,:)=vecq; 
    
    rIndex = rIndex + 8;
    cIndex = cIndex + 8;
end
  
%% differential pulse code modulation
for rIndex=2:64
    imgq(rIndex,1) = imgq(rIndex,1) - imgq(rIndex-1,1);
end

%% shifting
min_index = min(min(imgq));
imgq = abs(min_index) + imgq;
imgq = reshape(imgq, [], 1)';

%% header info
header_fid = fopen('img_header.hdr','wb');
[imgR,imgC] = size(imgDouble);
fwrite(header_fid,[imgR imgC],'uint16');
fwrite(header_fid, quality, 'uint8');
fwrite(header_fid,min_index,'int16');
fclose(header_fid);

%% arith encoding
counts = histcounts(imgq);
counts(counts<1) = 1;
save('vq_hist','counts');
Nbits = encArith(imgq,'dct_hist',bitfile);

clearvars -except Nbits;