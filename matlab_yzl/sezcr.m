%======================================================
function [se,zcr]=sezcr(x,winlen)
%======================================================
%计算序列的短时能量和短时过零率，输入序列和窗口长度,x为N*1向量

len=size(x,1);
se=zeros(len,1);
zcr=zeros(len,1);

for i=1:1:(len-winlen)
    sumenergy=0;
    countercross=0;
    for j=i:1:(i+winlen-1)
        sumenergy=sumenergy+x(j,1)^2;
        if (j+1)<(j+winlen)
            if sgn(x(j,1))~=sgn(x(j+1,1))
                countercross=countercross+1;
            end
        end
    end
    se(i,1)=sumenergy;
    zcr(i,1)=countercross/winlen;
end