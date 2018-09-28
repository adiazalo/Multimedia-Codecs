function Nbits = encHuff(message, dictfile, outfile)
load(dictfile, 'dict');
disp(dict);
class(dict);
disp(message);
class(message);
message_enc = huffmanenco(message, dict);%encoding message
Nbits = length(message_enc);
outfile_fid = fopen(outfile, 'wb');
fwrite(outfile_fid, Nbits, 'ulong');
fwrite(outfile_fid, message_enc, 'ubit1');
fclose(outfile_fid);
clear dict;
clear message_enc;

