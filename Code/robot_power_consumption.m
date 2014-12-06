function [ P_out ] = robot_power_consumption( P_in,P_cap,P_regen,xPos,yPos,P_map )
% Computes the power consumption of the robot when it goes through shadows
% or ligth regions.

%   INPUTS:
%       P_in    = the power left in the robot at its current position
%       P_cap   = the maximum power capacity of the robot
%       P_regen = the regeneration rate of power in a light region
%       xPos    = the current x-coordinate position of the robot
%       yPos    = the current y-coordinate position of the robot
%       P_map   = the cost image matrix of the world

%   OUTPUTS:
%       P_out   = the remaining power at its current position


% Check to see if the robot has more power than it can hold
if (P_in > P_cap)
    fprintf('Robot power BLEW UP!!!\n');
end

% Check if the robot is in a light regions
if(P_map(xPos,yPos) == 1)
    % Check if the robot has max power capacity
    % If it is, output the maximum power
    if(P_in == P_cap)
        P_out = P_cap;
    else
    % If it is not, increase the power by the cell value
    P_out = P_in + P_map(xPos,yPos)*P_regen;
    end

% If the robot is in a shadow region subtract 1
else
    P_out = P_in - P_map(xPos,yPos);
end

% Check to see if the robot is out of power
if (P_out <= 0)
    fprintf('ROBOT IS OUT OF POWER!!!\n');
end

% end robot_power_consumption
end

