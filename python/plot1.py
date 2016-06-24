# -*- coding: utf-8 -*-
"""
Created on Wed Jun 22 17:31:28 2016

@author: mike
"""

import knn
import numpy
import matplotlib

data = []
f = open(r'DRD.txt','r')
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
true = data[t_n:,-1]
k = 51
result,label = knn.knn(tra,lab,sam,k)

p1 = [r[0] for r in result]
p_axis = []
num_axis = []
for p in p1:
    if p not in p_axis:
        num_axis.append(len(matplotlib.mlab.find(p==numpy.array(p1))))
        p_axis.append(p)
matplotlib.pyplot.figure()
matplotlib.pyplot.stem(p_axis,num_axis)
matplotlib.pyplot.title('statistics for frequency')
matplotlib.pyplot.xlabel('frequency')
matplotlib.pyplot.ylabel('amount')

#---------------ROC------------------------
p_axis_sort = list(numpy.sort(p_axis))
p_axis_sort.append(p_axis_sort[-1]+1)
TPR = []
FPR = [] 
for p in p_axis_sort:
    result_list = []
    for r in result:
        if r[0] > p:
            result_list.append(label[0])
        else:
            result_list.append(label[1])
    #print result_list
    #print true
    index_temp = matplotlib.mlab.find(numpy.array(true)==label[0])
    T_T = [result_list[i] for i in index_temp]
    TP = len(matplotlib.mlab.find(numpy.array(T_T)==label[0]))
    TPR.append( float(TP) / len(index_temp) )
    #print T_T
    
    
    index_temp = matplotlib.mlab.find(numpy.array(true)==label[1])
    F_T = [result_list[i] for i in index_temp]
    FP = len(matplotlib.mlab.find(numpy.array(F_T)==label[0]))
    FPR.append( float(FP) / len(index_temp) )
    #print F_T
matplotlib.pyplot.figure()
matplotlib.pyplot.plot(FPR,TPR)
matplotlib.pyplot.title('ROC')
matplotlib.pyplot.xlabel('FPR')
matplotlib.pyplot.ylabel('TPR')
#matplotlib.pyplot.axes('FPR','TPR')
            
#------------------------AUC-------------------
AUC= 0
for n in range(len(FPR)-1):
    AUC += (FPR[n]-FPR[n+1])*(TPR[n+1]+TPR[n])
AUC *=0.5
print 'AUC = '+str(AUC)