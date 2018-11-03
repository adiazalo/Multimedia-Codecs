function frameY = read_Yframe (infile, height, width, frame_index)
infile_fid = fopen(infile,'r');
skipBytes =  height*width*(frame_index-1);
readBytes = height*width
readData = fread(infile_fid,readBytes,'uint8',1); %check if precision is correct. uint8 since it is grayscale
size(readData)
%Convert into matrix. How? depends size of readData



frameY = double(readData);
fclose(infile_fid);

clearvars -except frameY;
