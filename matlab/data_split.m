function  varargout = data_split(data,method)
%读取文档中的数据，将其按标签分离
%输入为文档路径，输出分类后的数据集，有多少类就要有多少个接收输出变量
if strcmp(method,'class')                                                       %按数据类型分开
    [~,c] = size(data);
    label = data(:,c);
    label_list = [];
    while ~isempty(label) 
        label_list = [label_list,label(1)];
        label(label == label(1)) = '';
    end
    data_out = cell(1,length(label_list));
    j = 1;
    for i = label_list
        data_out{j} = data(data(:,c) == i,1:c-1);
        j = j+1;
    end
    varargout{1} = data_out;
    varrgout{2} = label_list;
    
elseif length(method)== 11 && strcmp(method(1:end-3),'hold_out')            % m%留出法，m为一个两位整数 1%<m<50%
    per = str2num(method(end-1:end))/100;
    [r,c] = size(data);
    sample_amount = floor(r*per);
    rand_list = randperm(r);
    sample_index = rand_list(1:sample_amount);
    sample = data(sample_index,1:end-1);
    training_index = rand_list(sample_amount+1:end);
    training = data(training_index,1:end-1);
    label = data(training_index,end);
    label_true = data(sample_index,end);
    varargout{1} = training;
    varargout{2} = sample;
    varargout{3} = label;
    varargout{4} = label_true;
    
elseif strcmp(method,'cross')
    r,c = size(data);
    cluster_amount = floor(r*0.1);
    data_set = cell(10,1);
    data_copy = data;
    for i = 1:9
        rand_list = randperm(length(data_copy));
        index = rand_list(1:cluster_amount);
        data_set{i} = data_copy(index);
        data_copy(index) = ''; 
    end
    data_set{10} = data_copy;
    varargout = data_set;
else
    error('data_split error');
end
end

