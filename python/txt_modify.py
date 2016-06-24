# -*- coding: utf-8 -*-
'''
f = open(r'Skin_Segmentation.txt','r')
f_w = open(r'Skin_Segmentation2.txt','w')
f_w.write('')
f_w.close()
f_w = open(r'Skin_Segmentation2.txt','a')
for s in f:
	L = s.split('\t')
	#print L
	L2 = [str(i).strip()+',' for i in L]
	s2 = ''.join(L2)
	s2 = s2[0:-1]+'\n'
	f_w.write(s2)
f.close()
f_w.close()
'''
f = open(r'Skin_Segmentation2.txt','r')
i = 0
data = []
for s in f :
	try :
		d = s.split(',')
		d = [int(d2) for d2 in d]
		data.append(d)
		i += 1
	except :
		print i
f.close()
print 'end'