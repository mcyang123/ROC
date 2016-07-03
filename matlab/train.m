function [] = train( k,varargin)
%%��knn�����ݼ����з��࣬ͳ��Ƶ���ֲ�������ROC������AUC
%����Ϊ���ݼ�����

%%
%------------------------׼������-----------------------------------
if nargin == 1                                                             %ֻ����k,Ĭ��������,Ĭ�Ϸ���
    try
        load('data_output.mat');
    catch
        %generate_multi_sample(2,100,100);
        load('data_output.mat');
    end
    [tra,sam,label,label_true] = data_split(data,'hold_out_10');

elseif nargin == 3                                                         %ָ�����ݼ�������ѵ������         
    varargin{1};
    if strcmp(varargin{1},'filename');
        data = importdata( varargin{2} );                                  %��ȡ����
        [tra,sam,label,label_true] = data_split(data,'hold_out_10');
    elseif strcmp(varargin{1},'method')
        load('data_output.mat');
        [tra,sam,label,label_true] = data_split(data,varargin{2});
    else
        error('�����������󣺹ؼ��ʲ��Ϸ�')
    end
    
elseif nargin == 5
    if strcmp(varargin{1},'filename') && strcmp(varargin{3},'method')
        data = importdata( varargin{2} );                                  %��ȡ����
        [tra,sam,label,label_true] = data_split(data,varargin{4});
    elseif strcmp(varargin{3},'filename') && strcmp(varargin{1},'method')
        data = importdata( varargin{4} );                                  %��ȡ����
        [tra,sam,label,label_true] = data_split(data,varargin{2});
    else
        error('�����������󣺹ؼ��ʲ��Ϸ�')
    end
    
else
    error('���������������')
end  
%%------------------------------------end---------------------------------
%%
%%--------------------------------ѵ��-------------------------------------
if k>0 && k<length(label)                                                   %�о��ض�kֵ������
    [p,label_list] = knn_for_ROC(tra,label,sam,k);                         %����knn�㷨
    %--------------------ͳ�Ʒֲ�--------------------
    figure
    hold on
    color = ['r','g','b','k'];
    X = cell(1,2);
    for i = 1:length(label_list)                                           %
        x_temp = sort(p(label_true == label_list(i),find(label_list == label_list(i))));                        %��ȡ��i�����ݣ�������ʽ�������
        y = [length(find(x_temp == x_temp(1)))];                           %��ʼ��y�����ݣ������ʶ�Ӧ������
        x = [x_temp(1)];                                                   %��ʼ��x�����ݣ�������
        for j = 2:length(x_temp)                             
            if x_temp(j) ~= x_temp(j-1)                                    %�ظ��ĸ���ֵ�����ۼ�
                y = [y,length(find(x_temp == x_temp(j)))];                 %ͳ�Ƶ�ǰ��������
                x = [x,x_temp(j)];
            end
        end
        stem(x,y,color(i))                                                 %��ͳ��ͼ
        xlabel('����')
        ylabel('����')
        X{i} = y;
        
    end
    %---------------------end------------------------
    
    %--------------------��ROC������AUC--------------
    [AUC,FPR,TPR] = ROC_AUC(p,label_list,label_true);
    AUC
    [a1,b] = discreteVarLAST2(p(label_true == label_list(1),find(label_list == label_list(1))),p(label_true == label_list(2),find(label_list == label_list(2))));
    [a2,b] = discreteVarLAST2(p(label_true == label_list(2),find(label_list == label_list(2))),p(label_true == label_list(1),find(label_list == label_list(1))));
    a1
    a2
    figure
    plot(FPR,TPR)
    xlabel('��������')
    ylabel('��������')
    %----------------------end---------------------
    
elseif k == -1
    AUC_list = [];
    k_list = 1:length(label);
    for k = k_list                                                         %����ÿһ��kֵ����AUC����ͼ
        [p,label_list] = knn_for_ROC(tra,label,sam,k);
        AUC = ROC_AUC(p,label_list,label_true);
        AUC_list = [AUC_list,AUC];
    end
    figure
    plot(k_list,AUC_list)
    xlabel('k')
    ylabel('AUC')
else
    error('k���Ϸ�')
end
%-------------------------------------end---------------------------------
end

