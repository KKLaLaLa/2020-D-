function [T,flag] = round_ack2(mov_x,mov_y,...
    r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
    Vh,Vg,t,qy,angle,plot_flag)
turn_flag = 1;T = 0;T1 = 0;

flag = 0;
%figure
for i = 1:360/t
    %b move
    d1 = distance_cal(r1mov_x,r1mov_y,mov_x,mov_y);
    d2 = distance_cal(r2mov_x,r2mov_y,mov_x,mov_y);
    if d1 < 0.48
        flag = 0;
        break
    end
    if d2 < 0.48
        flag = 0;
        break
    end
    if d1 > d2
        turn_angle = ang(mov_x,mov_y,r1mov_x,r1mov_y);
    else
        turn_angle = ang(mov_x,mov_y,r2mov_x,r2mov_y);
    end
    if (2*pi*0.3*Vg)/Vh*i >1 
        if turn_flag == 1
            [mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,TD1] = round_forward(mov_x,mov_y,...
                r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
                Vh,Vg,t,qy,plot_flag);
            turn_flag = 0;
        end
    end
    if turn_flag == 0
        [flag,mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y,TD2] = round_ack3(mov_x,mov_y,...
            r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
            Vh,Vg,t,qy,plot_flag);
        if flag == 1
            break
        end
    end
    T = i + TD1+TD2;
end
