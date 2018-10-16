function [Nbits, MSE] = audio_vq(infile, bitfile, outfile, M, N)
x = audioread(infile);
codebook = randn(M,N);

codebook = design_vq(x, codebook, 10^(-7), 1000);

save('vq_codebook','codebook');

[index,xq,MSE] = vq(x,codebook);

counts = ones(1,length(index));
i = 1;
while i<(length(index) + 1)
    counts(i) = length(find(index == i));
    if counts(i) == 0
        counts(i) = 1;
    end
    i = i + 1;
end
save('vq_hist','counts');

Nbits = encArith(index,'vq_hist',bitfile);

clear index;
clear codebook;

index_dec = decArith('vq_hist',bitfile);
load('vq_codebook','codebook');
% De-quantizing signal
xdq = codebook(index_dec);
disp(max(xq-xdq));
audiowrite(outfile,xdq,16000);

clear index_dec;
clear xdq;
clear xq;
clear counts;
clear i;