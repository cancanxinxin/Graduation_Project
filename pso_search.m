function  pso_search(Lb,Ub,ObjFun)
% �ٶȸ���
%
global nest best fmin fitness best_ind best_ind_fitness Vstep c1 c2 w Vmax Vmin levy_times rate p_s p_m;
n=size(nest,1);
m = n;
% [fitness_temp k]=sort(fitness);%%%���ܹ�����ԭ����˳��ֻ���ǰ20λ�����Ӱ���PSO�㷨ִ�м���
for i = 1:m
    Vstep(i,:)=w*Vstep(i,:)+c1*rand*(best-nest(i,:))+c2*rand*(best_ind(i,:)-nest(i,:));%��ʹ��ȫ������ֵ��������
    Vstep(i,find(Vstep(i,:)>Vmax))=Vmax;
    Vstep(i,find(Vstep(i,:)<Vmin))=Vmin;
end
for i = 1:m %λ�ø���
    newnest(i,:) = nest(i,:)+Vstep(i,:);
    s= newnest(i,:);
    nest(i,:)=simplebounds(s,Lb,Ub);
end
% fiteness_temp = ones(1,m)*10^10;
parfor i = 1:m%������Ӧ��
    fiteness(i)=fobj(nest(i,:),ObjFun);
end
for i = 1:m  %��Ⱥ����
    if fitness(i)<best_ind_fitness(i)%�������Ÿ���
        best_ind_fitness(i)=fitness(i);
        best_ind(i,:) = nest(i,:);
    end
    if fitness(i)<fmin %ȫ�����Ÿ���
        fmin=fitness(i);
        best = nest(i,:);
    end
end
end