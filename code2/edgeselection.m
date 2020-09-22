function sants = edgeselection(ants, tau, P0, lamda, xl, xu,g)
% ״̬ת�� + Լ���߽�
% ants          input  ��Ⱥ
% tau           input  ��Ϣ��
% P0            input  ת�Ƹ��ʳ���
% lamda         input  �ֲ���������
% xl            input  x��Сֵ
% xu            input  x���ֵ
% yl            input  y��Сֵ
% yu            input  y���ֵ
% sants         output �����Ⱥ
sants = ants;

% ����״̬ת�Ƹ���
[taubest, ~] = max(tau);
p = abs((taubest - tau) / taubest);
lsindex = find(p < P0);
gsindex = find(p >= P0);

% �ֲ�����
r = rand(length(lsindex), 1);
sants(lsindex) = sants(lsindex) + (2 .* r - 1) .* lamda;

% ȫ������
r = rand(length(gsindex), 1);
gedge = repmat(xu-xl, length(gsindex), 1);
sants(gsindex) = sants(gsindex) + gedge .* (r - 0.5);
% Լ���߽�
sants(sants(:) < xl, 1) = xl;
sants(sants(:) > xu, 1) = xu;
% ѡ��
objvalue = calObjFun(ants,g);
sobjvalue = calObjFun(sants,g);
tindex = find(sobjvalue < objvalue);
sants(tindex, :) = ants(tindex, :);
