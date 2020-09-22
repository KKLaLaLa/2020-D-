clear;
clc;

Ant     =   60;    % ��������
Times   =   50;     % �����ƶ�����
Rho     =   0.9;    % ��Ϣ�ػӷ�ϵ��
P0      =   0.2;    % ת�Ƹ��ʳ���
xl = 10; xu = 50;    % m��Χ

step = 0.05; 
ants = initant(Ant, xl, xu);    % ��ʼ����Ⱥ
caul_num = 800;
g = rand(2, caul_num);
tau = calObjFun(ants,g);                  % ���������Ϣ��
firstants = ants;

for t = 1:Times
    t
    ants = edgeselection(ants, tau, P0, 1/t, xl, xu,g);    % ת��+Լ��
    tau = (1 - Rho) .* tau + calObjFun(ants,g);               % ������Ϣ��
end

figure(1);
A_ = calObjFun(firstants,g);
plot(firstants(:,1),A_ , 'b*');
hold on;
A= calObjFun(ants,g);
plot(ants(:,1),A, 'r*');
% hold off;