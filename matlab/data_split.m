function  [data_out,label_list] = data_split( filename )
%��ȡ�ĵ��е����ݣ����䰴��ǩ����
%����Ϊ�ĵ�·����������������ݼ����ж������Ҫ�ж��ٸ������������
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

