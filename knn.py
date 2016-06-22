# -*- coding: utf-8 -*-
'''knn算法，输入训练样本数据（training），训练样本标签（label），样本数据（sample），k值（k）
   计算每个样本值k阶最近邻中，每个分类的组成占比，返回一个元组列表，每个元组的一个元素为标签，第二个为该类样本在领域中的占比，其行数和样本一致。该算法
   使用于多类问题
'''
import numpy
import scipy
import matplotlib.mlab as mlab

def knn(training,label,sample,k):
	dit = {}
	#----------检查输入数据格式是否正确------------------
	r_t,c_t = numpy.shape(training)                   
	r_s,c_s = numpy.shape(sample)
	label_shape = numpy.shape(label)
	if len(label_shape) >1:
		raise Exception                                                  #标签数组有多列，报错
	else:
		label_list = []
		label_num = []                                                  #分析标签数组，初始化分类结果字典
		for n,l in enumerate(label):
			if l not in label[0:n]:
				label_list.append(l)
				label_num.append(len(mlab.find(label[n+1:] == l)))
	class_num = len(label_list)                                           #class_num类问题
	for c in range(class_num-1):                                          #检查样本数据是否均衡，不均衡的训练样本会造成结果的偏差
		if label_num[c] != label_num[c+1]:
			print "WARNING: 样本数据不均衡\n"
			break
	if c_t != c_s or r_t != label_shape[0]:                               #样本数据和训练集数据列长不一致，或标签数与训练样本数不一致，报错
		raise Exception
	#----------------end--------------------------------

    #----------------实现算法--------------------------
	else:
		training = numpy.array(training)                                  #格式
		sample = numpy.array(sample)
		label = numpy.array(label)                                                 
		result_list = []
		for s in sample:                                                  #计算欧式距离，得到的数值实际上是距离的平方                                           
			label_dict = dit.fromkeys(label_list,0)
			distance1 = (s-training)**2                                      #dictance存放每个样本点到训练集之间的距离
			distance = [sum(temp) for temp in distance1]
			#print distance
			distance_label = zip(distance,label)                              #dictance_label存放每个样本点到训练集之间的距离与标签
			#print distance_label
			result_temp = []
			distance_sort = numpy.sort(distance)[0:k]
			for d in distance_sort:
				index = mlab.find(d == numpy.array(distance_label)[:,0])
				target_label = distance_label[index[0]][1]
				label_dict[target_label] += 1
			for key in label_list:                                        #归一化
				result_temp.append(round(label_dict[key]/float(k),3))
			result_list.append(result_temp)
	return result_list,label_list
	#------------------------end-------------------------------

#--------------测试----------------------------
if __name__ == '__main__':
	tra = numpy.random.rand(10,2)                                         #生成测试数据
	sam = numpy.random.rand(3,2)
	lab = [1,2]*5
	k = 3
	result,label = knn(tra,lab,sam,k)                                           #调用函数
	print result
	print '\n'
	print label