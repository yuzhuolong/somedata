magnitude=zeros(size(disorder,1),1);
for i=1:1:size(disorder,1)
    magnitude(i,1)=sqrt(disorder(i,1)^2+disorder(i,2)^2+disorder(i,3)^2);
end
plot(disorder(:,13),magnitude)