
%function featurematrix = segments2features( segments,class )
function featuerscell=segments2features_weka(varargin)
%segments2features 计算并保存片段的特征向量
%   输入：vargin=segments,class,segments,class...
%         如果输入参数只有1对segments-class，则保存文件名是该变量的名字，如果有多对segments-class，则保存文件名是featureset+时间戳
%   输出：features： 1*X
%   featurematrix cell，featurematrix：segmentscount*featurescount matrix
%
%segments2features 计算片段的特征向量
%   输入：segments: 1*ColumnsCount cell  or   RowsCount*14 Matrix
%         如果是cell，则cell的每一项都是 RowsCount*14 Matrix
%         class:  类别，字符串，只有在需要保存文件时才有用，没有此参数则不保存文件
%   输出：featurematrix: SegmentsCount*FeaturesCount Matrix

%% parameter
% segment_column_count=14;
segment_column_count=14;
%% check varargin
i=1;
if nargin<=1 || mod(nargin,2)~=0
    'there is something wrong with the number of varargin'
    features={};
    return
end

%             strcmp(class_str,'still_left2right')||...
%             strcmp(class_str,'still_right2left')||...
%             strcmp(class_str,'walking_left2right')||...
%             strcmp(class_str,'walking_right2left')||...

while i<nargin
    segments_cell=varargin{i};
    class_str=varargin{i+1};
    % if ~(strcmp(class_str,'regular')||strcmp(class_str,'static')||strcmp(class_str,'assaulted')||strcmp(class_str,'transition')||strcmp(class_str,'target')||strcmp(class_str,'outlier'))
    if ~(strcmp(class_str,'left2right')||...
            strcmp(class_str,'right2left')||...
            strcmp(class_str,'other'))
        disp('Warning: class set = {still_left2right,still_right2left,walking_left2right,walking_right2left}')
        return
    end
    if ~iscell(segments_cell)
        strcat(num2str(i),'-th varargin is not a cell!')
        return
    end
    if ~isstr(class_str)
        strcat(num2str(i+1),'+1-th varargin is not a string!')
        return
    end
    i=i+2;
end
%% calculate features for each segment
featuerscell={};
if nargin==2
    filename=strcat(inputname(1),'_features_yzl_forappcontest.arff');
else
    filename=strcat('featuresset_yzl_forappcontest','.arff');
end
fid=fopen(filename,'wt');
%% 填充Weka文件头
%fprintf(fid,'@RELATION PMC_yzl\r\n\r\n');
%fprintf(fid,'@ATTRIBUTE g_mag_mean NUMERIC\r\n');                       %1
%fprintf(fid,'@ATTRIBUTE g_mag_max NUMERIC\r\n');                        %2
% fprintf(fid,'@ATTRIBUTE g_mag_range NUMERIC\r\n');                      %3
%fprintf(fid,'@ATTRIBUTE g_mag_zcr_mean NUMERIC\r\n');                   %4
%fprintf(fid,'@ATTRIBUTE g_mag_kurtosis NUMERIC\r\n');                   %5
%fprintf(fid,'@ATTRIBUTE g_mag_mdan NUMERIC\r\n');                       %6
% fprintf(fid,'@ATTRIBUTE g_mag_lzc NUMERIC\r\n');                        %7
% fprintf(fid,'@ATTRIBUTE g_mag_sampen NUMERIC\r\n');                     %8
%fprintf(fid,'@ATTRIBUTE g_mag_dccomponent NUMERIC\r\n');                %9
% fprintf(fid,'@ATTRIBUTE g_mag_peakfreq NUMERIC\r\n');
% fprintf(fid,'@ATTRIBUTE g_mag_peakamp NUMERIC\r\n');                    %10
% fprintf(fid,'@ATTRIBUTE g_mag_halfpeakfreqbandwidth NUMERIC\r\n');      %11
% fprintf(fid,'@ATTRIBUTE g_mag_quarterpeakfreqbandwidth NUMERIC\r\n');   %12
%fprintf(fid,'@ATTRIBUTE g_mag_spectralcentroid NUMERIC\r\n');           %13
%fprintf(fid,'@ATTRIBUTE g_mag_spectralkurtosis NUMERIC\r\n');           %14
% fprintf(fid,'@ATTRIBUTE g_mag_spectralslope NUMERIC\r\n');              %15
%fprintf(fid,'@ATTRIBUTE class {regular,assaulted}\r\n\r\n');
% fprintf(fid,'@ATTRIBUTE g_magx_min NUMERIC\r\n');             
% fprintf(fid,'@ATTRIBUTE g_magx_max NUMERIC\r\n');    
% fprintf(fid,'@ATTRIBUTE g_magx_abs_mean NUMERIC\r\n'); 
% fprintf(fid,'@ATTRIBUTE g_magy_min NUMERIC\r\n');             
% fprintf(fid,'@ATTRIBUTE g_magy_max NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magy_abs_mean NUMERIC\r\n'); 
% fprintf(fid,'@ATTRIBUTE g_magz_min NUMERIC\r\n');             
% fprintf(fid,'@ATTRIBUTE g_magz_max NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_abs_mean NUMERIC\r\n'); 
% fprintf(fid,'@ATTRIBUTE g_mag_mean NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_peakfreq NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_halfpeakampfreqbandwidth NUMERIC\r\n'); 不用的话会大幅度提高准确率...  
% fprintf(fid,'@ATTRIBUTE g_magz_spectralslope NUMERIC\r\n');   
% fprintf(fid,'@ATTRIBUTE time NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_mag_peakfreq NUMERIC\r\n');
% fprintf(fid,'@ATTRIBUTE g_magx_peakfreq NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_kurtosis NUMERIC\r\n');   
% fprintf(fid,'@ATTRIBUTE g_magz_halfpeakfreqbandwidth NUMERIC\r\n'); 
fprintf(fid,'@RELATION appcontest\r\n\r\n');
%fprintf(fid,'@ATTRIBUTE g_mag_mean NUMERIC\r\n');                       %1
%fprintf(fid,'@ATTRIBUTE g_mag_max NUMERIC\r\n');                        %2
% fprintf(fid,'@ATTRIBUTE g_mag_range NUMERIC\r\n');                      %3
%fprintf(fid,'@ATTRIBUTE g_mag_zcr_mean NUMERIC\r\n');                   %4
%fprintf(fid,'@ATTRIBUTE g_mag_kurtosis NUMERIC\r\n');                   %5
%fprintf(fid,'@ATTRIBUTE g_mag_mdan NUMERIC\r\n');                       %6
% fprintf(fid,'@ATTRIBUTE g_mag_lzc NUMERIC\r\n');                        %7
% fprintf(fid,'@ATTRIBUTE g_mag_sampen NUMERIC\r\n');                     %8
%fprintf(fid,'@ATTRIBUTE g_mag_dccomponent NUMERIC\r\n');                %9
% fprintf(fid,'@ATTRIBUTE g_mag_peakfreq NUMERIC\r\n');
% fprintf(fid,'@ATTRIBUTE g_mag_peakamp NUMERIC\r\n');                    %10
% fprintf(fid,'@ATTRIBUTE g_mag_halfpeakfreqbandwidth NUMERIC\r\n');      %11
% fprintf(fid,'@ATTRIBUTE g_mag_quarterpeakfreqbandwidth NUMERIC\r\n');   %12
%fprintf(fid,'@ATTRIBUTE g_mag_spectralcentroid NUMERIC\r\n');           %13
%fprintf(fid,'@ATTRIBUTE g_mag_spectralkurtosis NUMERIC\r\n');           %14
% fprintf(fid,'@ATTRIBUTE g_mag_spectralslope NUMERIC\r\n');              %15
%fprintf(fid,'@ATTRIBUTE class {regular,assaulted}\r\n\r\n');
fprintf(fid,'@ATTRIBUTE acc_magx_min NUMERIC\r\n');             
fprintf(fid,'@ATTRIBUTE acc_magx_max NUMERIC\r\n');    
fprintf(fid,'@ATTRIBUTE acc_magx_abs_mean NUMERIC\r\n'); 
fprintf(fid,'@ATTRIBUTE acc_magy_min NUMERIC\r\n');             
fprintf(fid,'@ATTRIBUTE acc_magy_max NUMERIC\r\n');  
fprintf(fid,'@ATTRIBUTE acc_magy_abs_mean NUMERIC\r\n'); 
fprintf(fid,'@ATTRIBUTE acc_magz_min NUMERIC\r\n');             
fprintf(fid,'@ATTRIBUTE acc_magz_max NUMERIC\r\n');  
fprintf(fid,'@ATTRIBUTE acc_magz_abs_mean NUMERIC\r\n'); 
fprintf(fid,'@ATTRIBUTE acc_mag_mean NUMERIC\r\n');  
fprintf(fid,'@ATTRIBUTE acc_magz_peakfreq NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_halfpeakampfreqbandwidth NUMERIC\r\n'); 不用的话会大幅度提高准确率...  
fprintf(fid,'@ATTRIBUTE acc_magz_spectralslope NUMERIC\r\n');   
% fprintf(fid,'@ATTRIBUTE time NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_mag_peakfreq NUMERIC\r\n');
% fprintf(fid,'@ATTRIBUTE g_magx_peakfreq NUMERIC\r\n');  
% fprintf(fid,'@ATTRIBUTE g_magz_kurtosis NUMERIC\r\n');   
% fprintf(fid,'@ATTRIBUTE g_magz_halfpeakfreqbandwidth NUMERIC\r\n'); 
%fprintf(fid,'@ATTRIBUTE class {knock_still,knock_walking,other}\r\n\r\n');
%fprintf(fid,'@ATTRIBUTE class {target}\r\n\r\n');
%fprintf(fid,'@DATA\r\n');
% fprintf(fid,'@ATTRIBUTE class {still_left2right,still_right2left,walking_left2right,walking_right2left,other}\r\n\r\n');
fprintf(fid,'@ATTRIBUTE class {left2right,right2left,other}\r\n\r\n');
%fprintf(fid,'@ATTRIBUTE class {target}\r\n\r\n');
fprintf(fid,'@DATA\r\n');

%% 计算每一个片段的特征并保存
iarg=1;
while iarg<nargin
    segments_cell=varargin{iarg};
    class_str=varargin{iarg+1};
    featurematrix=[];
    if iscell(segments_cell)
        %% iscell
        for i=1:1:size(segments_cell,2)
            %if isactive(segments_cell{1,i})==0
            %    continue;
            %end
            if isempty(segments_cell{1,i})
                continue;
            end
            features=getfeature(segments_cell{1,i});
            
%             By Hansong 2014.12.30
%             if features.g_mag_range<=2*9.8
%                 continue;
%             end
            featurematrix=[featurematrix;...
                features.acc_magx_min,...
                features.acc_magx_max,...
                features.acc_magx_abs_mean,...
                features.acc_magy_min,...
                features.acc_magy_max,...
                features.acc_magy_abs_mean,...
                features.acc_magz_min,...
                features.acc_magz_max,...
                features.acc_magz_abs_mean,...
                features.acc_mag_mean,...
                features.acc_magz_peakfreq,...
                features.acc_magz_spectralslope,...
                ];
        end
    else
        if size(segments_cell,2)==segment_column_count
            %% is matrix
            features=getfeature(segments_cell{1,i});
            featurematrix=[featurematrix;...
%                 features.g_magx_min,...
%                 features.g_magx_max,...
%                 features.g_magx_mean,...
%                 features.g_magy_min,...
%                 features.g_magy_max,...
%                 features.g_magy_mean,...
%                 features.g_magz_min,...
%                 features.g_magz_max,... 
%                 features.g_magz_mean,...   
%                 features.g_mag_range,...
%                 features.g_mag_mean,...
                % features.g_magx_kurtosis,...
                % features.g_magy_kurtosis,...
                % features.g_magz_kurtosis,...
                % features.g_magz_lzc,...
                % features.g_z_sampen,...
                % features.g_magz_peakamp,...
                % features.g_magz_peakfreq,...
                % features.g_magz_halfpeakampfreqbandwidth,...
                % features.g_magz_quarterpeakampfreqbandwidth,...
                % features.g_magz_spectralcentroid,...
                % features.g_magz_spectralkurtosis,...                
                % features.g_magz_spectralslope
                ];
        end
    end
    for i=1:1:size(featurematrix,1)
       % fprintf(fid,'%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g',[featurematrix(i,:)]);
        fprintf(fid,'%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g',[featurematrix(i,:)]);
       fprintf(fid,',%s\r\n',class_str);
    end
    featuerscell=[featuerscell,featurematrix];
    iarg=iarg+2;
end
fclose(fid);


% %% save
% if nargin==2
%     filename=strcat(inputname(1),'_features.arff');
%     fid=fopen(filename,'wt');
%     %填充Weka文件头
%     fprintf(fid,'@RELATION assault\r\n\r\n');
%     fprintf(fid,'@ATTRIBUTE g_mag_mean NUMERIC\r\n');               %1
%     fprintf(fid,'@ATTRIBUTE g_mag_max NUMERIC\r\n');                %2
%     fprintf(fid,'@ATTRIBUTE g_mag_min NUMERIC\r\n');                %3
%     fprintf(fid,'@ATTRIBUTE g_mag_std NUMERIC\r\n');                %4
%     fprintf(fid,'@ATTRIBUTE g_mag_range NUMERIC\r\n');              %5
%     fprintf(fid,'@ATTRIBUTE g_mag_zcr_mean NUMERIC\r\n');           %6
%     fprintf(fid,'@ATTRIBUTE g_mag_kurtosis NUMERIC\r\n');           %7
%     fprintf(fid,'@ATTRIBUTE g_mag_lzc NUMERIC\r\n');                %8
%     fprintf(fid,'@ATTRIBUTE g_mag_sampen NUMERIC\r\n');             %9
%     fprintf(fid,'@ATTRIBUTE g_mag_dccomponent NUMERIC\r\n');        %10
%     fprintf(fid,'@ATTRIBUTE g_mag_peakamp NUMERIC\r\n');            %11
%     fprintf(fid,'@ATTRIBUTE g_mag_peakfreq NUMERIC\r\n');           %12
%     fprintf(fid,'@ATTRIBUTE g_mag_spectralcentroid NUMERIC\r\n');   %13
%     fprintf(fid,'@ATTRIBUTE g_mag_spectralspread NUMERIC\r\n');     %14
%     fprintf(fid,'@ATTRIBUTE g_mag_spectralkurtosis NUMERIC\r\n');   %15
%     fprintf(fid,'@ATTRIBUTE g_mag_spectralslope NUMERIC\r\n');      %16
%     fprintf(fid,'@ATTRIBUTE class {run,walk,down,up,static,assaulted,other}\r\n\r\n');
%     fprintf(fid,'@DATA\r\n');
%     
%     for i=1:1:size(featurematrix,1)
%         fprintf(fid,'%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g',[featurematrix(i,:)]);
%         fprintf(fid,',%s\r\n',class);
%     end
%     fclose(fid);
% end

end

