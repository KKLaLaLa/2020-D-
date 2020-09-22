function ang2 = turn_back(angab,vb,t)
if angab > 0
    ang2_tmp = angab - 0;
    if ang2_tmp > vb*t/0.3
        ang2_tmp = vb*t/0.3;
    end
    ang2 = angab-ang2_tmp;
end
if angab < 0
    ang2_tmp = angab - 0;
    if ang2_tmp <- vb*t/0.3
        ang2_tmp = -vb*t/0.3;
    end
    ang2 = angab-ang2_tmp;
end
if angab == 0
    ang2 = angab;
end
end
