import math
import os

rootdir = "E:\mypaper\data\dtw_diff"
list_dirs = os.walk(rootdir)

for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		if ('.csv' in f) and ('_i4' in f):
			f_prefix = f.split('.csv')
			cut_name = f_prefix[0] + '.txt'
			f_i4_split = f.split('_i4')
			i6_name = f_i4_split[0] + '_i6' + f_i4_split[1]
			out_str = os.path.join(rootdir, cut_name)
			in_str_i4 = os.path.join(rootdir, f)
			in_str_i6 = os.path.join(rootdir, i6_name)
			file_out = open(out_str, 'w')
			file_in_i4 = open(in_str_i4, 'r')
			file_in_i6 = open(in_str_i6, 'r')
			#lines_all_i4 = file_in_i4.readlines()
			#lines_all_i6 = file_in_i6.readlines()
			i = 0
			j = 0
			k = 0
			f_i4 = [[0 for i in range(6)]  for j in range(2000)]
			#print f_i4[2][3]
			f_i6 = [[0 for i in range(6)]  for j in range(2000)]
			f_dtw = [[[0 for i in range(6)]  for j in range(2000)]   for k in range(2000)]
			distance = [[[0 for i in range(6)]  for j in range(2000)]   for k in range(2000)]
			i = 0
			for i in range(0,5,1):
				print i
			for line_i4 in file_in_i4:
				data = line_i4.split(',')
				
				for j in range(6):
					f_i4[i][j] = float(data[j])
				i = i + 1
			linenum_i4 = i
			i = 0
			for line_i6 in file_in_i6:
				data = line_i6.split(',')
				for j in range(6):
					f_i6[i][j] = float(data[j])
				i = i + 1
			linenum_i6 = i
			
			for k in range(6):
				for i in range(linenum_i4):
					for j in range(linenum_i6):
						distance[i][j][k] = (f_i4[i][k] - f_i6[j][k]) * (f_i4[i][k] - f_i6[j][k])
			
			for k in range(6):
				f_dtw[0][0][k] = distance[0][0][k]
			
				for i in range(1, linenum_i4, 1):
					f_dtw[i][0][k] = f_dtw[i-1][0][k] + distance[i][0][k]
				for j in range(1, linenum_i6, 1):
					f_dtw[0][j][k] = f_dtw[0][j-1][k] + distance[0][j][k]
				for i in range(1,linenum_i4, 1):
					for j in range(1,linenum_i6,1):
						f_dtw[i][j][k] = min([f_dtw[i][j-1][k], f_dtw[i-1][j][k], f_dtw[i-1][j-1][k]]) + distance[i][j][k]
			for k in range(6):	
				file_out.writelines(str(f_dtw[linenum_i4-1][linenum_i6-1][k])+'\n')
			file_in_i4.close()
			file_in_i6.close()
			file_out.close()
			#count = 0
			#gyroX_max = 5
			#count_max = 0
			#for line_in in lines_all:
				#count = count + 1
				#if count >= 500:
				#	data_in = line_in.split(',')
			#		gyroX = float(data_in[5])
		#			if  gyroX < gyroX_max:
			#			count_max = count
			#			gyroX_max = gyroX
			#left_margin = count_max - 60
			#right_margin = count_max + 59
			#count = 0
			#for line_in in lines_all:
			#	count = count + 1
			#	if (count >=left_margin) and (count <= right_margin):
			#		file_out.writelines(line_in)
			#file_in.close()
			#file_out.close()
		