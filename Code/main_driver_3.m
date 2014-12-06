% MATHEMATICS FUNDAMENTALS FOR ROBOTICS
%
% PROJECT: Shadow Traverse Rovers
% Authors:
%   Ander Solorzano
%   Ben Chaffe
%
% Date: Fall 2014
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Clear all variables and screen
%
function main_driver_3
clear all variables;
clc;

%Greedy Best-Fit Search Test
% Map=[1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1;1,1,1,0,0,0,0,1,1,1;1,1,1,0,0,0,0,1,1,1;1,1,1,0,0,0,0,1,1,1;1,1,1,0,0,0,0,1,1,1;1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1];
Map=ones(500);
ObstNum=0;
while ObstNum<500
    x=round(rand(1,1)*499)+1;
    y=round(rand(1,1)*499)+1;
    Map(x,y)=0;
    ObstNum=ObstNum+1;
end
%Random end point
xgoal=round(rand(1,1)*499)+1;
ygoal=-round(rand(1,1)*499)+1;
%Random start point
x1=round(rand(1,1)*99)+1;
y1=-round(rand(1,1)*99)+1;
% %End point: Map(1,10) (y=-1, x=10)
% xgoal=10;
% ygoal=-1;
% %Start point: Map(10,1) (y=-10, x=1)
% x1=1;
% y1=-10;
Map(-y1,x1)=2;
Path=[x1;y1];
while x1~=xgoal || y1~=ygoal
    xdir=xgoal-x1;
    if xdir>0
        xstep=1;
    elseif xdir<0
        xstep=-1;
    else
        xstep=0;
    end    
    ydir=ygoal-y1;
    if ydir>0
        ystep=1;
    elseif ydir<0
        ystep=-1;
    else
        ystep=0;
    end  
    d1=sqrt((xgoal-(x1+xstep))^2+(ygoal-y1)^2);
    d2=sqrt((xgoal-(x1))^2+(ygoal-(y1+ystep))^2);
    d3=sqrt((xgoal-(x1+xstep))^2+(ygoal-(y1+ystep))^2);
    Path1=0;
    Path2=0;
    Path3=0;
    if Map(-y1,(x1+xstep))~=1
       Path1=1;
       d1=inf;
    end
    if Map(-(y1+ystep),x1)~=1
        Path2=1;
        d2=inf;
    end
    if Map(-(y1+ystep),(x1+xstep))~=1
        Path3=1;
        d3=inf;
    end
    D=[d1,d2,d3];
    [Dmin,dmin]=min(D);
    if Dmin~=inf
        if dmin==1 && Path1~=1;
            x1=x1+xstep;
        end
        if dmin==2 && Path2~=1;
            y1=y1+ystep;
        end
        if dmin==3 && Path3~=1;
            x1=x1+xstep;
            y1=y1+ystep;
        end
    else
        
    end
    Path=[Path,[x1;y1]];
    Map(-y1,x1)=2;
end
imshow(Map,[0,2]);