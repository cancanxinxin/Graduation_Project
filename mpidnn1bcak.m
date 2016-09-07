%û��ʹ��PIDNN��ѧϰ�㷨������ʹ�õ�BP��ѧϰ�㷨
function uu = mpidnn1(u,WW)
t = u(end);
persistent x y1 uu1 V_TEMP ST1 ST2 t_1;
persistent hidenlayer input_d output_d hidenlayer_d xite alfa I_temp D_temp layer_vector layer_yz Dlayer_yz_1 Dlayer_yz_2 W;
persistent DW_1 DW_2 up_b down_b;
if t==0
    up_b=0.25;
    down_b=-0.25;
    hidenlayer=1;                 %������
    input_d=2;                    %����ά��
    output_d=4;                   %�������ά��
    hidenlayer_d=6;               %����ά��
    xite=0.01;                    %��������
    alfa=0.05;                       %ѧϰ��
    % input_vector=rand(input_d,1);  %������������
    % exp_vector=rand(output_d,1);   %�����������
    I_temp=zeros(hidenlayer_d,1);
    D_temp = zeros(hidenlayer_d,1);
    
    y1 = zeros(input_d,3);
    uu1 = zeros(output_d,3);
    t_1 = 0;
    %% �����������
    layer_vector{1}=zeros(input_d,1);%��������
    for i=2:hidenlayer+1
        layer_vector{i}=zeros(hidenlayer_d,1);%�������
    end
    layer_vector{hidenlayer+2}=zeros(output_d,1);%�������
    
    %% ��ֵ
    for i=1:hidenlayer
        layer_yz{i}=rand(hidenlayer_d,1);%�������
    end
    layer_yz{hidenlayer+1}=rand(output_d,1);%�������
    Dlayer_yz_1=layer_yz;%��ֵ�ı���
    Dlayer_yz_2=layer_yz;%��ֵ�ı���
    
    %% Ȩֵ
    W{1}=rand(hidenlayer_d,input_d);
    for i=2:hidenlayer
        W{i}=rand(hidenlayer_d,hidenlayer_d);
    end
    W{hidenlayer+1}=rand(output_d,hidenlayer_d);
    DW_1=W;%Ȩֵ�ı���
    DW_2=W;%Ȩֵ�ı���
    
    x=-0.1+rand(1,36).*0.2;
    %     x=WW;
    temp(:,1)=x(1:6)';
    temp(:,2)=x(7:12)';
    W{1} = temp;
    temp2(1,:)=x(13:18);
    temp2(2,:)=x(19:24);
    temp2(3,:)=x(25:30);
    temp2(4,:)=x(31:36);
    W{2} = temp2;
    
    
    uu = layer_vector{3};
    return;
end
y1(:,2:3) = y1(:,1:2);
y1(:,1) = [u(3);u(4)];

% %% ����ѧϰ
if t-t_1>=0.01
    t_1=t;
    e=u(1:2);%����������
    e=tansig(e).*0.3;
    A = (y1(:,1)-y1(:,2))*(1./(uu1(:,1)-uu1(:,2)+1E-20))';
    A = sign(A)';
    delta{hidenlayer+1}=A*e;
    % delta{hidenlayer+1}=e;%���������deta
    DW_1{hidenlayer+1}=delta{hidenlayer+1}*layer_vector{hidenlayer+1}';%����Ȩֵ�޸���
    Dlayer_yz_1{hidenlayer+1}=-delta{hidenlayer+1};%������ֵ�޸���
    for i=hidenlayer:-1:1
        delta{i}=(delta{i+1}'*W{i+1})'.*(layer_vector{i+1}+1).*(1-layer_vector{i+1}); %�����м��deltaֵ
        DW_1{i}=delta{i}*layer_vector{i}';%�����м��Ȩֵ�޸���
        Dlayer_yz_1{i}=-delta{i};%�����м����ֵ�޸���
    end
    
    for i=1:hidenlayer+1 %�޸�Ȩֵ����ֵ
        W{i}=W{i}+xite.*DW_1{i}+alfa.*DW_2{i};
        layer_yz{i}=layer_yz{i}+xite.*Dlayer_yz_1{i}+alfa.*Dlayer_yz_2{i};
        DW_2{i}=DW_1{i};
        Dlayer_yz_2{i}=Dlayer_yz_1{i};
    end
end


%% ǰ�򴫵�
u(find(u>=up_b))=up_b;
u(find(u<=down_b))=down_b;
layer_vector{1}=[u(1);u(2)];
for i=1:hidenlayer
    %     layer_vector{i+1}=W{i}*layer_vector{i}-layer_yz{i};
    %     layer_vector{i+1}=(1./(1+exp(-layer_vector{i+1})));
    sum=W{i}*layer_vector{i};%-layer_yz{i};
    %             layer_vector{i+1}=tansig(sum);%bp����
    layer_vector{i+1}(1:3:end)=sum(1:3:end);%������Ԫ
    layer_vector{i+1}(2:3:end)=sum(2:3:end)+I_temp(2:3:end);%������Ԫ
    layer_vector{i+1}(3:3:end)=sum(3:3:end)-D_temp(3:3:end);%΢����Ԫ
    layer_vector{i+1} = tansig(layer_vector{i+1}).*up_b;
    I_temp = layer_vector{i+1};
    D_temp = sum;
end
% layer_vector{hidenlayer+2}=W{hidenlayer+1}*layer_vector{hidenlayer+1};
% layer_vector{hidenlayer+2}=(1./(1+exp(-layer_vector{hidenlayer+2})));
sum=W{hidenlayer+1}*layer_vector{hidenlayer+1};%-layer_yz{hidenlayer+1};
sum(find(sum>=up_b))=up_b;
sum(find(sum<=down_b))=down_b;
layer_vector{hidenlayer+2}=sum;
uu = layer_vector{hidenlayer+2};
uu1(:,2:3) = uu1(:,1:2);
uu1(:,1) = uu;
end