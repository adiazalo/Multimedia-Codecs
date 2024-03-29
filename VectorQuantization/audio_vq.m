function [Nbits, MSE] = audio_vq(infile, bitfile, outfile, M, N)
x = audioread(infile);
%codebook = std(x)*randn(M,N)+mean(x);
codebook = randn(M,N);

codebook = design_vq(x, codebook, 10^(-7), 1000);

save('vq_codebook','codebook');

[index,xq,MSE] = vq(x,codebook);

% counts = ones(1,length(index));
% i = 1;
% while i<(length(index) + 1)
%     counts(i) = length(find(index == i));
%     if counts(i) == 0
%         counts(i) = 1;
%     end
%     i = i + 1;
% end
counts = histcounts(index);
counts(counts<1) = 1;
save('vq_hist','counts');

whos index
Nbits = encArith(index,'vq_hist',bitfile);

clear index;
clear codebook;

index_dec = decArith('vq_hist',bitfile);
load('vq_codebook','codebook');
% De-quantizing signal
% xdq = codebook(index_dec);
xdq = ones(1,N*length(index_dec));
for g=1:length(index_dec)
    for h=1:N
        xdq((g-1)*N+h)=codebook(index_dec(g),h);
    end
end

disp(max(xq-xdq))
audiowrite(outfile,xdq,16000);

q=1:100;

plot(q,xdq(q))
hold on
plot(q,x(q))
hold off

clearvars -except Nbits MSE
