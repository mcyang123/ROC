function varargout = ROC_AUC( probability,label_list,label_true)
%����ROC������AUC
%probabilityΪһ��m*2����ÿһ��Ϊ����������Ӧ���ʣ�label_listΪ��ǩ�Ŀ���ȡֵ,
%˳���Ӧprobability��ÿһ�У�label_trueΪʵ�������ı�ǩ��m*1����

%-----------------------��ROC����---------------
%--------------------(ֻ�ʺ϶�������)------------
TPR = [];
FPR = [];
list = sort(probability(:,1));
list(find(diff(list)==0)) = '';
for threshold = [-inf;list]'
    threshold_s = repmat(threshold,length(probability(:,1)),1)
    result = repmat(label_list(2),length(label_true),1)
    result(probability(:,1) > threshold_s) = label_list(1)                               %�������жϳ��Ľ��
    TP_FN_index = find(label_true == label_list(1))                                  %��ʵ����е�һ��
    FP_TN_index = find(label_true == label_list(2))                                 %��ʵ����еڶ���
    TP = length(find(result(TP_FN_index) == label_list(1)))
    FP = length(find(result(FP_TN_index) == label_list(1)))
    TPR = [TP/length(TP_FN_index),TPR];
    FPR = [FP/length(FP_TN_index),FPR];
    
end
%----------------------end----------------------

%-----------------------����AUC-----------------
FPR1 = FPR(1:end-1);
FPR2 = FPR(2:end);
TPR1 = TPR(1:end-1);
TPR2 = TPR(2:end);
AUC = 0.5*sum((FPR2-FPR1).*(TPR2+TPR1))
%----------------------end--------------------

varargout{1} = AUC;
varargout{2} = FPR;
varargout{3} = TPR;
TPR
FPR
plot(FPR,TPR)
end

