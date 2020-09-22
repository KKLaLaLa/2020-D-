clear;
clc;

Ant     =   60;    % 蚂蚁数量
Times   =   50;     % 蚂蚁移动次数
Rho     =   0.9;    % 信息素挥发系数
P0      =   0.2;    % 转移概率常数
xl = 10; xu = 50;    % m范围

step = 0.05; 
ants = initant(Ant, xl, xu);    % 初始化蚁群
caul_num = 800;
g = rand(2, caul_num);
tau = calObjFun(ants,g);                  % 计算初代信息素
firstants = ants;

for t = 1:Times
    t
    ants = edgeselection(ants, tau, P0, 1/t, xl, xu,g);    % 转移+约束
    tau = (1 - Rho) .* tau + calObjFun(ants,g);               % 更新信息素
end

figure(1);
A_ = calObjFun(firstants,g);
plot(firstants(:,1),A_ , 'b*');
hold on;
A= calObjFun(ants,g);
plot(ants(:,1),A, 'r*');
% hold off;