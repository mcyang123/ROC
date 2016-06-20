# -*- coding: utf-8 -*-
'''knn算法，输入训练样本数据（training），训练样本标签（label），样本数据（sample），k值（k）
   计算每个样本值k阶最近邻中，每个分类的组成占比，返回一个N*1的向量，其行数和样本一致。该算法
   使用于多类问题
'''
import numpy

def knn(training,label,sample,k):
	r_t,c_t = shape(training)
	r_s,c_s = shape(sample)
	r_l,c_l = shape(label)
	if c_l !=1:
		pass
	else:
		label_list = []
		label_dict = {}
		for l,n in enumerate(label):
			if l not in label[0:n]:
				label_list.append((l,len(find(label[n+1:] == l))))
				label_dict[l] = 0
	class_num = len(label_list)                                           #class_num类问题
	for c in range(class_num-1):
		if label_list[c][1] ~= label_list[c+1][1]:
			print "WARNING: 样本数据不均衡"
	if c_t != c_s:
		pass
	else:
		training = array(training)
		sample = array(sample)
		label = array(label)
		distance = []
		distance_list = []
		for s in sample:
			for t,r in enumerate(training):
				d = 0
				for c in range(c_t):
					d = d + (s[c]-t[c])**2           #得到欧式距离
				distance.append((d,label[r]))
				distance_list.append(d)
		out = []
		for d in distance:
			if len(find(distance_list>d[0]))+1<=k:     #在k阶领域内
				label_dict[d[1]] +=1
		

