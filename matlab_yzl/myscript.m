
findics=[2,3];
xt=trainadl_features_n(:,findics);
tt=testadl_features_n(:,findics);
to=testassault_features(:,findics);

xt;     %����ѵ��������������ճ���Ϊ���ݼ�
tt;     %���ڲ��Ե�����������ճ���Ϊ���ݼ�
to;     %���ڲ��Ե���������ı�Ϯ����Ϊ���ݼ�

x=gendatoc(tt,[]);
w=incsvdd(x,0,'r');
t=gendatoc(xt,to);
e=dd_error(t,w);