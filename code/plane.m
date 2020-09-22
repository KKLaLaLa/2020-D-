clc;
clear;
t = 0.5; %最小单位处理时间
Vg = 0.2;
Vh = 0.25;
d1 = 0;
d2 = 0;
ang1 = 0;
ang2 = 0;
angh = 0;
qx = 50;
qy = 70;

G1x = qx;G1y = 50;
G2x = qx;G2y = 20;

num = 160000;
x =  round(rand(1,num)*100/2);
y =  round(rand(1,num)*qy);
direct_ackpo =  zeros(2,num);
turn_ackpo =  zeros(2,num);
anther_ackpo =  zeros(2,num);
round_ackpo =  zeros(2,num);

for i = 1:num
    x(i) = rand(1)*100/2;
    y(i) = rand(1)*qy;
    dis1 = distance_cal(x(i),y(i),G1x,G1y);
    dis2 = distance_cal(x(i),y(i),G2x,G2y);

    while dis1 <= 0.48 || dis2 <=0.48
        x(i) = rand(1)*100/2;
        y(i) = rand(1)*qy;
        dis1 = distance_cal(x(i),y(i),G1x,G1y);
        dis2 = distance_cal(x(i),y(i),G2x,G2y);
    end
end
k = 1;
t_all =  zeros(3,num);
whether_plot = 0;
for i = 1:num
   i
   mov_x = x(i);mov_y = y(i);
   %mov_x = 20;mov_y = 50;
   r1mov_x = G1x;r1mov_y = G1y;
   r2mov_x = G2x;r2mov_y = G2y;
   angle1 = ang(mov_x,mov_y,r1mov_x,r1mov_y);
   angle2 = ang(mov_x,mov_y,r2mov_x,r2mov_y);
   dis1 = distance_cal(mov_x,mov_y,r1mov_x,r1mov_y);
   dis2 = distance_cal(mov_x,mov_y,r2mov_x,r2mov_y);
   [T1,~,ways1] = direct_ack(mov_x,mov_y,...
       r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
       Vh,Vg,t,qy,whether_plot);
   if ways1 == 1
       t_all(1,i) = T1;
       direct_ackpo(1,k) = mov_x;
       direct_ackpo(2,k) = mov_y;
       k = k+1;
       ways1 = 0;
   else
       [T2,~,~,~,ways2] = turn_ack(mov_x,mov_y,...
           r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
           Vh,Vg,t,qy,whether_plot);
       if ways2 == 1
           t_all(2,i) = T2;
           turn_ackpo(1,k) = mov_x;
           turn_ackpo(2,k) = mov_y;
           ways2 = 0;
       else
           [T3,ways3] = round_back(mov_x,mov_y,...
               r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
               Vh,Vg,t,qy,0,whether_plot);
           if ways3 == 1
               t_all(3,i) = T3; 
               [T4,way4] = round_ack2(mov_x,mov_y,...
                   r1mov_x,r1mov_y,r2mov_x,r2mov_y,...
                   Vh,Vg,t,qy,0,whether_plot);
               t_all(3,i) = t_all(3,i) + T4;
               round_ackpo(1,k) = mov_x;
               round_ackpo(2,k) = mov_y;
               ways3 = 0;
           else
               anther_ackpo(1,k) = mov_x;
               anther_ackpo(2,k) = mov_y;
           end
       end
   end
end
% direct_ackpo_x = direct_ackpo(1,:);
% index = find(direct_ackpo_x~=0);
% direct_ackpo_x = direct_ackpo_x(index);
% direct_ackpo_y = direct_ackpo(2,index);
% 
% turn_ackpo_x = turn_ackpo(1,:);
% index = find(turn_ackpo_x~=0);
% turn_ackpo_x = turn_ackpo_x(index);
% turn_ackpo_y = turn_ackpo(2,index);
% 
% round_ackpo_x = round_ackpo(1,:);
% index = find(round_ackpo_x~=0);
% round_ackpo_x = round_ackpo_x(index);
% round_ackpo_y = round_ackpo(2,index);
% 
% anther_ackpo_x = anther_ackpo(1,:);
% index = find(anther_ackpo_x~=0);
% anther_ackpo_x = anther_ackpo_x(index);
% anther_ackpo_y = anther_ackpo(2,index);

title('进攻方策略分配');
xlabel('L');
ylabel('M');
plot(direct_ackpo(1,:),direct_ackpo(2,:),'b.','MarkerSize',5)
hold on
plot(turn_ackpo(1,:),turn_ackpo(2,:),'r.','MarkerSize',5)
hold on
plot(round_ackpo(1,:),round_ackpo(2,:),'g.','MarkerSize',5)
hold on
plot(anther_ackpo(1,:),anther_ackpo(2,:),'k.','MarkerSize',5)
hold on


