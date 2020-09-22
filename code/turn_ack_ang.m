function flag = turn_ack_ang(mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t_m)
popsize = 1;       % 种群规模
birdsize = 50;      % 粒子数量
w = 0.5;            % 惯性权重
c1 = 1.0;           % 认知因子
c2 = 2.0;           % 社会因子
maxgen = 100;       % 最大迭代次数
v = 0.25;
t = 0.1;

suoyin = 10;

t_m = t_m * suoyin;
Vg = Vg * suoyin;
Vh = Vh * suoyin;
mov_x = mov_x * suoyin;
mov_y = mov_y * suoyin;
r1mov_x = r1mov_x * suoyin;
r1mov_y = r1mov_y * suoyin;
r2mov_x = r2mov_x * suoyin;
r2mov_y = r2mov_y * suoyin;

% 初始化
x = rand(birdsize,popsize)*4*Vh*t_m - 2*Vh*t_m;
v = rand(birdsize,popsize);

% 初始化pid，pgd
fitness = psocalfitness(x,mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t);
pid = x;
pidfit = fitness;
[bfit, bfiti] = max(fitness);
pgd = x(bfiti);
pgdfit = bfit;

% 记录每代最优值
bestpidfit = zeros(popsize, 1);
for gen = 1:maxgen
    % 更新速度和位置
    v = w .* v + c1 .* rand .* (pid - x) + ... 
        c2 .* rand .* (pgd - x);
    x = x + v;

    % 更新pid，pgd
    fitness = psocalfitness(x,mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t);
    index = find(fitness > pidfit);
    pid(index, :) = x(index, :);
    pidfit(index, 1) = fitness(index, 1);
    [bfit, bfiti] = max(fitness);
    bestpidfit(gen, 1) = bfit;
    if bfit > pgdfit
        pgd = x(bfiti);
        pgdfit = bfit;
    end
end
flag = pgd/(suoyin^2);
% disp(pgd);
% fprintf("函数最da值： %f\n", pgdfit);
% figure(1);
% plot(1:maxgen, bestpidfit);
% title("每代最优适应度值变化曲线");




