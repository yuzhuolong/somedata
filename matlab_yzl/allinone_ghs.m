% % Seg_Other_little=segment(Other_little);
% Seg_Other=segment(Other);
% csv2cell_ghs_train;
% csv2cell_ghs_test;
% 
% Feature_Other=segments2features(Seg_Other,'other');
% % Feature_Other=segments2features(Seg_Other_little,'other');
% Feature_Knock_train=segments2features(Seg_Knock_train,'knock');
% Feature_Knock_test=segments2features(Seg_Knock_test,'knock');
% Feature_Knock_train=cell2mat(Feature_Knock_train);
% Feature_Knock_test=cell2mat(Feature_Knock_test);
% Feature_Other=cell2mat(Feature_Other);



x=gendatoc(Feature_Knock_train,[]);
w=incsvdd(x,0.05,'r');


tic;
t=gendatoc(Feature_Knock_test,Feature_Other);
[e,f]=dd_error(t,w);
% scatterd(x,'legend');
% scatterd(t,'legend');
% plotc(w);
e
f
disp('svdd test time!');
toc;
tt=toc*1000;
tt

% Seg_Other=segment(Other);
% csv2cell_ghs_still;
% csv2cell_ghs_walking;
% segments2features(Seg_Other,'other',Seg_Knock_still,'knock_still',Seg_Knock_walking,'knock_walking');
% segments2features(Seg_Knock_still,'knock_still');