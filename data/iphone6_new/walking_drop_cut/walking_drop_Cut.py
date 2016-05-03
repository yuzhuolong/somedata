import math
import os

rootdir = "E:\mypaper\data\iphone6_new\walking_drop_cut"
list_dirs = os.walk(rootdir)

for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		if ('.csv' in f) and not('_cut' in f):
			f_prefix = f.split('.csv')
			cut_name = f_prefix[0] + '_cut.csv'
			out_str = os.path.join(rootdir, cut_name)
			in_str = os.path.join(rootdir, f)
			file_out = open(out_str, 'w')
			file_in = open(in_str, 'r')
			lines_all = file_in.readlines()
			count = 0
			accX_max = -5
			for line_in in lines_all:
				count = count + 1
				
			left_margin = count - 199
			right_margin = count
			count = 0
			for line_in in lines_all:
				count = count + 1
				if (count >=left_margin) and (count <= right_margin):
					file_out.writelines(line_in)
			file_in.close()
			file_out.close()
		