function AUC3 = AUC_3D( p,label_true,varargin)
% ������������AUC����ѡ������plot������ʾ��AUC���ӻ�
%����pΪ����������ڵĸ��ʽ����n��3�У���vararginΪ��plot��ʱ������3άAUC

%%  --------------����任-------------------
x = (p(:,2)-p(:,1)+1)./2^0.5;
y =  real( ( (p(:,1)-1).^2 + p(:,2).^2 + p(:,3).^3 -x.^2).^0.5 ) ;
% figure                                              %��������任ǰ��ͼ
% plot3(p(:,1),p(:,2),p(:,3),'o')
% grid on
% figure                                              %�����任���ͼ
% plot(x,y,'o')
% grid on
%% ----------------�ָ�---------------------
x_copy = x;                                                                %x����ȥ�أ�������
x_temp = [];
while ~isempty(x_copy)
        x_temp = [x_temp,x_copy(1)];
        x_copy(x_copy == x_copy(1)) = '';
end
x_sort = [sort(x_temp),inf];

y_copy = y;                                                                %y����ȥ�ز�����
y_temp = [];
while ~isempty(y_copy)
        y_temp = [y_temp,y_copy(1)];
        y_copy(y_copy == y_copy(1)) = '';
end
y_sort = [-1,sort(y_temp)];

label_copy = label_true;
label_list = [];
while ~isempty(label_copy)                                                 %��ȡ��ǩȡֵ
        label_list = [label_list,label_copy(1)];
        label_copy(label_copy == label_copy(1)) = '';
end

AUC_point = [];
class1_num = length(find(label_true == label_list(1)));
class2_num = length(find(label_true == label_list(2)));
class3_num = length(find(label_true == label_list(3)));
figure
hold on
length(y_sort);
flag = 0;
for j = y_sort(end:-1:1)
    class1_index = find( y > j );                                                 %�����ߣ��������ڵ�һ��ĵ�
    j;
    class1_true = length( find(label_true(class1_index) == label_list(3)) );      %ͳ�Ƶ�һ������ж��ٸ��������ڵ�һ��
    class = [];
    for i = x_sort
        x_temp = x(y <= j);                                                       %��ȥ��һ���
        class2_index = find( x_temp<i );                                          %�����ߣ��ֳ��ڶ���������
        class2_true = length(find(label_true(class2_index) == label_list(1)));    %����ڶ������ж��ٸ��������ڵڶ����
        class3_index = find( x_temp>=i );                                         %����
        class3_true = length(find(label_true(class3_index) == label_list(2)));
        %[class1_true,class2_true,class3_true]
        AUC_point = [AUC_point;[class1_true/class1_num,class2_true/class2_num,class3_true/class3_num]];
        class = [class;[class2_true/class2_num,class3_true/class3_num]];
    end
    if flag == -1                                                                %����flag���Ե����鿴ĳһ���'ROC',flag==-ʱ��������������
        plot3(class(:,1)',class(:,2)',repmat(class1_true/class1_num,1,length(class(:,1))));
        break
    end
    flag = flag+1;
end

plot3(AUC_point(:,3),AUC_point(:,2),AUC_point(:,1),'o');
grid on 
end

