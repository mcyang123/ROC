function AUC3 = AUC_3D( p,label_true,varargin)
% 求出三类问题的AUC，可选参数‘plot’，表示将AUC可视化
%输入p为三类问题对于的概率结果，n行3列，当varargin为‘plot’时，画出3维AUC

%%  --------------坐标变换-------------------
x = (p(:,2)-p(:,1)+1)./2^0.5;
y =  real( ( (p(:,1)-1).^2 + p(:,2).^2 + p(:,3).^3 -x.^2).^0.5 ) ;
% figure                                              %画出坐标变换前的图
% plot3(p(:,1),p(:,2),p(:,3),'o')
% grid on
% figure                                              %画出变换后的图
% plot(x,y,'o')
% grid on
%% ----------------分割---------------------
x_copy = x;                                                                %x数组去重，并排序
x_temp = [];
while ~isempty(x_copy)
        x_temp = [x_temp,x_copy(1)];
        x_copy(x_copy == x_copy(1)) = '';
end
x_sort = [sort(x_temp),inf];

y_copy = y;                                                                %y数组去重并排序
y_temp = [];
while ~isempty(y_copy)
        y_temp = [y_temp,y_copy(1)];
        y_copy(y_copy == y_copy(1)) = '';
end
y_sort = [-1,sort(y_temp)];

label_copy = label_true;
label_list = [];
while ~isempty(label_copy)                                                 %提取标签取值
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
    class1_index = find( y > j );                                                 %上切线，划出属于第一类的点
    j;
    class1_true = length( find(label_true(class1_index) == label_list(3)) );      %统计第一类点中有多少个真正属于第一类
    class = [];
    for i = x_sort
        x_temp = x(y <= j);                                                       %除去第一类点
        class2_index = find( x_temp<i );                                          %下切线，分出第二，第三类
        class2_true = length(find(label_true(class2_index) == label_list(1)));    %求出第二类中有多少个真正属于第二类的
        class3_index = find( x_temp>=i );                                         %类似
        class3_true = length(find(label_true(class3_index) == label_list(2)));
        %[class1_true,class2_true,class3_true]
        AUC_point = [AUC_point;[class1_true/class1_num,class2_true/class2_num,class3_true/class3_num]];
        class = [class;[class2_true/class2_num,class3_true/class3_num]];
    end
    if flag == -1                                                                %控制flag可以单独查看某一层的'ROC',flag==-时，画出所有曲线
        plot3(class(:,1)',class(:,2)',repmat(class1_true/class1_num,1,length(class(:,1))));
        break
    end
    flag = flag+1;
end

plot3(AUC_point(:,3),AUC_point(:,2),AUC_point(:,1),'o');
grid on 
end

