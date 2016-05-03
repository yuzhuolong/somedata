Seg_Knock_test=cell(1,18);
% time=[];

for i=1:1:18
    row=(i-1)*20+1:1:i*20;
    Seg_Knock_test{i}=Knock_test(row,:);
%     time=[time;Seg_Knock{i}(20,14)-Seg_Knock{i}(1,14)];
end

% time
% min(time)
% max(time)
% mean(time)