function [T,D,flag] = direct_ack(mov_x,mov_y,...
    r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
    Vh,Vg,t,qy,plot_flag)
D = 0;
T = 0;
D_ = r1mov_x - mov_x;
flag = 0;
for j = 1 : 360/t
    [D_value,chooseG] = value_access(mov_x,mov_y,0,r1mov_x,r1mov_y,r2mov_x,r2mov_y,Vh,Vg,t);
    D = D+D_value;
    if j == 1
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
    
    
    needmov_x = Vh*t;
    mov_x = mov_x + needmov_x;

    %r1 move
    needr1mov_x = Vg * cos(anga1) * t;
    needr1mov_y = Vg * sin(anga1) * t;
    r1mov_x = r1mov_x - needr1mov_x;
    r1mov_y = r1mov_y - needr1mov_y;
    %r2 move
    needr2mov_x = Vg * cos(anga2) * t;
    needr2mov_y = Vg * sin(anga2) * t;
    r2mov_x = r2mov_x - needr2mov_x;
    r2mov_y = r2mov_y - needr2mov_y;
    if D < D_
        flag = 0;
    else
        if chooseG == 1
            dis = distance_cal(mov_x,mov_y,r1mov_x,r1mov_y);
        else
            dis = distance_cal(mov_x,mov_y,r2mov_x,r2mov_y);
        end
        if dis < 0.43
            flag = 0;
            break
        else
            flag = 1;
            continue
        end
    end
    if mov_x > max(r1mov_x,r2mov_x)
        T = j;
        break
    end
    if mov_x < 0
        flag = 0;
        break
    end
    if mov_x >qy
        flag = 0;
        break
    end
    if plot_flag == 1
        if flag == 1
            plot(mov_x,mov_y,'b.','MarkerSize',5)
            hold on
            plot(r1mov_x,r1mov_y,'r.','MarkerSize',5)
            hold on
            plot(r2mov_x,r2mov_y,'r.','MarkerSize',5)
            hold on
        else
        end
    else
        
    end
    
end

