
findics=[2,3];
xt=trainadl_features_n(:,findics);
tt=testadl_features_n(:,findics);
to=testassault_features(:,findics);

xt;     %用于训练单类分类器的日常行为数据集
tt;     %用于测试单类分类器的日常行为数据集
to;     %用于测试单类分类器的被袭击行为数据集

x=gendatoc(tt,[]);
w=incsvdd(x,0,'r');
t=gendatoc(xt,to);
e=dd_error(t,w);