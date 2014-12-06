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
function main_driver_5(Map,x1,y1,xgoal,ygoal)
clc;
y1=-y1;
ygoal=-ygoal;
Map(-y1,x1)=2;
Path=[x1;y1];
yo=-1;
xo=-1;
yr=-1;
xr=-1;
ImStuck=0;
ShadowMode=0;
while (x1~=xgoal || y1~=ygoal) && ImStuck==0;
    d1=sqrt((xgoal-(x1+1))^2+(ygoal-y1)^2);
    d2=sqrt((xgoal-(x1))^2+(ygoal-(y1+1))^2);
    d3=sqrt((xgoal-(x1+1))^2+(ygoal-(y1+1))^2);
    d4=sqrt((xgoal-(x1-1))^2+(ygoal-y1)^2);
    d5=sqrt((xgoal-(x1))^2+(ygoal-(y1-1))^2);
    d6=sqrt((xgoal-(x1-1))^2+(ygoal-(y1-1))^2);
    d7=sqrt((xgoal-(x1-1))^2+(ygoal-y1+1)^2);
    d8=sqrt((xgoal-(x1+1))^2+(ygoal-(y1-1))^2);   
    PathShadow=[Map(-y1,(x1+1)),Map(-(y1+1),x1),Map(-(y1+1),(x1+1)),Map(-y1,(x1-1)),Map(-(y1-1),x1),Map(-(y1-1),(x1-1)),Map((-y1+1),(x1-1)),Map(-(y1-1),(x1+1))];
    if ShadowMode==0;
        if (y1==yo && (x1+1)==xo) || (y1==yr && (x1+1)==xr)
           d1=inf;
        end
        if ((y1+1)==yo && x1==xo) || ((y1+1)==yo && x1==xr)
            d2=inf;
        end
        if ((y1+1)==yo && (x1+1)==xo) || ((y1+1)==yr && (x1+1)==xr)
            PathShadow(1,3)=0;
            d3=inf;
        end
        if (y1==yo && (x1-1)==xo) || (y1==yr && (x1-1)==xr)
           PathShadow(1,4)=0;
           d4=inf;
        end
        if ((y1-1)==yo && x1==xo) || ((y1-1)==yr && x1==xr)
            PathShadow(1,5)=0;
            d5=inf;
        end
        if ((y1-1)==yo && (x1-1)==xo) || ((y1-1)==yr && (x1-1)==xr)
            PathShadow(1,6)=0;
            d6=inf;
        end
        if ((y1+1)==yo && (x1-1)==xo) || ((y1+1)==yr && (x1-1)==xr)
           PathShadow(1,7)=0;
           d7=inf;
        end
        if ((y1-1)==yo && (x1+1)==xo) || ((y1-1)==yr && (x1+1)==xr)
            PathShadow(1,8)=0;
            d8=inf;
        end
        D=[d1,d2,d3,d4,d5,d6,d7,d8];
        [Dmin,dmin]=min(D);
        if Dmin~=inf
            if dmin==1 && PathShadow(1,1)~=0;
                x1=x1+1;
            end
            if dmin==2 && PathShadow(1,2)~=0;
                y1=y1+1;
            end
            if dmin==3 && PathShadow(1,3)~=0;
                x1=x1+1;
                y1=y1+1;
            end
            if dmin==4 && PathShadow(1,4)~=0;
                x1=x1-1;
            end
            if dmin==5 && PathShadow(1,5)~=0;
                y1=y1-1;
            end
            if dmin==6 && PathShadow(1,6)~=0;
                x1=x1-1;
                y1=y1-1;
            end
            if dmin==7 && PathShadow(1,6)~=0;
                x1=x1-1;
                y1=y1+1;
            end
            if dmin==8 && PathShadow(1,6)~=0;
                x1=x1+1;
                y1=y1-1;
            end
        else
        ImStuck=1;
        fprintf('Im Stuck :(\n')
        end
    end
%     Path=[Path,[x1;y1]];
    xr=x1;
    yr=y1;
    xo=x1;
    yo=y1;
    Map(-y1,x1)=2;
end
imshow(Map,[0,2]);