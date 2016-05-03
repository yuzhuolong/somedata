function [ featurematrix_n ] = normal( featurematrix,totalfeaturematrix )
%normal 对特征矩阵进行归一化
%输入：  特征矩阵，每一行是一个特征向量

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

