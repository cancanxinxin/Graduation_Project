figure(1)
hFig=figure(1);
set(hFig, 'Position', [300 300 600 280])
plot(fitness_list,'linewidth',2);
hold on
plot(fitness_list1,'linewidth',2);
grid on
box off
axis([0 200 0 inf])
legend('�Ľ��������㷨', '���䲼�����㷨');
xlabel('��������')
ylabel('��Ӧ��ֵ')