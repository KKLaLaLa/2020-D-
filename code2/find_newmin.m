function return_flag = find_newmin(M,g1,g2)
qy = M;qx = 50;
t = 0.5; %最小单位处理时间
Vg = 0.2;
Vh = 0.25;
whether_plot = 0;
%figure
G1x = qx;G1y = qy*g1;
G2x = qx;G2y = qy*g2;
mov_x = 0;mov_y = qy/2;

r1mov_x = G1x;r1mov_y = G1y;
r2mov_x = G2x;r2mov_y = G2y;

k = 1;
[~,~,ways1] = direct_ack(mov_x,mov_y,...
       r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
       Vh,Vg,t,qy,whether_plot);
if ways1 == 1
    return_flag = 1;
else
    [~,~,~,~,ways2] = turn_ack(mov_x,mov_y,...
        r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
        Vh,Vg,t,qy,whether_plot);
    if ways2 == 1
        return_flag = 1;
    else
        [~,ways3] = round_back(mov_x,mov_y,...
            r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
            Vh,Vg,t,qy,0,whether_plot);
        if ways3 == 1
            %figure
            return_flag = 1;
            %disp('3')
        else
            return_flag = 0;
            %disp('4')
        end
    end
end
end

