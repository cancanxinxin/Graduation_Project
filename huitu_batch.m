%% ֧��λ�û�ͼ
figure(1)
hFig=figure(1);
set(hFig, 'Position', [300 300 600 280])
plot(zposition.time,zposition.signals.values,'linewidth',2)
xlabel('Time (s)')
ylabel('Height (mm)')
grid on
box off
legend('֧��1', '֧��2','֧��3','֧��4');
%% ƽ̨��ǻ�ͼ
figure(2)
hFig=figure(2);
set(hFig, 'Position', [300 300 600 280])
plot(theta.time,theta.signals.values,'linewidth',2)
xlabel('Time (s)')
ylabel('Angle (deg)')
grid on
box off
legend('��x', '��y');
%% ֧��������ͼ
figure(3)
hFig=figure(3);
set(hFig, 'Position', [300 300 600 280])
plot(force.time,force.signals.values,'linewidth',2)
xlabel('Time (s)')
ylabel('Force (N)')
grid on
box off
legend('֧��1', '֧��2','֧��3','֧��4');

%% ֧���쳤����ͼ
figure(4)
hFig=figure(4);
set(hFig, 'Position', [300 300 600 280])
plot(scl.time,scl.signals.values,'linewidth',2)
xlabel('Time (s)')
ylabel('Length (mm)')
grid on
box off
legend('֧��1', '֧��2','֧��3','֧��4');