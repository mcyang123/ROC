function plotroc_continuous(samples)
%ROCPLOT
% Guven samples drawn from continuous distrbutions, plot ROC curves. 
% 
% Edited by X. Sun.
% 2014/12

m = samples.spsizes(1);
n = samples.spsizes(2);

[~, sortindex] = sort(samples.ratings, 2, 'descend');

xi = sortindex <= m;
yi = ~xi;

tpr = cumsum(xi, 2) / m;
fpr = cumsum(yi, 2) / n;

plot(fpr', tpr');
axis equal;
axis([0, 1, 0, 1]);
xlabel('FPR');
ylabel('TPR');

end