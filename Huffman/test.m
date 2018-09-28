alphabet    = ['a' 'b' 'c' 'd' 'e' 'f'];
p = [.5 .125 .125 .125 .0625 .0625];
dict = huffmandict(num2cell(alphabet), p);
disp(dict)
class(dict)
sig = char( randsrc(1,10,[double(alphabet); p]) );
disp(sig)
class(sig)
comp = huffmanenco(sig,dict)
dsig = cell2mat(huffmandeco(comp,dict))
