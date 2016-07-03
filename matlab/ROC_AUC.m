function varargout = ROC_AUC( probability,label_list,label_true)
%画出ROC，计算AUC
%probability为一个m*2矩阵，每一行为两类样本对应概率，label_list为标签的可能取值,
%顺序对应probability的每一列，label_true为实际样本的标签，m*1向量

%-----------------------画ROC曲线---------------
%--------------------(只适合二类问题)------------
TPR = [];
FPR = [];
list = sort(probability(:,1));
list(find(diff(list)==0)) = '';
for threshold = [-inf;list]'
    threshold_s = repmat(threshold,length(probability(:,1)),1)
    result = repmat(label_list(2),length(label_true),1)
    result(probability(:,1) > threshold_s) = label_list(1)                               %由门域判断出的结果
    TP_FN_index = find(label_true == label_list(1))                                  %真实情况中第一类
    FP_TN_index = find(label_true == label_list(2))                                 %真实情况中第二类
    TP = length(find(result(TP_FN_index) == label_list(1)))
    FP = length(find(result(FP_TN_index) == label_list(1)))
    TPR = [TP/length(TP_FN_index),TPR];
    FPR = [FP/length(FP_TN_index),FPR];
    
end
%----------------------end----------------------

%-----------------------计算AUC-----------------
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

