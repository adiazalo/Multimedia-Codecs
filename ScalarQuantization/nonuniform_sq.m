function [Nbits, MSE] = nonuniform_sq (infile, bitfile, outfile, Nlevels)
x = audioread(infile);
%x = sin([0:1000]*pi/500);
xmin = min(x);
xmax = max(x);

stepsize = (xmax - xmin)/Nlevels;
partition = (xmin+stepsize):stepsize:(xmax-stepsize);
codebook = (xmin+stepsize/2):stepsize:(xmax-stepsize/2);

%[partition, codebook] = lloyds(x,codebook,10^(-7), 100)
[partition, codebook] = design_sq(x, codebook, 10^(-7), 1000);

%step 4
save 'nuq_codebook' codebook;

[index,xq,MSE] = quantiz(x,partition,codebook);
index = index + 1;

counts = ones(1,length(index));
i = 1;
while i<(length(index) + 1)
    counts(i) = length(find(index == i));
    if counts(i) == 0
        counts(i) = 1;
    end
    i = i + 1;
end

%step 7
save 'nuq_hist' counts;
index = index';
Nbits = encArith(index,'nuq_hist',bitfile);

clear index;
clear partition;

index_dec = decArith('nuq_hist',bitfile);
load('nuq_codebook','codebook');

% De-quantizing signal
xdq = codebook(index_dec);
disp(max(xq-xdq));
%audiowrite(filename,y,Fs)
audiowrite('WEB16k_nuq_8.wav',xdq,16000);
Nbits = length(index_dec);



