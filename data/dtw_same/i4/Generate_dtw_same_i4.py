import math
import os

rootdir = "E:\mypaper\data\dtw_same\i4"
list_dirs = os.walk(rootdir)

count_acc = 0
count_gyro = 0
count_file = 0
for root, dirs, files in list_dirs:
	for d in dirs:
		print os.path.join(root, d)
	for f in files:
		tempstr = os.path.join(root, f)
		if 'Accel' in tempstr:
			count_acc = count_acc + 1
			changestr = os.path.join(root, 'Accel.txt')
			file_accel = open(tempstr, 'r')
		if 'Gyro' in tempstr:
			count_gyro = count_gyro + 1
			file_gyro = open(tempstr, 'r')
		if ((count_acc > 0) and (count_acc == count_gyro)):
			count_file = count_file + 1
			out_str = os.path.join(rootdir, 'dtw_same_i4' + str(count_file) + '.csv')
			#out_str_jiasudu = os.path.join(rootdir, 'dtw_same_i4_jiasudu' + str(count_file) + '.csv')
			file_out = open(out_str, 'w')
			#file_out_jiasudu = open(out_str_jiasudu, 'w')
			n = 0
			former_time = 0
			modern_time = 0
			gravity = 9.80655
			for line_accel in file_accel:
				if line_accel[0] == '%':
					continue
				while 1:
					line_gyro = file_gyro.readline()
	
					if line_gyro[0] != '%':
						break
	
				n = n + 1
				lb_accel = line_accel.split(' ')
				lb_gyro  = line_gyro.split(' ')
				accel_1 = float(lb_accel[2].strip()) * gravity
				accel_2 = float(lb_accel[3].strip()) * gravity
				accel_3 = float(lb_accel[4].strip()) * gravity
	
				sum = accel_1*accel_1 + accel_2*accel_2 + accel_3*accel_3
				sqrt_sum = math.sqrt(sum)
				
				data_accel = str(accel_1) + ',' + str(accel_2) + ',' + str(accel_3)
				data_gyro  = lb_gyro[2].strip() + ',' + lb_gyro[3].strip() + ',' + lb_gyro[4].strip()
	
				data_compass = '0,0,0'
				data_linear_acc = '0,0,0'
	
				data_sensor = data_accel + ',' + data_gyro + ',' + data_compass + ',' + data_linear_acc
	
				history_time = long(1000 * float(lb_accel[0].strip()))
	
				if n != 1:
					modern_time = modern_time + history_time - former_time
				former_time = history_time
				data_time  = str(history_time) + ',' + str(modern_time)
				file_out.writelines(data_sensor + ',' + data_time + '\n')
				#file_out_jiasudu.writelines(data_sensor + ',' + data_time + ','+str(sum)+','+str(sqrt_sum)+'\n')
			file_accel.close()
			file_gyro.close()
			file_out.close()
			#file_out_jiasudu.close()
			count_acc = 0
			count_gyro = 0