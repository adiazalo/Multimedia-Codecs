function Nbits = image_dct_enc(infile,bitfile,quality)
[qt, zag] = init_jpeg(quality);
imgDouble_512x512 = im2double(imread(infile));
imgDouble_512x512 = imgDouble_512x512 - 128;

%%%D = dctmtx(8); %Calculate the discrete cosine transform matrix
%%%dct = @(block_struct) D * block_struct.data * D';
%processes the image imgDouble by applying the function dct to each distinct block of size 8x8 and concatenating the results into the output matrix, B.
%%%imgDTC_512x512 = blockproc(imgDouble_512x512,[8,8],dct); 

imgq_64x64 = ones(64);

cIndex = 1;
rIndex = 1;
vec_1x64 = ones(1,64);
vecq_1x64 = ones(1,64);
imgq_4096x64 = ones(4096,64);

% for qIndex = 1:64
%     qtZag(qIndex) = qt(find(zag==qIndex)); %or 2 for loops
% end

%% loop through the image extracting non-overlapping 8x8 blocks
disp("loop through the image extracting non-overlapping 8x8 blocks")
nextblockNum = 1;
while rIndex<512
    while cIndex<512
        
        % transform the block using 8x8 DCT
        tempBlock8x8 =  imgDTC_512x512(rIndex:rIndex+7,cIndex:cIndex+7);

        %convert it to a vector of length 64 using zig zag scan
        for zIndex = 1:64
            vec_1x64(zIndex) = tempBlock8x8(find(zag==zIndex));
        end

        %quantize it using JPEG-like quantizers
        for qIndex = 1:64
            vecq_1x64(qIndex) = round(vec_1x64(qIndex)/qt(qIndex));
        end
        %store it as a row in a matrix called imgq
        imgq_4096x64(nextblockNum,:)=vecq_1x64; 
        nextblockNum = nextblockNum + 1;
        cIndex = cIndex + 8;
    end
    cIndex = 1;
    rIndex = rIndex + 8;
end
[r_vecq, c_vecq] = size(vecq_1x64)
 [r_imgqB, c_imgqB] = size(imgq_4096x64)
%% differential pulse code modulation
disp("differential pulse code modulation")
for rIndex=2:64
    imgq_4096x64(rIndex,1) = imgq_4096x64(rIndex,1) - imgq_4096x64(rIndex-1,1);
end

%% shifting
disp("shifting")
%disp(imgq_4096x64(1:10))
min_index = min(min(imgq_4096x64))
imgq_4096x64 = abs(min_index) + imgq_4096x64 + 1;

imgq_1x262144 = reshape(imgq_4096x64, [], 1)';
%[r_imgq, c_imgq] = size(imgq_1x262144)
imgq_1x262144 = round(imgq_1x262144);

%% header info
disp("header info")
header_fid = fopen('img_header.hdr','w');
[imgR,imgC] = size(imgDouble_512x512);
fwrite(header_fid,[imgR imgC],'uint16');
fwrite(header_fid, quality, 'uint8');
fwrite(header_fid,min_index,'int16');
fclose(header_fid);

%% arith encoding
disp("arith encoding")
%disp(imgq_1x262144(1:100))
minValue = min(imgq_1x262144)
maxValue = max(imgq_1x262144)
counts = zeros(1,maxValue);
for scan = 1:262144
    scanValue = imgq_1x262144(scan);
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1;
save('dct_hist','counts');
save('img_header.hdr','quality');
Nbits = encArith(imgq_1x262144,'dct_hist',bitfile);

clearvars -except Nbits;