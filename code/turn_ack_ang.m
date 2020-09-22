function flag = turn_ack_ang(mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t_m)
popsize = 1;       % ��Ⱥ��ģ
birdsize = 50;      % ��������
w = 0.5;            % ����Ȩ��
c1 = 1.0;           % ��֪����
c2 = 2.0;           % �������
maxgen = 100;       % ����������
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

% ��ʼ��
x = rand(birdsize,popsize)*4*Vh*t_m - 2*Vh*t_m;
v = rand(birdsize,popsize);

% ��ʼ��pid��pgd
fitness = psocalfitness(x,mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t);
pid = x;
pidfit = fitness;
[bfit, bfiti] = max(fitness);
pgd = x(bfiti);
pgdfit = bfit;

% ��¼ÿ������ֵ
bestpidfit = zeros(popsize, 1);
for gen = 1:maxgen
    % �����ٶȺ�λ��
    v = w .* v + c1 .* rand .* (pid - x) + ... 
        c2 .* rand .* (pgd - x);
    x = x + v;

    % ����pid��pgd
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
% fprintf("������daֵ�� %f\n", pgdfit);
% figure(1);
% plot(1:maxgen, bestpidfit);
% title("ÿ��������Ӧ��ֵ�仯����");




