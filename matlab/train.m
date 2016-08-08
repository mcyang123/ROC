function [] = train( k,varargin)
%%用knn对数据集进行分类，统计频数分布，画出ROC，计算AUC
%输入为数据集名称

%%
%------------------------准备数据-----------------------------------
if nargin == 1                                                             %只输入k,默认样本集,默认方法
    try
        load('data_output.mat');
    catch
        generate_multi_sample(2,100,100);
        load('data_output.mat');
    end
    [tra,sam,label,label_true] = data_split(data,'hold_out_10');

elseif nargin == 3                                                         %指定数据集或样本训练方法         
    varargin{1};
    if strcmp(varargin{1},'filename');
        data = importdata( varargin{2} );                                  %读取数据
        [tra,sam,label,label_true] = data_split(data,'hold_out_10');
    elseif strcmp(varargin{1},'method')
        load('data_output.mat');
        [tra,sam,label,label_true] = data_split(data,varargin{2});
    else
        error('参数输入有误：关键词不合法')
    end
    
elseif nargin == 5
    if strcmp(varargin{1},'filename') && strcmp(varargin{3},'method')
        data = importdata( varargin{2} );                                  %读取数据
        [tra,sam,label,label_true] = data_split(data,varargin{4});
    elseif strcmp(varargin{3},'filename') && strcmp(varargin{1},'method')
        data = importdata( varargin{4} );                                  %读取数据
        [tra,sam,label,label_true] = data_split(data,varargin{2});
    else
        error('参数输入有误：关键词不合法')
    end
    
else
    error('输入参数数量有误')
end  
%%------------------------------------end---------------------------------
%%
%%--------------------------------训练-------------------------------------
if k>0 && k<length(label)                                                   %研究特定k值的性能
    [p,label_list] = knn_for_ROC(tra,label,sam,k);                         %进行knn算法
    %--------------------统计分布--------------------
    figure
    hold on
    color = ['r','g','b','k'];
    for j = 1:length(label_list)    
        p_temp =sort(p(label_true == label_list(j),1))
        x = [p_temp(1)];
        y = [length(find(p_temp(1) == p_temp))];
        for i = 2:length(p_temp)
            if length(find(p_temp(i) == x)) == 0     %与前面的不重复，需要入对列
                x = [x,p_temp(i)];
                y = [y,length( find( p_temp == p_temp(i) ) )];
            end
        end
        stem(x,y,color(j))                                                 %画统计图
    end
    hold off 
    xlabel('概率')
    ylabel('数量')
    %---------------------end------------------------
    
    %--------------------画ROC，计算AUC--------------
    [AUC,FPR,TPR] = ROC_AUC(p,label_list,label_true);
    AUC
    AUC_fast(p(label_true == label_list(1),1),p(label_true == label_list(2),1))
    figure
    plot(FPR,TPR)
    xlabel('假正例率')
    ylabel('真正例率')
    %----------------------end---------------------
    
elseif k == -1                                                             %遍历每一个k值，求AUC，画图
    AUC_list = [];
    k_list = 1:length(label);
    for k = k_list                                                         
        [p,label_list] = knn_for_ROC(tra,label,sam,k);
        AUC = AUC_fast(p(label_true == label_list(1),1),p(label_true == label_list(2),1));
        AUC_list = [AUC_list,AUC];
    end
    figure
    plot(k_list,AUC_list)
    xlabel('k')
    ylabel('AUC')
else
    error('k不合法')
end
%-------------------------------------end---------------------------------
end

