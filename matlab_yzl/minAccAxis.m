function [ axisstr,changecounter ] = minAccAxis( segment )
%minAccAxis 得到最小加速度(重力传感器)对应轴的字符序列，如"zzzzzyyyxxzzzzz"
%   输入：原始segment
%   输出：最小加速度对应轴的字符序列
%   此处显示详细说明

axisstr='';
changecounter=0;
preAccAxis='';

for i=1:1:size(segment,1)
    minAccAxis='x';
    minAcc=segment(i,1);
    if segment(i,2)<minAcc
        minAccAxis='y';
        minAcc=segment(i,2);
    end
    if segment(i,3)<minAcc
        minAccAxis='z';
        minAcc=segment(i,3);
    end
    axisstr=strcat(axisstr,minAccAxis);
    if ~strcmp(minAccAxis,preAccAxis)
        changecounter=changecounter+1;
    end
    preAccAxis=minAccAxis;
end


end

