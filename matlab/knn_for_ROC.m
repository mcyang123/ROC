function [probability,label_list] = knn_for_ROC(training,label,sample,k)
%%knn�㷨��matlabʵ�֣���Ҫ������ROC���ߵ��о�
% ����ѵ���������ݣ�training����ѵ��������ǩ��label�����������ݣ�sample����kֵ
%��k������ÿ������ֵk��������У�ÿ����������ռ�ȣ�����ÿһ��������k�������
%�����ռ���Լ���Ӧ�ı�ǩ�б�

label = label(:);
%---------------������Ϸ��Լ��-------------------
[r_t,c_t] = size(training);
[r_s,c_s] = size(sample);
[~,c_l] = size(label);
if c_l >1
    error('����ı�ǩ�������Ϸ���');  
elseif c_t ~= c_s 
    error('ѵ������������������һ�£�');
elseif k<1 || k > r_t
    error('kֵ����С��1��')
else
%----------------end-------------------------

%----------------���ɱ�ǩ�б�--------------------
    label_list = [];
    label_copy = label;
    while ~isempty(label_copy)
        label_list = [label_list,label_copy(1)];
        label_copy(label_copy == label_copy(1)) = '';
    end
%-------------------end-------------------------

%------------------�������---------------------
    distance = [];                                                         %sample * training���������
    probability = [];
    for i = 1:r_s                                                          %
        rep_sam = repmat(sample(i,:),r_t,1);                               %����һ��r_t�У�ÿһ�о�Ϊһ��������ľ������ں�ѵ�������
        d_matrix =  (rep_sam-training).^2;                                 %���������ƽ��
        distance = sum(d_matrix');                                         %����ÿһ��ѵ�����еĵ����ǰ������ľ��룬1*r_t����
        distance_sort = sort(distance);                                    
        label_temp = [];
        for j = 1:k
            index = find(distance_sort(j) == distance);                    %�ҳ�k������ĵ��Ӧ�ı�ǩ
            label_temp = [label_temp,label(index(1))];
        end
        probability_temp = [];
        for m = 1:length(label_list)                                       %ͳ��k������������������������أ�probability_tempΪÿһ��������k������ķֲ�
            num = length(find(label_temp == label_list(m)));
            probability_temp = [probability_temp,num/k];
        end
        probability = [probability;probability_temp];
    end
    
end
end

