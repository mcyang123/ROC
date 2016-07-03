function auc=fast2roc2(x,y)
x = x(:);
y = y(:);
m=length(x); n=length(y);

z=[y;x];
R=tiedrank(z);
Rx=R(n+1:end)
rx=tiedrank(x)
auc=sum(Rx-rx)/m/n;