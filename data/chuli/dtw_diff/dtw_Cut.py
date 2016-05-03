import math
import os

rootdir = "E:\mypaper\data\dtw_diff"
list_dirs = os.walk(rootdir)

for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		if ('.csv' in f) and not ('_cut' in f):
			f_prefix = f.split('.csv')
			cut_name = f_prefix[0] + '_cut.csv'
			out_str = os.path.join(rootdir, cut_name)
			in_str = os.path.join(rootdir, f)
			file_out = open(out_str, 'w')
			file_in = open(in_str, 'r')
			lines_all = file_in.readlines()
			count = 0
			gyroX_max = 0
			count_max = 0
			for line_in in lines_all:
				count = count + 1
				if count >= 0:
					data_in = line_in.split(',')
					gyroX = abs(float(data_in[3]))
					if  (gyroX > gyroX_max):
						count_max = count
						gyroX_max = gyroX
			#if (count_max + 59 > count-1):
			#	count_max = count - 60 
			left_margin = count_max - 60
			right_margin = count_max + 59
			count = 0
			for line_in in lines_all:
				count = count + 1
				if (count >=left_margin) and (count <= right_margin):
					file_out.writelines(line_in)
			file_in.close()
			file_out.close()
		