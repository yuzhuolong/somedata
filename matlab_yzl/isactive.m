function flag = isactive( segment )
%isactive 判断一个segment是否是活动的segment，如果该segment被认为是活动则返回1，如果被认为是静止则返回0
%   此处显示详细说明
flag=0;
max_x=-100;
min_x=100;
max_y=-100;
min_y=100;
max_z=-100;
min_z=100;
for i=1:1:size(segment,1)
    x=segment(i,1);
    y=segment(i,2);
    z=segment(i,3);
    if x>max_x
        max_x=x;
    end
    if x<min_x
        min_x=x;
    end
    if y>max_y
        max_y=y;
    end
    if y<min_y
        min_y=y;
    end
    if z>max_z
        max_z=z;
    end
    if z<min_z
        min_z=z;
    end
    if max_x-min_x>15 || max_y-min_y>15 || max_z-min_z>15
        flag=1;
        return
    end;
end

end

