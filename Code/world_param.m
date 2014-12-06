function [ x_Start,y_Start,x_Goal,y_Goal ] = world_param( img )
% Define the start and end goal coordinates of the world

figure();
imshow(img);
[ x1,y1 ] = ginput(1);
[ x2,y2 ] = ginput(1);

x_Start = round(x1);
y_Start = round(y1);

x_Goal = round(x2);
y_Goal = round(y2);


end

