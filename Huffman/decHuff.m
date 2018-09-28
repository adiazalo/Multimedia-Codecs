function message_dec = decHuff(dictfile,infile)
load(dictfile, 'dict');
infile_fid = fopen(infile,'rb');
Nbits = fread(infile_fid, 1, 'ulong');
bitstream = fread(infile_fid, Nbits, 'ubit1');
fclose(infile_fid);

message_dec = huffmandeco(bitstream, dict);

clear dict;
clear bitstream;
clear Nbits;