function [Nbits,MSE] = uniform_sq(infile, bitfile, outfile, Nlevels)
x = audioread(infile);
xmin = min(x);
xmax = max(x);

stepsize = (xmax - xmin)/Nlevels;
partition = (xmin+stepsize):stepsize:(xmax-stepsize);
codebook = (xmin+stepsize/2):stepsize:(xmax-stepsize/2);

save('uq_codebook',codebook);

[index,xq,MSE] = quantiz(x,partition,codebook);

counts = '';
i = 1;
while i<(length(index) + 1)
    counts(i) = length(find(index(i)));
    if counts(i) == 0
        counts(i) = 1;
    end
end

save('uq_hist',counts);
Nbits = encArith(index,'uq_hist',bitfile);

clear index;
clear codebook;
clear partition;

index_dec = decArith('uq_hist',bitfile);

load('uq_codebook',codebook);
% De-quantizing signal
xdq = codebook(index_dec);
disp(max(xq-xdq));
audiowrite(xdq,16000,outfile);
clear Nbits;
clear MSE;





   

