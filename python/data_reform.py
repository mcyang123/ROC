# -*- coding: utf-8 -*-
"""
Created on Wed Jun 22 17:31:28 2016

@author: mike
"""

import knn
import numpy
import matplotlib

def data_reform(file_name,method):
	method_list = ['hold_out','cross','bootstraping']
	if method not in method_list:
		print 'method not existance!'
		raise Exception
	else:
		data = []
		tra = []
		sam = []
		lab = []
		true = []
		f = open(file_name,'r')
		for s in f :
			d = s.split(',')
			d = [float(d2) for d2 in d]
			data.append(d)
		f.close()
		data = numpy.array(data)
		row,colu = numpy.shape(data)

		if method == method_list[0]:
			t_n = int(row*0.9)
			tra = data[0:t_n,0:-1]
			sam = data[t_n:,0:-1]
			lab = data[0:t_n,-1]
			true = data[t_n:,-1]
			return tra,sam,lan,true

		elif method == method_list[1]:
			c_num = row/10

		elif method == method_list[2]:
			pass
		'''	
		elif method == method_list[3]:
			pass
		'''
		return (tra,sam,lab,true)

if __name__ == '__main__':
	pass