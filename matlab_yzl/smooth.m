%================================================
function x_smoothed=smooth(x,winlen)
%===============================================
%用矩形窗口加均值进行平滑,输入序列和窗口长度，x为N*1向量

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