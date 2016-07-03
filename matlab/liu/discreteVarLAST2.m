
function[ theta , var ]=discreteVarLAST2(x,y)
% Extract negertive and positive class from original data
x = x(:);
y = y(:);
m = length(x);
n = length(y);
z = [x; y];
c = [m; n];
M = countrate(z, c);
B = M(1, :);
A = M(2, :);
D = A;                                        %A=Y ,B=X
m = numel( x );
n = numel( y );
C = A .* B;
s1 = sum( C )    ;                                %X=Y�Ĵ���
D = cumsum( D );
M = cumsum( B );
F = B( 2 : end ).* D( 1 : end-1 );
s2 = sum(F);                                  %X>Y�Ĵ���
s0 = sum( A( 2 : end ) .*M ( 1:end-1 ));               %Y>X�Ĵ���
theta = (0.5*s1+s2)/m/n;   
 %�����ֵ
%%
Q0 = (s2+0.25*s1)/m/n-theta^2;                    %��Q0
%%
G = cumsum(A(2:end).*D(1:end-1));
s3 = sum(G(1:end-1).*B(3:end));%X>Y>Y'�Ĵ�����X>Y'>Y�Ĵ���
H = cumsum(A.*A);
s4 = sum(H(1:end-1).*B(2:end));%X>Y=Y'�Ĵ���
I = A.*B;
s5 = sum(D(1:end-1).*I(2:end));%X=Y'>Y��X=Y>Y'�Ĵ���
s6 = sum(A.*A.*B);             %X=Y=Y'�Ĵ��� 
Q1 = (2*s3+s4-s2+s5+0.25*(s6-s1))/m/n/(n-1)-theta^2;%��Q1
%%
J = B;
J = cumsum(J);
K = cumsum(B(2:end).*J(1:end-1));
s7 = sum(K(1:end-1).*A(3:end));%Y>X>X'�Ĵ�����Y>X'>X�Ĵ���
L = cumsum(B.*B);
s8 = sum(L(1:end-1).*A(2:end));%Y>X=X'�Ĵ���
s9 = sum(J(1:end-1).*I(2:end));%Y=X'>X��Y=X>X'�Ĵ���
s10=sum(B.*B.*A);%Y=X=X'�Ĵ���
Q2 = (2*s7+s8-s0+s9+0.25*(s10-s1))/n/m/(m-1)-(1-theta)^2;%��Q2
%%
var = (Q0+(n-1)*Q1+(m-1)*Q2)/(m-1)/(n-1);
end

