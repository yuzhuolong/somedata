DTW_train_csv2cell_ghs_left2right;
DTW_train_csv2cell_ghs_right2left;
DTW_trainSet=[DTW_train_left2right,DTW_train_right2left];
load('OtherPMC.csv');
Seg_Other=segmentPMC(OtherPMC);

Seg_Other=Seg_Other(1:20);

labels_Other=cell(length(Seg_Other),1);
for i=1:1:length(Seg_Other)
    labels_Other{i}='other';
end

DTW_test_csv2cell_ghs_left2right;
new_DTW_test_left2right=DTW_test_left2right(~cellfun(@(x)(isempty(x)),DTW_test_left2right));
labels_left2right=cell(length(new_DTW_test_left2right),1);
for i=1:1:length(new_DTW_test_left2right)
    labels_left2right{i}='left2right';
end

DTW_test_csv2cell_ghs_right2left;
new_DTW_test_right2left=DTW_test_right2left(~cellfun(@(x)(isempty(x)),DTW_test_right2left));
labels_right2left=cell(length(new_DTW_test_right2left),1);
for i=1:1:length(new_DTW_test_right2left)
    labels_right2left{i}='right2left';
end

labels=[labels_Other;labels_left2right;labels_right2left];

DTW_testSet=[Seg_Other,new_DTW_test_left2right,new_DTW_test_right2left];




DTW_trainSet=cellfun(@(x)x(:,1)',DTW_trainSet,'UniformOutput',0);
DTW_testSet=cellfun(@(x)x(:,1)',DTW_testSet,'UniformOutput',0);

% DTW_testSet=DTW_testSet(1:10);
% labels=labels(1:10);

dtwDist=cell(length(DTW_testSet));
for kk = 1:numel(DTW_testSet)
    disp(kk);
    dtwDist{kk} = cellfun(@(x)util_DTW_new(DTW_testSet{kk}, x), ...
            DTW_trainSet);        
%     [~, tempIndex] = sort(dtwDist);

    %     tempIDSet = cellfun(@(x)util_GetClassID(x, 'num'), ...
    %             trainingLabels);
%     idSet(kk) = mode(trainingLabels(tempIndex(1:K)));
end



dtwDist=cell2mat(dtwDist);
labels = cellfun(@(x)(sprintf('%s', x)), ...
                        labels, 'UniformOutput', false);
dumpFeaturesToWeka(dtwDist, labels);  