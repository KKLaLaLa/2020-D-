function angle = v_ang(turn_ang,V,mov_x,mov_y,x,y)
dis_ang = ang(mov_x,mov_y,x,y)
angle = turn + dis_ang;
end