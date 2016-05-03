% Seg_Other_little=segment(Other_little);
% csv2cell_ghs_train;
% csv2cell_ghs_test;

% Feature_Other=segments2features(Seg_Other,'other');
% Feature_Other=segments2features(Seg_Other_little,'other');
% Feature_Knock_train=segments2features(Seg_Knock_train,'knock');
% Feature_Knock_test=segments2features(Seg_Knock_test,'knock');
% Feature_Knock_train=cell2mat(Feature_Knock_train);
% Feature_Knock_test=cell2mat(Feature_Knock_test);
% Feature_Other=cell2mat(Feature_Other);
% x=gendatoc(Feature_Knock_train,[]);
% w=incsvdd(x,0.05,'r');
% t=gendatoc(Feature_Knock_test,Feature_Other);
% e=dd_error(t,w);
% e


load('OtherPMC_yzl.csv');
Seg_Other=segmentPMC(OtherPMC_yzl);
%Seg_Other=segmentPMC(OtherPMC);
csv2cell_ghs_left2right;  % still_drop
csv2cell_ghs_right2left;  % walking_drop

% csv2cell_ghs_still_left2right;
% csv2cell_ghs_still_right2left;
% csv2cell_ghs_walking_left2right;
% csv2cell_ghs_walking_right2left;
segments2features_weka(...
    Seg_Other,'other',...
    left2right,'left2right',...
    right2left,'right2left');
%     still_left2right,'still_left2right',...
%     still_right2left,'still_right2left',...
%     walking_left2right,'walking_left2right',...
%     walking_right2left,'walking_right2left',...
% segments2features(Seg_Knock_still,'knock_still');
disp('ok!');