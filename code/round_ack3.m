function [T,flag, mov_x,mov_y,r1mov_x,r1mov_y,r2mov_x,r2mov_y] = round_ack3(mov_x,mov_y,...
r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
Vh,Vg,t,qy,plot_flag)
flag = 0;
bais = 4;
angle = 0;T = 0;
%best_qu = 0;
%figure
y_dis1 = abs((qy - r1mov_y)/qy);
y_dis2 = abs((r1mov_y - r2mov_y)/qy);
y_dis3 = abs(r2mov_y/qy);
dead1 = 0;
dead2 = 0;
[~,best_qu] = max([y_dis1,y_dis2,y_dis3]);
for i = 1:360/t
    %b move
    if mov_x > max(r1mov_x ,r2mov_x)
        flag = 1;
        T=i;
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
            if best_qu == 2
                des_x = r2mov_x;
                des_y = r2mov_y+bais;
                angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
            end
            if best_qu == 3
                des_x = r2mov_x;
                des_y = r2mov_y-bais;
                angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
            end
        else
            if best_qu == 1
                des_x = r1mov_x;
                des_y = r1mov_y+bais;
                angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                
            end
            if best_qu == 2
                des_x = r1mov_x;
                des_y = r1mov_y-bais;
                angle = angleBjudge(Vh,t,angle,des_x,des_y,mov_x,mov_y);
                
            end
        end
        
        if dead1 == 1
            angle = 0;
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
            flag = 1;
            dead1 = 1;
        end
        needr1mov_x = Vg * cos(anga1) * t;
        needr1mov_y = Vg * sin(anga1) * t;
        r1mov_x = r1mov_x - needr1mov_x;
        r1mov_y = r1mov_y - needr1mov_y;
        %r2 move
        if r2mov_x < mov_x
            flag = 1;
            dead2 = 1;
        end
        needr2mov_x = Vg * cos(anga2) * t;
        needr2mov_y = Vg * sin(anga2) * t;
        r2mov_x = r2mov_x - needr2mov_x;
        r2mov_y = r2mov_y - needr2mov_y;
        
        %     if d1 < 1
        %         if r1mov_x > mov_x
        %             if whether_p1 < p_judge1
        %                 angab_t = judge_turn(d1,vb,vr,t,...
        %                     mov_x,mov_y,r1mov_x,r1mov_y,anga1);
        %                 turn1_flag = 1;
        %             end
        %         end
        %     end
        if plot_flag == 1
            plot(mov_x,mov_y,'b*','MarkerSize',5)
            hold on
            plot(r1mov_x,r1mov_y,'r.','MarkerSize',5)
            hold on
            plot(r2mov_x,r2mov_y,'r.','MarkerSize',5)
            hold on
        else
        end
    end
    
end
end

