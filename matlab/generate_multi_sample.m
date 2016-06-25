function varargout = generate_multi_sample(dimension,varargin)
%����n������
%����ÿһ���������������Զ�����������������ά��Ϊdimension�����������
point = rand(nargin-1,dimension);
d = [];
for i = 1:nargin-2
    point_temp = point(i+1:end,:);
    [r,c] = size(point_temp);
    point_rep = repmat(point(i,:),r,1);
    d = [d,sqrt(sum((point_rep-point_temp).^2))];
end
r = min(d)*1.5;
data = [];
for i = 1:nargin-1
    off_set = (rand(varargin{1},dimension)-0.5)*r;
    label = repmat(i,varargin{1},1);
    varargout{i} = [repmat(point(i,:),varargin{1},1)+off_set,label];
    data = [data ; varargout{i}];
end
save('data_output.mat','data');
end