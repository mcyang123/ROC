function  [data_out,label_list] = data_split( filename )
%读取文档中的数据，将其按标签分离
%输入为文档路径，输出分类后的数据集，有多少类就要有多少个接收输出变量
data = importdata(filename);
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
end

