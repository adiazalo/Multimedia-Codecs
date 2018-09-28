function Nbits = idChar(dna_infile, bitfile)
fid_dna_infile = fopen(dna_infile, 'rt');
[message, Nletters] = fscanf(fid_dna_infile,'%c')
fclose(fid_dna_infile);

NumA = length(find(message=='A'));
NumC = length(find(message=='C'));
NumG = length(find(message=='G'));
NumT = length(find(message=='T'));
NumS = length(find(message==' '));
sum = NumA+NumC+NumG+NumT;

if (Sum == Nletter)
    disp('ok');
else
    disp('no ok');
    