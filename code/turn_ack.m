function [mov_x,mov_y,angle,T,flag] = turn_ack(mov_x,mov_y,...
    r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
    Vh,Vg,t,qy,plot_flag)
flag = 0;
angle = 0;
angle_old = angle;
bais = 2;T = 0;
%best_qu = 0;
%figure
y_dis1 = abs((qy - r1mov_y)/qy);
y_dis2 = abs((r1mov_y - r2mov_y)/qy);
y_dis3 = abs(r2mov_y/qy);
flag1_end = 0;
flag2_end = 0;

[~,best_qu] = max([y_dis1,y_dis2,y_dis3]);
for i = 1:360/t
    %b move
    if mov_x > max(r1mov_x ,r2mov_x)
        flag = 1;
        T = i;
        break
    else
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
        
        if d1 < d2
            if flag1_end == 0
                if best_qu == 1
                    des_x = r1mov_x+bais;
                    des_y = r1mov_y+bais;
                    angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                end
                if best_qu == 2
                    des_x = r1mov_x+bais;
                    des_y = r1mov_y-bais;
                    angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                end
                if best_qu == 3
                    if r1mov_x - mov_x > 2
                        des_x = r2mov_x+bais;
                        des_y = r2mov_y-bais;
                        angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                    end
                end
            else
                angle = turn_back(angle,Vh,t);
            end
        else
            if flag2_end == 0
                if best_qu == 1
                    if r2mov_x - mov_x > 2
                        des_x = r1mov_x+bais;
                        des_y = r1mov_y+bais;
                        angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                    end
                end
                if best_qu == 2
                    des_x = r2mov_x+bais;
                    des_y = r2mov_y+bais;
                    angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                end
                if best_qu == 3
                    des_x = r2mov_x+bais;
                    des_y = r2mov_y-bais;
                    angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                end
            else
                angle = turn_back(angle,Vh,t);
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
            anga1 = anglerjudge(Vg,t,anga1,mov_x,mov_y,r1mov_x,r1mov_y);
            anga2 = anglerjudge(Vg,t,anga2,mov_x,mov_y,r2mov_x,r2mov_y);
        end
        %r move
        %r1 move
        if r1mov_x < mov_x
            flag1_end = 1;
        else
            needr1mov_x = Vg * cos(anga1) * t;
            needr1mov_y = Vg * sin(anga1) * t;
            r1mov_x = r1mov_x - needr1mov_x;
            r1mov_y = r1mov_y - needr1mov_y;
        end
        %r2 move
        if r2mov_x < mov_x
            flag2_end = 1;
        else
            needr2mov_x = Vg * cos(anga2) * t;
            needr2mov_y = Vg * sin(anga2) * t;
            r2mov_x = r2mov_x - needr2mov_x;
            r2mov_y = r2mov_y - needr2mov_y;
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
 %           if flag == 1
                plot(mov_x,mov_y,'b.','MarkerSize',5)
                hold on
                plot(r1mov_x,r1mov_y,'r.','MarkerSize',5)
                hold on
                plot(r2mov_x,r2mov_y,'r.','MarkerSize',5)
                hold on
 %           else
 %           end
        else
            
        end
    end
    
end

end

