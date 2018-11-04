function frameY = read_Yframe (infile, height, width, frame_index)
infile_fid = fopen(infile,'r');
skipBytes =  height*width*(frame_index-1);
readData = fread(infile_fid,[height,width],'uint8',uint8(skipBytes)); %uint8 bytes
frameY = double(readData);
fclose(infile_fid);

clearvars -except frameY;
