function [value,chooseG] = value_access(mov_x,mov_y,angb,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t)

[max_GD,chooseG] = d1d2max(mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vg,t);
if angb < 0
    if angb < -pi/2
        DH = Vh*t*cos(angb);
    else
        DH = -Vh*t*cos(angb);
    end
else
    if angb > pi/2
        DH = -Vh*t*cos(angb);
    else
        DH = Vh*t*cos(angb);
    end
end
value =max_GD + DH;



