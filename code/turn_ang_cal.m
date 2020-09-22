function turn_ang = turn_ang_cal(mov_x,mov_y,x,y,angel,Vh,Vg,t,plane)
next_angle = ang(mov_x,mov_y,x,y);
turn_ang = next_angle - angel;
if plane == 'r'
    if turn_ang > Vg*t/0.35
        turn_ang =Vg*t/0.35;
    else
        if turn_ang < -Vg*t/0.35
            turn_ang = -Vg*t/0.35;
        end
    end
end
if plane == 'b'
    if turn_ang > Vh*t/0.5
        turn_ang = Vh*t/0.5;
    else
        if turn_ang < -Vh*t/0.5
            turn_ang = -Vh*t/0.5;
        end
    end
end

end