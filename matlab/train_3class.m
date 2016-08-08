%[q1,q2,q3] = generate_multi_sample(2,500,500,500);
%[s1,s2,s3] = generate_multi_sample(2,80,80,80);
load('data_output.mat')
q1 = data(1:500,:);
q2 = data(501:1000,:);
q3 = data(1001:end,:);

c1 = q1(1:400,:);
c2 = q2(1:400,:);
c3 = q3(1:400,:);
s1 = q1(401:end,:);
s2 = q2(401:end,:);
s3 = q3(401:end,:);

tra = [c1(:,1:2);c2(:,1:2);c3(:,1:2)];
sam = [s1(:,1:2);s2(:,1:2);s3(:,1:2)];
label = [c1(:,3);c2(:,3);c3(:,3)];
label_true = [s1(:,3);s2(:,3);s3(:,3)];
[p,label_list] = knn_for_ROC(tra,label,sam,21);
AUC_3D(p,label_true);
% figure
% hold on
% plot(c1(:,1),c1(:,2),'bo');
% plot(c2(:,1),c2(:,2),'ro');
% plot(c3(:,1),c3(:,2),'go');
% plot(s1(:,1),s1(:,2),'c*')
% plot(s2(:,1),s2(:,2),'c*')
% plot(s3(:,1),s3(:,2),'c*')