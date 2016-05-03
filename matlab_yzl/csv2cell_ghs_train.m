Seg_Knock_train=cell(1,162);
% time=[];

for i=1:1:162
    row=(i-1)*20+1:1:i*20;
    Seg_Knock_train{i}=Knock_train(row,:);
%     time=[time;Seg_Knock_train{i}(20,14)-Seg_Knock_train{i}(1,14)];
end

% time
% min(time)
% max(time)
% mean(time)