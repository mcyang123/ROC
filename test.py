# -*- coding: utf-8 -*-
import knn
import numpy
import matplotlib

data = []
f = open(r'E:\mike\project\lab\ROC\code\DRD.txt','r')
for s in f :
	d = s.split(',')
	d = [float(d2) for d2 in d]
	data.append(d)
f.close()
data = numpy.array(data)
row,colu = numpy.shape(data)

t_n = int(row*0.9)
tra = data[0:t_n,0:-1]
sam = data[t_n:,0:-1]
lab = data[0:t_n,-1]
true = numpy.array(data[t_n:,-1])
k = 20
result,label = knn.knn(tra,lab,sam,k)

label = numpy.array(label)
result_list = []
for r in result:                        #
	if r[0] >=0.5: 
		result_list.append(label[0])
	else:
		result_list.append(label[1])
result_list = numpy.array(result_list)
print "correct rate:"
print len(matplotlib.mlab.find((result_list==true) == True)) / float(len(true))
