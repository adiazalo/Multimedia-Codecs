function write_Yframe(frameY, outfile)
%append the frame in frameY to the end of outfile

%convert to column vector
frameY = frameY(:);
outfile_fid = fopen(outfile,'a');
fwrite(outfile_fid,frameY,'ubit8');
close(outfile_fid);