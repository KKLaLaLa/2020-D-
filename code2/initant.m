function ants = initant(num, xl, xu)
% ��ʼ����Ⱥ
% num       input  ��������
% xl        input  x��С
% xu        input  x���
% yl        input  y��С
% yu        input  y���
% ants      output ��Ⱥ
ants = rand(num, 1);
ants(:,1) = xl + (xu - xl) .* ants(:,1);