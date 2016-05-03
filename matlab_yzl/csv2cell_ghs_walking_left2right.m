% fid_new=fopen('still_right2left.csv','w');
mydir='C:\Users\jqrghs\Desktop\PMC实验\原始实验数据-肖老师-2016.04.18\走路左换右-没问题\';
walking_left2right=cell(1,250);
filenames=dir([mydir,'*.csv']);
num_less_than_51=0;
for i=1:length(filenames)
    if i>250
        break;
    end
    filename=[mydir,filenames(i).name];
    disp(i);
    % filename就是单个文件名了
    % fid=fopen(filename,'r+');
    % while ~feof(fid)
    temp=csvread(filename);
    temp_accX=temp(:,1);
    index_Max_accX=find(temp_accX==max(temp_accX));
    if index_Max_accX-25<1  
        disp('less than 51');
        num_less_than_51=num_less_than_51+1;
        continue;
    end    
    if size(temp_accX,1)<index_Max_accX+25
        disp('less than 51');
        num_less_than_51=num_less_than_51+1;
        continue;
    end
    walking_left2right{i}=temp(index_Max_accX-25:index_Max_accX+25,:);
    % still_right2left=[still_right2left;temp(index_Max_accX-25:index_Max_accX+25,:)];
    % end
end
disp(num_less_than_51);
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