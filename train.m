function araig = train( filename,k)
%��knn�����ݼ����з��࣬ͳ��Ƶ���ֲ�������ROC������AUC
%����Ϊ���ݼ�����
data = importdata( filename );
tra = data(:,1:end-1);
sam = tra;
label = data(:,end);
[p,label_list] = knn_for_ROC(tra,label,sam,k);
figure
hold on
color = ['r','g'];
for i = 1:length(label_list)
    index = find(label == label_list(i));
    x_temp = sort(p(index,i));
    y = [length(find(x_temp == x_temp(1)))];
    x = [x_temp(1)];
    for j = 2:length(x_temp)
        if x_temp(j) ~= x_temp(j-1)
            y = [y,length(find(x_temp == x_temp(j)))];
            x = [x,x_temp(j)];
        end
    end
    plot(x,y,'r','Color',color(i),'LineStyle','-')
end
end

