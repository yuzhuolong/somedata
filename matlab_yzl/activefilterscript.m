%Active Segment Filter
r=testadl_segments_features;
c=testadl_segments;
r_out=[];
c_out={};
sign=r{1,1}(:,3)>2*9.8;
for i=1:1:size(sign,1)
    if sign(i)==1
        r_out=[r_out;r{1,1}(i,:)];
        c_out=[c_out,c{1,i}];
    end
end
F_testadl_features=r_out;
F_testadl_segments=c_out;

figure
scatter(F_testassault_features(:,10),F_testassault_features(:,11),'r');
hold on
scatter(F_testadl_features(:,10),F_testadl_features(:,11),'b');