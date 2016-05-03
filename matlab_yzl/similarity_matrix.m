function m = similarity_matrix( featurematrix1,featurematrix2 )
%similarity_matrix 计算两个特征矩阵的相似矩阵
%   featurematrix：特征矩阵，每一行就是一个特征向量，代表一个segment的特征

featureindexset=[4,5,6,7,10,11,12,13,14];
%% CHECK
if size(featurematrix1,2)~=size(featurematrix2,2)
    disp('输入矩阵列数不同');
    return;
end
%% Normalization
normfeaturematrix1=zeros(size(featurematrix1));
normfeaturematrix2=zeros(size(featurematrix2));
for i=1:1:size(featurematrix1,2)
    column=[featurematrix1(:,i);featurematrix2(:,i)];
    maxV=max(column);
    minV=min(column);
    normfeaturematrix1(:,i)=(featurematrix1(:,i)-minV)./(maxV-minV);
    normfeaturematrix2(:,i)=(featurematrix2(:,i)-minV)./(maxV-minV);
end
%% Calculate Eculid Distance
mergenormmatrix=[normfeaturematrix1;normfeaturematrix2];
m=zeros(size(mergenormmatrix,1),size(mergenormmatrix,1));
for i=1:1:size(mergenormmatrix,1)
    for j=1:1:size(mergenormmatrix,1)
        d=0;
        for k=1:1:size(featureindexset,2)
            d=d+(mergenormmatrix(i,featureindexset(k))-mergenormmatrix(j,featureindexset(k)))^2;
        end
        m(i,j)=d;
    end
end

%% Generate Similarity_matrix


end

