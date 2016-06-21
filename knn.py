# -*- coding: utf-8 -*-
'''knn算法，输入训练样本数据（training），训练样本标签（label），样本数据（sample），k值（k）
   计算每个样本值k阶最近邻中，每个分类的组成占比，返回一个元组列表，每个元组的一个元素为标签，第二个为该类样本在领域中的占比，其行数和样本一致。该算法
   使用于多类问题
'''
import numpy
import scipy
import matplotlib.mlab as mlab

def knn(training,label,sample,k):
	label_dict = {}
	#----------检查输入数据格式是否正确------------------
	r_t,c_t = numpy.shape(training)                   
	r_s,c_s = numpy.shape(sample)
	label_shape = numpy.shape(label)
	if len(label_shape) >1:
		raise Exception                                                  #标签数组有多列，报错
	else:
		label_list = []                                                  #分析标签数组，初始化分类结果字典
		label_dict = {}
		for n,l in enumerate(label):
			if l not in label[0:n]:
				label_list.append((l,len(mlab.find(label[n+1:] == l))))
				label_dict[l] = 0
	class_num = len(label_list)                                           #class_num类问题
	for c in range(class_num-1):                                          #检查样本数据是否均衡，不均衡的训练样本会造成结果的偏差
		if label_list[c][1] != label_list[c+1][1]:
			print "WARNING: 样本数据不均衡"
	if c_t != c_s or r_t != label_shape[0]:                               #样本数据和训练集数据列长不一致，或标签数与训练样本数不一致，报错
		raise Exception
	#----------------end--------------------------------

	else:
		training = numpy.array(training)                                  #格式
		sample = numpy.array(sample)
		label = numpy.array(label) 
		distance = []                                                     #dictance存放每个样本点到训练集之间的距离与标签组成的元组
		distance_list = []                                                #dictance_list存放每个样本点到训练集之间的距离
		for s in sample:                                                  #计算欧式距离，得到的数值实际上是距离的平方
			for r,t in enumerate(training):
				d = 0
				for c in range(c_t):
					d = d + (s[c]-t[c])**2                                #得到欧式距离
				distance.append((d,label[r]))                             #将距离和标签放入对列中
				distance_list.append(d)                                   #
		for d in distance:                                                #统计在k阶近邻中，各类样本的数目
			if len(mlab.find(distance_list>d[0]))+1 <= k:                 #距离在k阶领域内
				label_dict[d[1]] +=1
		for key in label_dict.keys():                                     #归一化
			label_dict[key] /= float(k)
	return label_dict.items()

#--------------测试----------------------------
if __name__ == '__main__':
	tra = numpy.random.rand(20,2)                                         #生成测试数据
	sam = numpy.random.rand(3,2)
	lab = [1,2]*10
	k = 5
	result = knn(tra,lab,sam,k)                                           #调用函数
	print result