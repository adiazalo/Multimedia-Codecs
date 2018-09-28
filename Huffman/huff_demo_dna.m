function Nbits = huff_demo_dna(dna_infile, bitfile)
fid_dna_infile = fopen(dna_infile, 'rt');
message = fscanf(fid_dna_infile,'%[ACGT]');
fclose(fid_dna_infile);

NumA = length(find(message=='A'));
NumC = length(find(message=='C'));
NumG = length(find(message=='G'));
NumT = length(find(message=='T'));

%frequency of occurrance
freqA = NumA/length(message);
freqC = NumC/length(message);
freqG = NumG/length(message);
freqT = NumT/length(message);

roundA = round(freqA,1);
roundC = round(freqC,1);
roundG = round(freqG,1);
roundT = round(freqT,1);

symbols = {'A','C','G','T'};%cell array
prob = [roundA, roundC, roundG, roundT];
dict = huffmandict(symbols, prob);
n=1;
%codewords
while n<5
    samplecode = dict{n,2};
    n=n+1;
end

% averge codeword length
codeA = dict{1,2};
codeC = dict{2,2};
codeG = dict{3,2};
codeT = dict{4,2};
avgLength = (length(codeA)*roundA)+(length(codeC)*roundC)+(length(codeG)*roundG)+(length(codeT)*roundT)


dna_huffdict = 'dna_huffdict.mat';
save dna_huffdict dict;

%encocding message
encHuff(message,dna_huffdict,bitfile);
%decoding message
message_dec = decHuff(dna_huffdict,bitfile);
Nbits = length(message);
message_dec_char = char(message_dec);

fid = fopen('dec_chr21.txt','wt');
fprintf(fid, '%s', message_dec_char);
fclose(fid);

