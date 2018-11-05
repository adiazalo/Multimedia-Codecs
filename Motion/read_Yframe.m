function frameY = read_Yframe (infile, height, width, frame_index)
% infile_fid = fopen(infile,'r');
% skipBytes =  height*width*(frame_index-(1))
% readData = fread(infile_fid,[height,width],'uint8',uint8(skipBytes)); %uint8 bytes
% whos readData
% fclose(infile_fid);
% frameY = double(readData);
% clearvars -except frameY;

infile_fid = fopen(infile,'r','b');
stream = fread(infile_fid,'*uchar');
length = 1 * width * height;

frames = uint8(zeros(height,width));

for iFrame = 1:frame_index
    frame = stream((iFrame-1)*length+1:iFrame*length);
    yImage = reshape(frame(1:width*height), width, height)';
    frames(:,:,iFrame) = uint8(yImage);
end
frameY = frames(:,:,frame_index);
frameY = double(frameY);
fclose(infile_fid);
clearvars -except frameY;
