function [probability,label_list] = knn_for_ROC(training,label,sample,k)
%%knn算法的matlab实现，主要服务于ROC曲线的研究
% 输入训练样本数据（training），训练样本标签（label），样本数据（sample），k值
%（k）计算每个样本值k阶最近邻中，每个分类的组成占比，返回每一个样本点k领域里，各
%个类的占比以及对应的标签列表

label = label(:);
%---------------作输入合法性检查-------------------
[r_t,c_t] = size(training);
[r_s,c_s] = size(sample);
[~,c_l] = size(label);
if c_l >1
    error('输入的标签向量不合法！');  
elseif c_t ~= c_s 
    error('训练集合样本集列数不一致！');
elseif k<1 || k > r_t
    error('k值不能小于1！')
else
%----------------end-------------------------

%----------------生成标签列表--------------------
    label_list = [];
    label_copy = label;
    while ~isempty(label_copy)
        label_list = [label_list,label_copy(1)];
        label_copy(label_copy == label_copy(1)) = '';
    end
%-------------------end-------------------------

%------------------计算距离---------------------
    distance = [];                                                         %sample * training，距离矩阵
    probability = [];
    for i = 1:r_s                                                          %
        rep_sam = repmat(sample(i,:),r_t,1);                               %产生一个r_t行，每一行均为一个样本点的矩阵，由于和训练集相减
        d_matrix =  (rep_sam-training).^2;                                 %相减并计算平方
        distance = sum(d_matrix');                                         %计算每一个训练集中的点带当前样本点的距离，1*r_t向量
        distance_sort = sort(distance);                                    
        label_temp = [];
        for j = 1:k
            index = find(distance_sort(j) == distance);                    %找出k阶里面的点对应的标签
            label_temp = [label_temp,label(index(1))];
        end
        probability_temp = [];
        for m = 1:length(label_list)                                       %统计k阶邻域里各类的数量，计算比重，probability_temp为每一个样本点k阶邻域的分布
            num = length(find(label_temp == label_list(m)));
            probability_temp = [probability_temp,num/k];
        end
        probability = [probability;probability_temp];
    end
    
end
end

