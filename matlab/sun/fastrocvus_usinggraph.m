function vus = fastrocvus_usinggraph(data)
%FASTROCVUS_USINGGRAPH gets the value of the volume under the ROC surface 
%using graph method which is introduced by Willem Waegeman et.al.
%   Detailed explanation goes here
%   Input: 
%           data is a structure (can be created by conductData.m), where
%               data.x gives the projected data points
%               data.c gives the sizes for each class
%               data.y gives the corresponding class of the data points
%
% Edited by X. Sun
% Version: 2014/8/29

if sum(data.c) ~= length(data.x)
    error('The Input data is not matched with each other!');
end

totalNum = sum(data.c);
classNum = length(data.c);

[~, si] = sort(data.x);
data.y = data.y(si);

fai =  zeros(1, classNum);

for j = 1 : totalNum
    k = data.y(j);
    if k == 1
        fai(1) = fai(1) + 1;
    else
        fai(k) = fai(k) + fai(k - 1);
    end
end

vus = fai(classNum) / prod(data.c);