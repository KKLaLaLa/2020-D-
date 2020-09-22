function [dis,flag] = d1d2max(xh,yh,x1,y1,x2,y2,vg,t)
ang1 = atan((y1-yh)/(x1-xh));
ang2 = atan((y2-yh)/(x2-xh));
% if ang1 > 0
%     if ang1 > pi/2
%         a = cos(ang1)*vg*t;

a = cos(ang1)*vg*t;
b = cos(ang2)*vg*t;

max_value = max(a,b);

if max_value == a
    dis = a;
    flag = 1;
else
    dis = b;
    flag = 2;
end