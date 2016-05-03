%================================================
function x_smoothed=smooth(x,winlen)
%===============================================
%�þ��δ��ڼӾ�ֵ����ƽ��,�������кʹ��ڳ��ȣ�xΪN*1����

len=size(x,1);
x_smoothed=zeros(len,1);

for i=1:1:len
    sum=0;
    counter=0;
    for j=i:1:i+winlen-1
        if j<=len
            sum=sum+x(j,1);
            counter=counter+1;
        end
    end
    x_smoothed(i,1)=sum/counter;
end