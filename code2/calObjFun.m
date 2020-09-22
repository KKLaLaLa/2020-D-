function objval = calObjFun(X,g)
% ����Ŀ�꺯��ֵ
% X         input  ������ [x, y] nx2
% objvalue  output ��� nx1
[M_num,~] = size(X);
[~,caul_num] = size(g);
objval = zeros(M_num,1);
for i = 1:M_num
    for j = 1:caul_num
        if abs(g(1,j)-g(2,j)) < 0.03
            continue
        end
        objval(i) = objval(i)+find_newmin(X(i),g(1,j),g(2,j));
    end
    objval(i);
    i;
end
objval = objval/caul_num;
    
