# -*- coding: utf-8 -*-
'''knn算法，输入训练样本数据（training），训练样本标签（label），样本数据（sample），k值（k）
   计算每个样本值k阶最近邻中，每个分类的组成占比，返回一个N*1的向量，其行数和样本一致。该算法
   使用于多类问题
'''
def knn(training,label,smaple,k):
	size()