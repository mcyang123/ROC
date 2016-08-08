function [] = train( k,varargin)
%%��knn�����ݼ����з��࣬ͳ��Ƶ���ֲ�������ROC������AUC
%����Ϊ���ݼ�����

%%
%------------------------׼������-----------------------------------
if nargin == 1                                                             %ֻ����k,Ĭ��������,Ĭ�Ϸ���
    try
        load('data_output.mat');
    catch
        generate_multi_sample(2,100,100);
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
    for j = 1:length(label_list)    
        p_temp =sort(p(label_true == label_list(j),1))
        x = [p_temp(1)];
        y = [length(find(p_temp(1) == p_temp))];
        for i = 2:length(p_temp)
            if length(find(p_temp(i) == x)) == 0     %��ǰ��Ĳ��ظ�����Ҫ�����
                x = [x,p_temp(i)];
                y = [y,length( find( p_temp == p_temp(i) ) )];
            end
        end
        stem(x,y,color(j))                                                 %��ͳ��ͼ
    end
    hold off 
    xlabel('����')
    ylabel('����')
    %---------------------end------------------------
    
    %--------------------��ROC������AUC--------------
    [AUC,FPR,TPR] = ROC_AUC(p,label_list,label_true);
    AUC
    AUC_fast(p(label_true == label_list(1),1),p(label_true == label_list(2),1))
    figure
    plot(FPR,TPR)
    xlabel('��������')
    ylabel('��������')
    %----------------------end---------------------
    
elseif k == -1                                                             %����ÿһ��kֵ����AUC����ͼ
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
    error('k���Ϸ�')
end
%-------------------------------------end---------------------------------
end

