function [] = train( k,varargin)
%用knn对数据集进行分类，统计频数分布，画出ROC，计算AUC
%输入为数据集名称

if nargin == 2 
    if varargin{1}(end-2:end) =='txt'
        data = importdata( varargin{1} );                                             %读取数据
    else
        error('数据集输入错误')
    end
elseif nargin == 1
    try
        load('data_output.mat');
    catch
        generate_multi_sample(2,100,100);
        load('data_output.mat');
    end
else
    error('数据集输入错误')
end
tra = data(:,1:end-1);
sam = tra;
label = data(:,end);   
if k>0 & k<length(label)                                                   %研究特定k值的性能
    [p,label_list] = knn_for_ROC(tra,label,sam,k);                         %进行knn算法
    %--------------------统计分布--------------------
    figure
    hold on
    color = ['r','g','b','k'];
    for i = 1:length(label_list)                                           %
        x_temp = sort(p(label == label_list(i),i));                        %提取第i类数据，对其概率进行排序
        y = [length(find(x_temp == x_temp(1)))];                           %初始化y轴数据，即概率对应的数量
        x = [x_temp(1)];                                                   %初始化x轴数据，即概率
        for j = 2:length(x_temp)                             
            if x_temp(j) ~= x_temp(j-1)                                    %重复的概率值不再累加
                y = [y,length(find(x_temp == x_temp(j)))];                 %统计当前概率数量
                x = [x,x_temp(j)];
            end
        end
        stem(x,y,color(i))                                                 %画统计图
        xlabel('概率')
        ylabel('数量')
    end
    %---------------------end------------------------
    
    %--------------------画ROC，计算AUC--------------
    [AUC,FPR,TPR] = ROC_AUC(p,label_list,label,k);
    AUC
    figure
    plot(FPR,TPR)
    xlabel('假正例率')
    ylabel('真正例率')
    %----------------------end---------------------
    
elseif k == -1
    AUC_list = [];
    k_list = 1:length(label);
    for k = k_list                                                         %遍历每一个k值，求AUC，画图
        [p,label_list] = knn_for_ROC(tra,label,sam,k);
        AUC_list = [AUC_list,ROC_AUC(p,label_list,label,k)];
    end
    figure
    plot(k_list,AUC_list)
    xlabel('k')
    ylabel('AUC')
else
    error('k不合法')
end
end

