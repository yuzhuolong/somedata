% fid_new=fopen('still_right2left.csv','w');
%mydir='C:\Users\jqrghs\Desktop\PMCʵ��\ԭʼʵ������-Ф��ʦ-2016.04.18\�һ���+��·�һ���\';
mydir = 'E:\mypaper\data\iphone6_new\walking_drop_cut\';
right2left=cell(1,500);
filenames=dir([mydir,'*.csv']);
num_less_than_51=0;
for i=1:length(filenames)
   
    % filename���ǵ����ļ�����
    % fid=fopen(filename,'r+');
    % while ~feof(fid)
    filename=[mydir,filenames(i).name];
    temp=csvread(filename);
    
    right2left{i}=temp;
    % still_right2left=[still_right2left;temp(index_Max_accX-25:index_Max_accX+25,:)];
    % end
end

% save still_right2left.csv all     
% fprintf(fid_new,'%s',fgets(fid));
    


















% Seg_Knock_still=cell(1,8);
% time=[];

% for i=1:1:8
%     row=(i-1)*20+1:1:i*20;
%     Seg_Knock_still{i}=Knock_still(row,:);
% %     time=[time;Seg_Knock{i}(20,14)-Seg_Knock{i}(1,14)];
% end

% time
% min(time)
% max(time)
% mean(time)