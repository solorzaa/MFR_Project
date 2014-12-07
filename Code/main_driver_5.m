% MATHEMATICS FUNDAMENTALS FOR ROBOTICS
%
% PROJECT: Shadow Traverse Rovers
% Authors:
%   Ander Solorzano
%   Ben Chaffee
%
% Date: Fall 2014
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Clear all variables and screen
%
function main_driver_5(P_map,start_pt,goal_pt)
Map=P_map;
x1=start_pt(1,1);
y1=-start_pt(1,2);
xgoal=goal_pt(1,1);
ygoal=-goal_pt(1,2);
clc;
Power=30;
P_cap=30;
P_regen=1;
Map(x1,-y1)=2; %The map for traversing
ImStuck=0; %If the robot is stuck (1=stuck)
D=-1; %A matrix containing the distances from the point to the goal
l=0; %Variable that counts loops until time out
%Path planning
while (x1~=xgoal || y1~=ygoal) && ImStuck==0 && Power>0 && l<3000;
    p=0;
    P_range=Power/P_regen; %Calulate range of movement based on available power
    %Checking points on the circumference of a circle created by range of movement
    while p<=P_range
        x=x1+p;
        y=y1+(P_range-p);
        if Map(x,-y)==-1 || Map(x,-y)==2 %Points that are inside the shadows are set to a distance of infinity
            if D==-1
                D=[inf;x;y];
            else
                D=[D,[inf;x;y]];
            end
        else
            if D==-1
                D=[sqrt((xgoal-x)^2+(ygoal-y)^2);x;y];
            else
                D=[D,[sqrt((xgoal-x)^2+(ygoal-y)^2);x;y]];
            end
        end
        x=x1-p;
        y=y1-(P_range-p);
        if Map(x,-y)==-1 || Map(x,-y)==2
            D=[D,[inf;x;y]];
        else
            D=[D,[sqrt((xgoal-x)^2+(ygoal-y)^2);x;y]];
        end
        x=x1-p;
        y=y1+(P_range-p);
        if Map(x,-y)==-1 || Map(x,-y)==2
            D=[D,[inf;x;y]];
        else
            D=[D,[sqrt((xgoal-x)^2+(ygoal-y)^2);x;y]];
        end
        x=x1+p;
        y=y1-(P_range-p);
        if Map(x,-y)==-1 || Map(x,-y)==2
            D=[D,[inf;x;y]];
        else
            D=[D,[sqrt((xgoal-x)^2+(ygoal-y)^2);x;y]];
        end
        p=p+1;
    end
    [Dmin,dmin]=min(D(1,:)); %Finding which point is the closest to the goal
    if Dmin~=inf %Setting the point for the step
        x0=x1;
        y0=y1;
        x1=D(2,dmin);
        y1=D(3,dmin);
    else
    ImStuck=1; %The robot is stuck
    fprintf('Im Stuck :(\n')
    end
    while x0~=x1 || y0~=y1; %ploting a path to the selected point
        if x0<x1
            x0=x0+1;
        end
        if x0>x1
            x0=x0-1;
        end
        if y0>y1
            y0=y0-1;
        end
        if y0<y1
            y0=y0+1;
        end
        p_out=robot_power_consumption(Power,P_cap,P_regen,x0,-y0,P_map); %checking power lost during the step
        Power=p_out;
        Map(x0,-y0)=2; %Updating the map with the path
    end
    Map(x1,-y1)=2;
    l=l+1;
end
if l==3000 %The algorithm timed out
    fprintf('Timed Out...\n')
end
imshow(Map,[0,2]);