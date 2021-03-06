function segments = segmentPMC(rawdata)
%segment函数：将原始数据按照不同窗口类型进行划分，得到多个片段便于后续的处理
%输入：原始数据
%输出：元胞数组每一个元素是一个划分后的片段

window_type=1;  %1:固定个数，2：固定时间间隔
overlap_factor=0.6;     %相邻窗口的重叠比率
%fixed_number_winlen=51;
fixed_number_winlen = 200;
fixed_interval_winlen=795; %毫秒
timestamp_column=14;       %相对时间的列号

segments={};
if window_type==1
    %固定个数片段
    temp=[];
    i=1;
    next_win_index=0;
    counter=0;
    while i<= size(rawdata,1)
        if counter==fixed_number_winlen
            %已经达到一个片段的个数
            %只保留活跃片段
            %if isactive(temp)==1
                segments=[segments,temp];
            %end
            i=next_win_index;
            temp=[];
            counter=0;
        else if counter==round(fixed_number_winlen*(1-overlap_factor))
                %到达下个片段的开始索引了
                temp=[temp;rawdata(i,:)];
                counter=counter+1;
                next_win_index=i;
            else
                temp=[temp;rawdata(i,:)];
                counter=counter+1;
            end
        end
        i=i+1;
        
    end
else
    %固定时间间隔片段
    temp=[];
    i=1;
    next_win_index=0;
    start_timestamp=rawdata(1,timestamp_column);
    win_moved=true;
    while i<= size(rawdata,1)
        if rawdata(i,timestamp_column)-start_timestamp>fixed_interval_winlen
            if win_moved==false
                %窗口还没移动就已经到达片段末尾了
                next_win_index=i;
            end
            %只保留活跃片段
            if isactive(temp)==1
                segments=[segments,temp];
            end
            i=next_win_index;
            start_timestamp=rawdata(i,timestamp_column);
            temp=[];
            win_moved=false;
        else if rawdata(i,timestamp_column)-start_timestamp>fixed_interval_winlen*(1-overlap_factor) && (next_win_index<=0 || rawdata(next_win_index,timestamp_column)-start_timestamp<=0)
                temp=[temp;rawdata(i,:)];
                next_win_index=i;
                win_moved=true;
            else 
                temp=[temp;rawdata(i,:)];
            end
        end
        i=i+1;
    end
end
end

