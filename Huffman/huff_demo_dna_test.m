function Nbits = huff_demo_dna_test(dna_infile, bitfile)
fid_dna_infile = fopen(dna_infile, 'rt');
message = fscanf(fid_dna_infile,'%[ABCDEFGHIJ]');
fclose(fid_dna_infile);

NumA = length(find(message=='A'));
NumB = length(find(message=='B'));
NumC = length(find(message=='C'));
NumD = length(find(message=='D'));
NumE = length(find(message=='E'));
NumF = length(find(message=='F'));
NumG = length(find(message=='G'));
NumH = length(find(message=='H'));
NumI = length(find(message=='I'));
NumJ = length(find(message=='J'));

%frequency of occurrance
freqA = NumA/length(message);
freqB = NumB/length(message);
freqC = NumC/length(message);
freqD = NumD/length(message);
freqE = NumE/length(message);
freqF = NumF/length(message);
freqG = NumG/length(message);
freqH = NumH/length(message);
freqI = NumI/length(message);
freqJ = NumJ/length(message);

roundA = round(freqA,1);
roundB = round(freqB,1);
roundC = round(freqC,1);
roundD = round(freqD,1);
roundE = round(freqE,1);
roundF = round(freqF,1);
roundG = round(freqG,1);
roundH = round(freqH,1);
roundI = round(freqI,1);
roundJ = round(freqJ,1);

symbols = {'A','B','C','D','E','F','G','H','I','J'};%cell array
prob = [roundA, roundB, roundC, roundD, roundE, roundF, roundG, roundH, roundI, roundJ];
dict = huffmandict(symbols, prob);
n=1;
%codewords
while n<11
    samplecode = dict{n,2};
    n=n+1;
end

% averge codeword length
codeA = dict{1,2};
codeB = dict{2,2};
codeC = dict{3,2};
codeD = dict{4,2};
codeE = dict{5,2};
codeF = dict{6,2};
codeG = dict{7,2};
codeH = dict{8,2};
codeI = dict{9,2};
codeJ = dict{10,2};
avgLength = (length(codeA)*roundA)+(length(codeB)*roundB)+(length(codeC)*roundC)+(length(codeD)*roundD)+(length(codeE)*roundE)+(length(codeF)*roundF)+(length(codeG)*roundG)+(length(codeH)*roundH)+(length(codeI)*roundI)+(length(codeJ)*roundJ)


dna_huffdict = 'dna_huffdict_test.mat';
save dna_huffdict_test dict;

%encocding message
encHuff(message,dna_huffdict,bitfile);
%decoding message
message_dec = decHuff(dna_huffdict,bitfile);
Nbits = length(message);
message_dec_char = char(message_dec);

fid = fopen('dec_testFile.txt','wt');
fprintf(fid, '%s', message_dec_char);
fclose(fid);

