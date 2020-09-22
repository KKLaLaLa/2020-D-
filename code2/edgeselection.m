function sants = edgeselection(ants, tau, P0, lamda, xl, xu,g)
% 状态转移 + 约束边界
% ants          input  蚁群
% tau           input  信息素
% P0            input  转移概率常数
% lamda         input  局部搜索参数
% xl            input  x最小值
% xu            input  x最大值
% yl            input  y最小值
% yu            input  y最大值
% sants         output 输出蚁群
sants = ants;

% 计算状态转移概率
[taubest, ~] = max(tau);
p = abs((taubest - tau) / taubest);
lsindex = find(p < P0);
gsindex = find(p >= P0);

% 局部搜索
r = rand(length(lsindex), 1);
sants(lsindex) = sants(lsindex) + (2 .* r - 1) .* lamda;

% 全局搜索
r = rand(length(gsindex), 1);
gedge = repmat(xu-xl, length(gsindex), 1);
sants(gsindex) = sants(gsindex) + gedge .* (r - 0.5);
% 约束边界
sants(sants(:) < xl, 1) = xl;
sants(sants(:) > xu, 1) = xu;
% 选择
objvalue = calObjFun(ants,g);
sobjvalue = calObjFun(sants,g);
tindex = find(sobjvalue < objvalue);
sants(tindex, :) = ants(tindex, :);
