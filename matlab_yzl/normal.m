function [ featurematrix_n ] = normal( featurematrix,totalfeaturematrix )
%normal ������������й�һ��
%���룺  ��������ÿһ����һ����������

featurematrix_n=[];
for i=1:1:size(featurematrix,2)
    columnn=totalfeaturematrix(:,i);
    maxv=max(columnn);
    meanv=mean(columnn);
    stdv=std(columnn);
    minv=min(columnn);
    featurematrix_n(:,i)=(featurematrix(:,i)-minv)./(maxv-minv);
end


end

