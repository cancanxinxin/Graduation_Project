function  cs_search(Lb,Ub,ObjFun)
global nest best fmin fitness best_ind best_ind_fitness Vstep c1 c2 w Vmax Vmin levy_times rate p_s p_m;
n=size(nest,1);

[fitness_temp k]=sort(fitness);%%%���ܹ�����ԭ����˳��ֻ���ǰ20λ�����Ӱ���PSO�㷨ִ�м���
% m = round(n*rate);
m = 0;

flag_go = 0;

    flag_go = 1;
for j=1:levy_times %levy����5��
    cuckoo_nest{j}=get_cuckoos(Lb,Ub);
    parfor i = 1:n
        new_fitness(j,i)=fobj(cuckoo_nest{j}(i,:),ObjFun);
    end
end
[minf index]=min(new_fitness,[],1);
for i=m+1:n %levy����5��
    if minf(k(i))<fitness(k(i))
        fitness(k(i))=minf(k(i));
        nest(k(i),:)=cuckoo_nest{index(k(i))}(k(i),:);
    end
    if minf(k(i))<best_ind_fitness(k(i))
        best_ind_fitness(k(i))=minf(k(i));
        best_ind(k(i),:)=cuckoo_nest{index(k(i))}(k(i),:);
    end
    if minf(k(i))<fmin
        fmin=minf(k(i));
        best=cuckoo_nest{index(k(i))}(k(i),:);
    end
end
end