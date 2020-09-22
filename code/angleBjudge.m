function angle = angleBjudge(vb,t,last_angle,des_x,des_y,mov_x,mov_y)
angle_t = ang(des_x,des_y,mov_x,mov_y);
angab_tmp =angle_t - last_angle;
if angab_tmp >= vb*t/0.3
    angab_tmp = vb*t/0.3;
end
if angab_tmp <= -vb*t/0.3
    angab_tmp = -vb*t/0.3;
end
angle = last_angle + angab_tmp;
