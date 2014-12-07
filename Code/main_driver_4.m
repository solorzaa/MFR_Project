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
function main_driver_4(P_map,start_pt,goal_pt)
Map=P_map;
x1=start_pt(1,1);
y1=-start_pt(1,2);
xgoal=goal_pt(1,1);
ygoal=-goal_pt(1,2);
clc;
Power=20;
P_cap=20;
P_regen=1;
Map(x1,-y1)=2;
ImStuck=0;
while (x1~=xgoal || y1~=ygoal) && ImStuck==0 && Power>0;
    d1=sqrt((xgoal-(x1+1))^2+(ygoal-y1)^2);
    d2=sqrt((xgoal-(x1))^2+(ygoal-(y1+1))^2);
    d3=sqrt((xgoal-(x1+1))^2+(ygoal-(y1+1))^2);
    d4=sqrt((xgoal-(x1-1))^2+(ygoal-y1)^2);
    d5=sqrt((xgoal-(x1))^2+(ygoal-(y1-1))^2);
    d6=sqrt((xgoal-(x1-1))^2+(ygoal-(y1-1))^2);
    d7=sqrt((xgoal-(x1-1))^2+(ygoal-y1+1)^2);
    d8=sqrt((xgoal-(x1+1))^2+(ygoal-(y1-1))^2);   
    PathShadow=[Map(-y1,(x1+1)),Map(-y1,(x1+1)),Map(-(y1+1),(x1+1)),Map(-y1,(x1-1)),Map(-(y1-1),x1),Map(-(y1-1),(x1-1)),Map((-y1+1),(x1-1)),Map(-(y1-1),(x1+1))];
    if PathShadow(1,1)==0 || PathShadow(1,1)==2
        d1=inf;
    end
    if PathShadow(1,2)==0 || PathShadow(1,2)==2
        d2=inf;
    end
    if PathShadow(1,3)==0 || PathShadow(1,3)==2
        d3=inf;
    end
    if PathShadow(1,4)==0 || PathShadow(1,4)==2
        d4=inf;
    end
    if PathShadow(1,5)==0 || PathShadow(1,5)==2
        d5=inf;
    end
    if PathShadow(1,6)==0 || PathShadow(1,6)==2
        d6=inf;
    end
    if PathShadow(1,7)==0 || PathShadow(1,7)==2
        d7=inf;
    end
    if PathShadow(1,8)==0 || PathShadow(1,8)==2
        d8=inf;
    end
    D=[d1,d2,d3,d4,d5,d6,d7,d8];
    [Dmin,dmin]=min(D);
    if Dmin~=inf
        if dmin==1 && (PathShadow(1,1)==-1 || PathShadow(1,1)==1);
            x1=x1+1;
        end
        if dmin==2 && (PathShadow(1,2)==-1 || PathShadow(1,2)==1);
            y1=y1+1;
        end
        if dmin==3 && (PathShadow(1,3)==-1 || PathShadow(1,3)==1);
            x1=x1+1;
            y1=y1+1;
        end
        if dmin==4 && (PathShadow(1,4)==-1 || PathShadow(1,4)==1);
            x1=x1-1;
        end
        if dmin==5 && (PathShadow(1,5)==-1 || PathShadow(1,5)==1);
            y1=y1-1;
        end
        if dmin==6 && (PathShadow(1,6)==-1 || PathShadow(1,6)==1);
            x1=x1-1;
            y1=y1-1;
        end
        if dmin==7 && (PathShadow(1,7)==-1 || PathShadow(1,7)==1);
            x1=x1-1;
            y1=y1+1;
        end
        if dmin==8 && (PathShadow(1,8)==-1 || PathShadow(1,8)==1);
            x1=x1+1;
            y1=y1-1;
        end
    else
    ImStuck=1;
    fprintf('Im Stuck :(\n')
    end
    Map(x1,-y1)=2;
    p_out=robot_power_consumption(Power,P_cap,P_regen,x1,-y1,P_map);
    Power=p_out;
end
imshow(Map,[0,2]);