function Nbits = arith_demo_dnaTest(dna_infile, bitfile)
dna_infile_fid = fopen(dna_infile,'rt');
message = fscanf(dna_infile_fid,'%[ACGT]');
fclose(dna_infile_fid);

CountA = length(find(message=='A'));
CountC = length(find(message=='C'));
CountG = length(find(message=='G'));
CountT = length(find(message=='T'));

counts = [CountA CountC CountG CountT];
dna_histTest = 'dna_histTest.mat';
save dna_histTest counts;

%mapping characters to numbers
index = length(message);
j = 1;
message_int = zeros(336980,1);
while j < (index+1)
    if message(j) == 'A'
        message_int(j) = 1;
    elseif message(j) == 'C'
        message_int(j) = 2;
    elseif message(j) == 'G'
        message_int(j) = 3;
    elseif message(j) == 'T'
        message_int(j) = 4;
    end
    j = j+1;
end

encArith(message_int,dna_histTest,bitfile);
clear message;
clear message_int;

message_dec_int = decArith(dna_histTest,bitfile);

%mapping numbers back to characters
index_dec= length(message_dec_int);
k = 1;
message_dec = '';
while k < (index_dec+1)
    if message_dec_int(k) == 1
        message_dec(k) = 'A';
    elseif message_dec_int(k) == 2
        message_dec(k) = 'C';
    elseif message_dec_int(k) == 3
        message_dec(k) = 'G';
    elseif message_dec_int(k) == 4
        message_dec(k) = 'T';
    end
    k = k+1;
end

Nbits = length(message_dec);
decTest_chr21_fid = fopen('decTest_chr21.txt','wt');
fprintf(decTest_chr21_fid,'%s',message_dec);
fclose(decTest_chr21_fid);

clear k
clear j
clear CountA
clear CountC
clear CountG
clear CountT
clear counts
clear message_dec_int
clear message_dec
clear index
clear index_dec