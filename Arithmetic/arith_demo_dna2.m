function Nbits = arith_demo_dna2(dna_infile, bitfile)
dna_infile_fid = fopen(dna_infile,'rt');
message = fscanf(dna_infile_fid,'%[ACGT]');
fclose(dna_infile_fid);

% CountAA = length(strfind(message,'AA'));
% CountAC = length(strfind(message,'AC'));
% CountAG = length(strfind(message,'AG'));
% CountAT = length(strfind(message,'AT'));
% 
% CountCA = length(strfind(message,'CA'));
% CountCC = length(strfind(message,'CC'));
% CountCG = length(strfind(message,'CG'));
% CountCT = length(strfind(message,'CT'));
% 
% CountGA = length(strfind(message,'GA'));
% CountGC = length(strfind(message,'GC'));
% CountGG = length(strfind(message,'GG'));
% CountGT = length(strfind(message,'GT'));
% 
% CountTA = length(strfind(message,'TA'));
% CountTC = length(strfind(message,'TC'));
% CountTG = length(strfind(message,'TG'));
% CountTT = length(strfind(message,'TT'));

CountAA = 0;
CountAC = 0;
CountAG = 0;
CountAT = 0;

CountCA = 0;
CountCC = 0;
CountCG = 0;
CountCT = 0;

CountGA = 0;
CountGC = 0;
CountGG = 0;
CountGT = 0;

CountTA = 0;
CountTC = 0;
CountTG = 0;
CountTT = 0;

%mapping characters to numbers and counting pairs
index = length(message)
disp(message)
j = 1;
n = 1;
message_int = zeros(1,168490);
while j < (index+1)
    if message(j:(j+1)) == 'AA'
        message_int(n) = 1;
        CountAA = CountAA + 1;
    elseif message(j:(j+1)) == 'AC'
        message_int(n) = 2;
        CountAC = CountAC + 1;
    elseif message(j:(j+1)) == 'AG'
        message_int(n) = 3;
        CountAG = CountAG + 1;
    elseif message(j:(j+1)) == 'AT'
        message_int(n) = 4;
        CountAT = CountAT + 1;
    elseif message(j:(j+1)) == 'CA'
        message_int(n) = 5;
        CountCA = CountCA + 1;
    elseif message(j:(j+1)) == 'CC'
        message_int(n) = 6;
        CountCC = CountCC + 1;
    elseif message(j:(j+1)) == 'CG'
        message_int(n) = 7;
        CountCG = CountCG + 1;
    elseif message(j:(j+1)) == 'CT'
        message_int(n) = 8;
        CountCT = CountCT + 1;
    elseif message(j:(j+1)) == 'GA'
        message_int(n) = 9;
        CountGA = CountGA + 1;
    elseif message(j:(j+1)) == 'GC'
        message_int(n) = 10;
        CountGC = CountGC + 1;
    elseif message(j:(j+1)) == 'GG'
        message_int(n) = 11;
        CountGG = CountGG + 1;
    elseif message(j:(j+1)) == 'GT'
        message_int(n) = 12;
        CountGT = CountGT + 1;
    elseif message(j:(j+1)) == 'TA'
        message_int(n) = 13;
        CountTA = CountTA + 1;
    elseif message(j:(j+1)) == 'TC'
        message_int(n) = 14;
        CountTC = CountTC + 1;
    elseif message(j:(j+1)) == 'TG'
        message_int(n) = 15;
        CountTG = CountTG + 1;
    elseif message(j:(j+1)) == 'TT'
        message_int(n) = 16;
        CountTT = CountTT + 1;
    end
    n = n+1;
    j = j+2;

end

counts = [CountAA CountAC CountAG CountAT CountCA CountCC CountCG CountCT CountGA CountGC CountGG CountGT CountTA CountTC CountTG CountTT];
dna_hist2 = 'dna_hist2.mat';
save dna_hist2 counts;

encArith(message_int,dna_hist2,bitfile);
clear message;
clear message_int;

message_dec_int = decArith(dna_hist2,bitfile);

%mapping numbers back to characters
index_dec= length(message_dec_int)
n = 1;
k = 1;
message_dec = '';
while n < (index_dec+1)
    if message_dec_int(n) == 1
        message_dec(k:(k+1)) = 'AA';
    elseif message_dec_int(n) == 2
        message_dec(k:(k+1)) = 'AC';
    elseif message_dec_int(n) == 3
        message_dec(k:(k+1)) = 'AG';
    elseif message_dec_int(n) == 4
        message_dec(k:(k+1)) = 'AT';
    elseif message_dec_int(n) == 5
        message_dec(k:(k+1)) = 'CA';
    elseif message_dec_int(n) == 6
        message_dec(k:(k+1)) = 'CC';
    elseif message_dec_int(n) == 7
        message_dec(k:(k+1)) = 'CG';
    elseif message_dec_int(n) == 8
        message_dec(k:(k+1)) = 'CT';
    elseif message_dec_int(n) == 9
        message_dec(k:(k+1)) = 'GA';
    elseif message_dec_int(n) == 10
        message_dec(k:(k+1)) = 'GC';
    elseif message_dec_int(n) == 11
        message_dec(k:(k+1)) = 'GG';
    elseif message_dec_int(n) == 12
        message_dec(k:(k+1)) = 'GT';
    elseif message_dec_int(n) == 13
        message_dec(k:(k+1)) = 'TA';
    elseif message_dec_int(n) == 14
        message_dec(k:(k+1)) = 'TC';
    elseif message_dec_int(n) == 15
        message_dec(k:(k+1)) = 'TG';
    elseif message_dec_int(n) == 16
        message_dec(k:(k+1)) = 'TT';
    end
    n = n+1
    k = k+2;
end

Nbits = length(message_dec);
dec2_chr21_fid = fopen('dec2_chr21.txt','wt');
fprintf(dec2_chr21_fid,'%s',message_dec);
fclose(dec2_chr21_fid);

clear n
clear k
clear CountAA
clear CountAC
clear CountAG
clear CountAT
clear CountCA
clear CountCC
clear CountCG
clear CountCT
clear CountGA
clear CountGC
clear CountGG
clear CountGT
clear CountAT
clear CountCT
clear CountGT
clear CountTT
clear index_dec
