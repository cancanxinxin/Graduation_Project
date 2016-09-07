% function [bestnest,fmin_out,iter_times,N_times,flag_success]=PSO(n,Dim,ObjFun)
%% ��ջ���
% clc
% clear all
% close all
%% ��������
% Dim = Dim1;            % ά��
% if nargin<1,
    % Number of nests (or different solutions)
tic    
% open_system('pingtai_with_control_gaijinPIDNN3_2');
% simulator = sdo.SimulationTest('pingtai_with_control_gaijinPIDNN3_2');
% simulator = fastRestart(simulator,'on');
    n=21;
    MaxIter=10;
    Dim =24;
    ObjFun = @PSO_PID;
% end
MaxIter=10;
flag_success =0;
w = 0.8;      % ��������
% c1 = 1.49445;       % ���ٳ���
% c2 = 1.49445;       % ���ٳ���
c1 = 2;       % ���ٳ���
c2 = 2;       % ���ٳ���


SwarmSize = n;    % ����Ⱥ��ģ
Vaule_max=2;    % ���ֵ����
Vaule_min=-2;    % ���ֵ����
% ObjFun = @Griewank2;  % ���Ż��������
% ObjFun = @Schaffer2;  % ���Ż��������
% ObjFun = @Rastrigin2;  % ���Ż��������

% MaxIter = 100000;      % ����������
MinFit = 0.000000000001;       % ��С��Ӧֵ

Vmax = 0.1;
Vmin = -0.1;

Ub = ones(1,Dim)*Vaule_max;
Lb = ones(1,Dim)*Vaule_min;
trace=[];

%% ����Ⱥ��ʼ��
Range = ones(SwarmSize,1)*(Ub-Lb);
Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;      % ��ʼ������Ⱥ
VStep = rand(SwarmSize,Dim)*(Vmax-Vmin) + Vmin;                 % ��ʼ���ٶ�
fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = feval(ObjFun,Swarm(i,:)')+1e-7; % ����Ⱥ����Ӧֵ
end

%% ���弫ֵ��Ⱥ�弫ֵ
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % ȫ�����
gbest=Swarm;                % �������
fgbest=fSwarm;              % ���������Ӧֵ
fzbest=bestf;               % ȫ�������Ӧֵ

%% ����Ѱ��

iter = 0;
y_fitness = zeros(1,MaxIter);   % Ԥ�Ȳ���4���վ���
K_p = zeros(1,MaxIter);
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
flag=0;
while( (iter < MaxIter)  )
    for i=1:SwarmSize
        fSwarm(i,:) = feval(ObjFun,Swarm(i,:)')+1e-7; % ����Ⱥ����Ӧֵ
    end
    
    for j=1:SwarmSize
        % �������Ÿ���
        if fSwarm(j) < fgbest(j)
            gbest(j,:) = Swarm(j,:);
            fgbest(j) = fSwarm(j);
        end
        % Ⱥ�����Ÿ���
        if fSwarm(j) < fzbest
            zbest = Swarm(j,:);
            fzbest = fSwarm(j);
        end
    end
    for j=1:SwarmSize
        % �ٶȸ���
        VStep(j,:) = w*VStep(j,:) + c1*rand*(gbest(j,:) - Swarm(j,:)) + c2*rand*(zbest - Swarm(j,:));
        VStep(j,find(VStep(j,:)>Vmax))=Vmax;
        VStep(j,find(VStep(j,:)<Vmin))=Vmin;
        % λ�ø���
        Swarm(j,:)=Swarm(j,:)+VStep(j,:);
        for k=1:Dim
            if Swarm(j,k)>Ub(k), Swarm(j,k)=Ub(k); end
            if Swarm(j,k)<Lb(k), Swarm(j,k)=Lb(k); end
        end
    end
    iter=iter+1
    avgfitness=sum(fSwarm)/SwarmSize;
    trace=[trace;avgfitness fzbest]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
    %     iter = iter+1;                      % ������������
    %     y_fitness(1,iter) = fzbest;         % Ϊ��ͼ��׼��
    %     K_p(1,iter) = zbest(1);
    %     K_i(1,iter) = zbest(2);
    if fzbest <=5e-7
        flag_success = 1;%�ɹ��ñ�־λ
    end
end
bestnest = zbest;
fmin_out = fzbest;
iter_times = iter;
N_times = iter*n;


%% ��ͼ���
[r,c]=size(trace);
figure
% plot([1:r]',trace(:,1),'r-',[1:r]',trace(:,2),'b--');
plot([1:r]',trace(:,2),'b--');
title(['PSO����ֵ����  ' '��ֹ������' num2str(MaxIter)],'fontsize',12);
xlabel('��������','fontsize',12);ylabel('����ֵ','fontsize',12);
legend('����ƽ��ֵ','�������ֵ','fontsize',12);
% ylim([-0 1.01])
disp('����ֵ                   ����');
% ������ʾ
disp([fzbest zbest]);
toc
%%
% ret=[fzbest iter flag];
% end
