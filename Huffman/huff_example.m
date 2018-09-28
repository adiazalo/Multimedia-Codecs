function [avglen_min, avglen_max] = huff_example()
symbols = (1:5); % Alphabet vector                               
prob = [.2 .4 .2 .1 .1]; % Symbol probability vector

%max var Huffman code
[dict_max, avglen_max] = huffmandict(symbols, prob, 2, 'max');
%get codewords
n = 1;
avgLength = 0;
while n<6
    code_max = dict_max{n,2}
    n=n+1;
end
% averge codeword length
code1_max = dict_max{1,2};
code2_max = dict_max{2,2};
code3_max = dict_max{3,2};
code4_max = dict_max{4,2};
code5_max = dict_max{5,2};
avgLength = (length(code1_max)*0.2)+(length(code2_max)*0.4)+(length(code3_max)*0.2)+(length(code4_max)*0.1)+(length(code5_max)*0.1);



%min var Huffman code
[dict_min, avglen_min] = huffmandict(symbols, prob, 2, 'min');
%get codewords
m = 1;
while m<6
    samplecode_min = dict_min{m,2};
    m=m+1;
end

% averge codeword length
code1_min = dict_min{1,2};
code2_min = dict_min{2,2};
code3_min = dict_min{3,2};
code4_min = dict_min{4,2};
code5_min = dict_min{5,2};
avgLength = (length(code1_min)*0.2)+(length(code2_min)*0.4)+(length(code3_min)*0.2)+(length(code4_min)*0.1)+(length(code5_min)*0.1);
