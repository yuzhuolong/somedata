function [ axisstr,changecounter ] = minAccAxis( segment )
%minAccAxis �õ���С���ٶ�(����������)��Ӧ����ַ����У���"zzzzzyyyxxzzzzz"
%   ���룺ԭʼsegment
%   �������С���ٶȶ�Ӧ����ַ�����
%   �˴���ʾ��ϸ˵��

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

