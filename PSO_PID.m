function z=PSO_PID(x)
x=x';
assignin('base','WW',x);
% load('3-26-3');%����λ��ģ��
load('dianjisudu');%�����ٶ�ģ��
assignin('base','tf1',tf1);
out = sim('pingtai_with_control_gaijinPIDNN3_2jianhua',[0,50]);%ʹ�ü�ģ��
% out = sim('pingtai_with_control_gaijinPIDNN3_2',[0,50]);%ʹ��ԭʼģ��
itae=out.get('ITAE').signals.values(end);%%ITAEָ��
segma1 = min(out.get('thetax').signals(1,2).values-out.get('thetax').signals(1,1).values);%%������
segma2 = min(out.get('thetay').signals(1,2).values-out.get('thetay').signals(1,1).values);
segma = segma1 + segma2;
segma = abs(segma);
z = itae + segma*1000;