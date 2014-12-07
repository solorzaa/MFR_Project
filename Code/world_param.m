function [ startPt,goalPt,light_power,shadow_power ] = world_param( img )
% Define the start and end goal coordinates of the world
    
% OUTPUTS:
%   startPt = [xStart,yStart] = the starting x and y coordinates
%   goalPt  = [xGoal,yGoal]   = the goal x and y coordinates
%   light_power               = power that the robot gets in light
%   shadow_power              = power that the robot consumes in shadows

% Let the user enter the coordinates of the start and goal by clicking on
% the map
figure();
imshow(img);
[ y1,x1 ] = ginput(1);
[ y2,x2 ] = ginput(1);

x_Start = round(x1);
y_Start = round(y1);

startPt = [x_Start,y_Start];

x_Goal = round(x2);
y_Goal = round(y2);

goalPt = [x_Goal,y_Goal];

% Set the light and shadow power values
light_power = 1;
shadow_power = -1;

end

