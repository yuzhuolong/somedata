import math
import os

rootdir = "E:\mypaper\data\dtw_diff\cut"
list_dirs = os.walk(rootdir)

for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		if ('.csv' in f) and ('_i6' in f) and not ('_cut' in f):
			f_prefix = f.split('.csv')
			cut_name = f_prefix[0] + '_cut'
			#out_str = os.path.join(rootdir, cut_name)
			in_str = os.path.join(rootdir, f)
			#file_out = open(out_str, 'w')
			file_in = open(in_str, 'r')
			line_in = file_in.readline()
			count = 0
			while line_in != '':
				count = count + 1
				out_str = os.path.join(rootdir, cut_name + '_' + str(count) + '.csv')
				file_out = open(out_str, 'w')
				for i in range(200):
					file_out.writelines(line_in)
					line_in = file_in.readline()
				file_out.close()
			
			file_in.close()
list_dirs = os.walk(rootdir)
for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		if ('.csv' in f) and ('_i4' in f) and not ('_cut' in f):
			f_prefix = f.split('.csv')
			cut_name = f_prefix[0] + '_cut'
			#out_str = os.path.join(rootdir, cut_name)
			in_str = os.path.join(rootdir, f)
			#file_out = open(out_str, 'w')
			file_in = open(in_str, 'r')
			line_in = file_in.readline()
			count = 0
			while line_in != '':
				count = count + 1
				out_str = os.path.join(rootdir, cut_name + '_' + str(count) + '.csv')
				file_out = open(out_str, 'w')
				for i in range(200):
					file_out.writelines(line_in)
					line_in = file_in.readline()
				file_out.close()
			
			file_in.close()