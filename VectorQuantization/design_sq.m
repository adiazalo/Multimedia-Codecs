function [partition, codebook] = design_sq(training_set, codebook, tol, maxiter)
partition = (codebook(2 : length(codebook)) + codebook(1 : length(codebook)-1)) / 2;
[index, xq, MSE] = quantiz(training_set,partition,codebook);
iter = 1; %count number of iterations
dMSE = 10*tol+1; %hold the relative change in MSE between iterations
index = index';

%iterations
ind = '';
while (iter <= maxiter) && (dMSE > tol)
    for i = 1:(length(codebook))
        ind = find(index == (i-1));
        if ~isempty(ind)
            codebook(i) = mean(training_set(ind));
        end
        partition = (codebook(2 : length(codebook)) + codebook(1 : length(codebook)-1)) / 2;
    end
    [index, xq, newMSE] = quantiz(training_set,partition,codebook);
    dMSE = abs(newMSE-MSE)/MSE;
    MSE = newMSE;
    iter = iter + 1;
end

clear iter;
clear MSE;
clear dMSE;
clear index;
clear xq;
clear index;
clear training_set;
clear to1;

