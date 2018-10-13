function [Nbits,MSE] = uniform_sq(infile, bitfile, outfile, Nlevels)
x = audioread(infile);
xmin = min(x);
xmax = max(x);

stepsize = (xmax - xmin)/Nlevels;
partition = (xmin+stepsize):stepsize:(xmax-stepsize);
codebook = (xmin+stepsize/2):stepsize:(xmax-stepsize/2);

save 'uq_codebook' codebook;

[index,xq,MSE] = quantiz(x,partition,codebook);
index = index + 1;
index = index';
% disp(index(1:5))

% sample = ones(1,4);
% sample(1) = length(find(index == 1))
% sample(2) = length(find(index == 2))
% sample(3) = length(find(index == 3))
% sample(4) = length(find(index == 4))

counts = ones(1,length(index));
i = 1;
while i<(length(index) + 1)
    counts(i) = length(find(index == i));
    if counts(i) == 0
        counts(i) = 1;
    end
    i = i + 1;
end

save 'uq_hist' counts;

Nbits = encArith(index,'uq_hist',bitfile);

clear index;
clear partition;

index_dec = decArith('uq_hist',bitfile);

load('uq_codebook','codebook');
% De-quantizing signal
xdq = codebook(index_dec);
disp(max(xq-xdq));
%audiowrite(filename,y,Fs)
audiowrite('WEB16k_uq_8.wav',xdq,16000);
Nbits = length(index_dec);






   

