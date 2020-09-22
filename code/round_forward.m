function [mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,T] = round_forward(mov_x,mov_y,...
    r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
    Vh,Vg,t,qy,plot_flag)
D = 0;T = 0;
flag = 0;
x = zeros(1,2);
y = zeros(1,2);

angle = pi;
db1 = qy - mov_y;
db2 = mov_y;
if db1 > db2
    turn_flag = 1;
else
    turn_flag = -1;
end
for i = 1:360/t
    %b move
    if turn_flag == -1
        angle = angle + Vh*t/0.5;
        if angle > 2*pi
            T = i;
            break;
        end
    else
        angle = angle - Vh*t/0.5;
        if angle < 0
            T = i;
            break;
        end
    end
    needmov_x = Vh*t*cos(angle);
    needmov_y = Vh*t*sin(angle);
    mov_x = mov_x + needmov_x;
    mov_y = mov_y + needmov_y;
    
    if i == 1
        anga1 = ang(mov_x,mov_y,r1mov_x,r1mov_y);
        anga2 = ang(mov_x,mov_y,r2mov_x,r2mov_y);
    else
        anga1_tmp = ang(mov_x,mov_y,r1mov_x,r1mov_y);
        anga2_tmp = ang(mov_x,mov_y,r2mov_x,r2mov_y);
        ang1_diff = anga1_tmp - anga1;
        ang2_diff = anga2_tmp - anga2;
        if ang1_diff >= 4*t/7
            ang1_diff = 4*t/7;
        end
        if ang1_diff <= -4*t/7
            ang1_diff = -4*t/7;
        end
        anga1 = anga1 + ang1_diff;
        if ang2_diff >= 4*t/7
            ang2_diff = 4*t/7;
        end
        if ang2_diff <= -4*t/7
            ang2_diff = -4*t/7;
        end
        anga2 = anga2 + ang2_diff;
    end
    
    %r move
    anga1 = ang(mov_x,mov_y,r1mov_x,r1mov_y);
    anga2 = ang(mov_x,mov_y,r2mov_x,r2mov_y);
    %r1 move
    if r1mov_x < mov_x
        
    else
        needr1mov_x = Vg * cos(anga1) * t;
        needr1mov_y = Vg * sin(anga1) * t;
        r1mov_x = r1mov_x - needr1mov_x;
        r1mov_y = r1mov_y - needr1mov_y;
    end
    %r2 move
    if r2mov_x < mov_x
        
    else
        needr2mov_x = Vg * cos(anga2) * t;
        needr2mov_y = Vg * sin(anga2) * t;
        r2mov_x = r2mov_x - needr2mov_x;
        r2mov_y = r2mov_y - needr2mov_y;
    end
    if plot_flag == 1
        plot(mov_x,mov_y,'bo','MarkerSize',5)
        hold on
        plot(r1mov_x,r1mov_y,'r.','MarkerSize',5)
        hold on
        plot(r2mov_x,r2mov_y,'r.','MarkerSize',5)
        hold on
    else
        
    end
end
