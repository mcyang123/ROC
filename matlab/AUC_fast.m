function AUC = AUC_fast( x,y )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
m = length(x);
n = length(y);
x_y = [x,y]
x_y_sort = sort(x_y);
delete_index_temp = diff(x_y_sort);
delete_index = find(delete_index_temp == 0);
x_y_sort(delete_index) = []
a = [];
c = [];
for i = x_y_sort
    a = [a,length(find(x == i))];
    c = [c,length(find(y == i))];
end
a
c
s1 = sum(a.*c)
s2 = 0;
for i = 2:length(a)
    s2 = s2+sum(a(i)*c(1:i-1));
end
s2
theta = (0.5*s1+s2)/(m*n)
end

